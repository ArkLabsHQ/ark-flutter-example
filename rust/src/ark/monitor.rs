use crate::api::ark_api::{InvoiceEvent, InvoiceEventStatus};
use crate::state::{ARK_CLIENT, INVOICE_STREAM_SINK, SWAP_STORAGE};
use ark_client::swap_storage::SwapStorage;
use ark_client::{ReverseSwapData, SwapStatus};
use std::sync::Arc;
use std::time::{SystemTime, UNIX_EPOCH};

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
