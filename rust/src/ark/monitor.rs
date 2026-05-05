use crate::api::ark_api::{InvoiceEvent, InvoiceEventStatus, PaymentEvent};
use crate::state::{ARK_CLIENT, INVOICE_STREAM_SINK, PAYMENT_STREAM_SINK, SWAP_STORAGE};
use ark_client::swap_storage::SwapStorage;
use ark_client::{ReverseSwapData, SwapStatus};
use ark_core::server::SubscriptionResponse;
use futures::StreamExt;
use std::sync::Arc;
use std::time::{Duration, SystemTime, UNIX_EPOCH};

const DEFAULT_INVOICE_EXPIRY_SECS: u64 = 3600;

fn now_secs() -> u64 {
    SystemTime::now()
        .duration_since(UNIX_EPOCH)
        .map(|d| d.as_secs())
        .unwrap_or_default()
}

fn is_expired(swap: &ReverseSwapData) -> bool {
    let expiry = swap.invoice_expiry.unwrap_or(DEFAULT_INVOICE_EXPIRY_SECS);
    now_secs() > swap.created_at.saturating_add(expiry)
}

fn is_pending(status: &SwapStatus) -> bool {
    !matches!(
        status,
        SwapStatus::TransactionClaimed
            | SwapStatus::InvoiceExpired
            | SwapStatus::SwapExpired
            | SwapStatus::TransactionRefunded
            | SwapStatus::TransactionFailed
            | SwapStatus::InvoiceFailedToPay
    )
}

/// Load all reverse swaps from storage and spawn a watcher per pending+unexpired invoice.
/// Called on wallet load.
pub async fn start_monitor() {
    let storage = match SWAP_STORAGE.try_get() {
        Some(s) => Arc::clone(&*s.read()),
        None => {
            tracing::warn!("start_monitor: swap storage not initialized");
            return;
        }
    };

    let swaps = match storage.list_all_reverse().await {
        Ok(s) => s,
        Err(e) => {
            tracing::warn!(error = %e, "start_monitor: failed to list reverse swaps");
            return;
        }
    };

    for swap in swaps {
        if !is_pending(&swap.status) {
            continue;
        }
        if is_expired(&swap) {
            emit(InvoiceEvent::from_swap(&swap, InvoiceEventStatus::Expired));
            continue;
        }
        watch(swap);
    }
}

/// Spawn a background watcher for a single reverse swap. Used both by the
/// startup monitor and by `lightning_invoice()` for newly created invoices.
pub fn watch(swap: ReverseSwapData) {
    tokio::spawn(async move {
        let swap_id = swap.id.clone();

        let client = match ARK_CLIENT.try_get() {
            Some(c) => Arc::clone(&*c.read()),
            None => {
                tracing::warn!(swap_id, "watch: client not initialized");
                return;
            }
        };

        // wait_for_vhtlc waits for the invoice to be paid AND claims the VHTLC.
        // Funds are only usable after the claim, so this is what we surface as
        // "paid" to the UI.
        match client.wait_for_vhtlc(&swap_id).await {
            Ok(result) => {
                tracing::info!(
                    swap_id,
                    amount_sats = result.claim_amount.to_sat(),
                    "Reverse swap paid + claimed"
                );
                emit(InvoiceEvent::from_swap(&swap, InvoiceEventStatus::Paid));
            }
            Err(e) => {
                tracing::warn!(swap_id, error = %e, "wait_for_vhtlc failed");
                let status = if is_expired(&swap) {
                    InvoiceEventStatus::Expired
                } else {
                    InvoiceEventStatus::Failed
                };
                emit(InvoiceEvent::from_swap(&swap, status));
            }
        }
    });
}

fn emit(event: InvoiceEvent) {
    let Some(sink) = INVOICE_STREAM_SINK.try_get() else {
        // No subscriber yet — event drops. The DB still has the up-to-date
        // status (via SDK) and start_monitor() on next launch re-emits.
        return;
    };
    let sink = sink.read().clone();
    if let Err(e) = sink.add(event) {
        tracing::warn!(error = ?e, "Failed to push invoice event to sink");
    }
}

fn emit_payment(event: PaymentEvent) {
    let Some(sink) = PAYMENT_STREAM_SINK.try_get() else {
        return;
    };
    let sink = sink.read().clone();
    if let Err(e) = sink.add(event) {
        tracing::warn!(error = ?e, "Failed to push payment event to sink");
    }
}

/// Subscribe to the wallet's offchain Ark addresses and emit a [`PaymentEvent`]
/// for each new VTXO that lands. Spawns a background task with reconnection
/// backoff. Called once after wallet load.
pub async fn start_address_monitor() {
    tokio::spawn(address_monitor_loop());
}

async fn address_monitor_loop() {
    const INITIAL_BACKOFF: Duration = Duration::from_secs(1);
    const MAX_BACKOFF: Duration = Duration::from_secs(30);
    let mut backoff = INITIAL_BACKOFF;

    loop {
        let client = match ARK_CLIENT.try_get() {
            Some(c) => Arc::clone(&*c.read()),
            None => {
                tracing::warn!("address monitor: client not initialized");
                tokio::time::sleep(backoff).await;
                backoff = (backoff * 2).min(MAX_BACKOFF);
                continue;
            }
        };

        let addresses = match client.get_offchain_addresses() {
            Ok(a) => a,
            Err(e) => {
                tracing::warn!(error = %e, "address monitor: failed to get offchain addresses");
                tokio::time::sleep(backoff).await;
                backoff = (backoff * 2).min(MAX_BACKOFF);
                continue;
            }
        };

        if addresses.is_empty() {
            tokio::time::sleep(backoff).await;
            continue;
        }

        let scripts = addresses.iter().map(|(addr, _)| *addr).collect::<Vec<_>>();

        let subscription_id = match client.subscribe_to_scripts(scripts, None).await {
            Ok(id) => id,
            Err(e) => {
                tracing::warn!(error = %e, "address monitor: subscribe_to_scripts failed");
                tokio::time::sleep(backoff).await;
                backoff = (backoff * 2).min(MAX_BACKOFF);
                continue;
            }
        };

        let mut stream = match client.get_subscription(subscription_id.clone()).await {
            Ok(s) => s,
            Err(e) => {
                tracing::warn!(error = %e, "address monitor: get_subscription failed");
                tokio::time::sleep(backoff).await;
                backoff = (backoff * 2).min(MAX_BACKOFF);
                continue;
            }
        };

        tracing::info!("Address monitor connected");
        backoff = INITIAL_BACKOFF;

        while let Some(item) = stream.next().await {
            match item {
                Ok(SubscriptionResponse::Heartbeat) => {}
                Ok(SubscriptionResponse::Event(event)) => {
                    if event.new_vtxos.is_empty() {
                        continue;
                    }
                    let total_sats: u64 = event.new_vtxos.iter().map(|v| v.amount.to_sat()).sum();
                    if total_sats == 0 {
                        continue;
                    }
                    tracing::info!(
                        txid = %event.txid,
                        amount_sats = total_sats,
                        "Address received new VTXO(s)"
                    );
                    emit_payment(PaymentEvent {
                        txid: event.txid.to_string(),
                        amount_sats: total_sats,
                    });
                }
                Err(e) => {
                    tracing::warn!(error = %e, "address subscription stream error");
                    break;
                }
            }
        }

        tracing::info!("Address monitor stream ended; reconnecting");
        tokio::time::sleep(backoff).await;
        backoff = (backoff * 2).min(MAX_BACKOFF);
    }
}
