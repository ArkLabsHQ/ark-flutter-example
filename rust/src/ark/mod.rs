mod address_helper;
pub mod client;
pub mod esplora;
pub mod monitor;
mod seed_file;
pub mod storage;

use crate::ark::esplora::EsploraClient;
use crate::ark::seed_file::{read_seed_file, reset_wallet, write_seed_file};
use crate::ark::storage::InMemoryDb;
use crate::state::{ARK_CLIENT, SWAP_STORAGE};
use anyhow::{anyhow, bail, Result};
use ark_client::{Bip32KeyProvider, OfflineClient};
use bitcoin::bip32::Xpriv;
use bitcoin::key::Secp256k1;
use bitcoin::secp256k1::All;
use bitcoin::Network;
use nostr::Keys;
use parking_lot::RwLock;
use rand::RngCore;
use std::sync::Arc;
use std::time::Duration;

pub async fn setup_new_wallet(
    data_dir: String,
    network: Network,
    esplora: String,
    server: String,
    boltz_url: String,
) -> Result<String> {
    crate::init_crypto_provider();
    let secp = Secp256k1::new();
    let mut random_bytes = [0u8; 32];
    rand::thread_rng().fill_bytes(&mut random_bytes);
    let xpriv = Xpriv::new_master(network, &random_bytes)
        .map_err(|e| anyhow!("Failed to create xprv from nsec: {}", e))?;

    write_seed_file(&xpriv, &data_dir).map_err(|e| anyhow!("Failed to write seed file: {}", e))?;
    let swap_storage = format!("{}/swap_storage.sql", data_dir).to_string();

    let pubkey = setup_client(
        xpriv,
        secp,
        network,
        esplora.clone(),
        server.clone(),
        boltz_url.clone(),
        swap_storage
    )
    .await
    .map_err(|e| {
        anyhow!(
            "Failed to setup client - Network: {:?}, Esplora: {}, Server: {}, Boltz: {} - Error: {}",
            network,
            esplora,
            server,
            boltz_url,
            e
        )
    })?;
    Ok(pubkey)
}

pub async fn restore_wallet(
    nsec: String,
    data_dir: String,
    network: Network,
    esplora: String,
    server: String,
    boltz_url: String,
) -> Result<String> {
    crate::init_crypto_provider();
    let secp = Secp256k1::new();
    let keys =
        Keys::parse(nsec.as_str()).map_err(|e| anyhow!("Failed to parse nsec key: {}", e))?;
    let xprv = Xpriv::new_master(network, keys.secret_key().as_secret_bytes())
        .map_err(|e| anyhow!("Failed to create xprv from nsec: {}", e))?;
    write_seed_file(&xprv, &data_dir).map_err(|e| anyhow!("Failed to write seed file: {}", e))?;
    let swap_storage = format!("{}/swap_storage.sql", data_dir).to_string();

    let pubkey = setup_client(xprv, secp, network, esplora.clone(), server.clone(), boltz_url, swap_storage).await
        .map_err(|e| anyhow!("Failed to setup client after restore - Network: {:?}, Esplora: {}, Server: {} - Error: {}", network, esplora, server, e))?;
    Ok(pubkey)
}

pub(crate) async fn load_existing_wallet(
    data_dir: String,
    network: Network,
    esplora: String,
    server: String,
    boltz_url: String,
) -> Result<String> {
    crate::init_crypto_provider();
    let maybe_sk = read_seed_file(data_dir.as_str())
        .map_err(|e| anyhow!("Failed to read seed file from '{}': {}", data_dir, e))?;
    let swap_storage = format!("{}/swap_storage.sql", data_dir).to_string();

    match maybe_sk {
        None => {
            bail!("No seed file found in directory: {}", data_dir)
        }
        Some(xprv) => {
            let secp = Secp256k1::new();
            let server_pk = setup_client(xprv, secp, network, esplora.clone(), server.clone(), boltz_url, swap_storage).await
                .map_err(|e| anyhow!("Failed to setup client from existing wallet - Network: {:?}, Esplora: {}, Server: {} - Error: {}", network, esplora, server, e))?;
            Ok(server_pk)
        }
    }
}

pub async fn setup_client(
    xprv: Xpriv,
    secp: Secp256k1<All>,
    network: Network,
    esplora_url: String,
    server: String,
    boltz_url: String,
    swap_storage_path: String,
) -> Result<String> {
    // TODO: use persistent db here
    let db = InMemoryDb::default();

    let wallet =
        ark_bdk_wallet::Wallet::new_from_xpriv(xprv, secp, network, esplora_url.as_str(), db)
            .map_err(|e| anyhow!("Failed to create wallet: {}", e))?;

    let wallet = Arc::new(wallet);
    let esplora = EsploraClient::new(esplora_url.as_str()).map_err(|e| {
        anyhow!(
            "Failed to create Esplora client for URL '{}': {}",
            esplora_url,
            e
        )
    })?;
    tracing::info!("Checking esplora connection");

    esplora
        .check_connection()
        .await
        .map_err(|e| anyhow!("Failed to connect to Esplora at '{}': {}", esplora_url, e))?;

    let swap_storage =
        Arc::new(ark_client::swap_storage::SqliteSwapStorage::new(swap_storage_path).await?);

    tracing::info!("Connecting to Ark");
    let client = OfflineClient::<_, _, _, Bip32KeyProvider>::new_with_bip32(
        "sample-client".to_string(),
        xprv,
        None,
        Arc::new(esplora),
        wallet,
        server.clone(),
        Arc::clone(&swap_storage),
        boltz_url,
        Duration::from_secs(30),
        None,
        vec![],
    )
    .connect()
    .await
    .map_err(|err| anyhow!("Failed to connect to Ark server at '{}': {}", server, err))?;

    let info = client.server_info.clone();

    ARK_CLIENT.set(RwLock::new(Arc::new(client)));

    match SWAP_STORAGE.try_get() {
        Some(s) => *s.write() = swap_storage,
        None => {
            SWAP_STORAGE.set(RwLock::new(swap_storage));
        }
    }

    // Resume monitoring any pending invoices created in past sessions.
    crate::ark::monitor::start_monitor().await;

    // Subscribe to incoming payments on offchain Ark addresses.
    crate::ark::monitor::start_address_monitor().await;

    tracing::info!(server_pk = ?info.signer_pk, "Connected to server");

    Ok(info.signer_pk.to_string())
}

pub(crate) async fn wallet_exists(data_dir: String) -> Result<bool> {
    let maybe_sk = read_seed_file(data_dir.as_str())?;
    Ok(maybe_sk.is_some())
}

pub(crate) async fn nsec(data_dir: String) -> Result<nostr::SecretKey> {
    let xprv = read_seed_file(data_dir.as_str())?.ok_or(anyhow!("Seed file does not exist"))?;
    let sk = xprv.private_key;
    let sk = nostr::SecretKey::from_slice(sk.as_ref())?;
    Ok(sk)
}

pub fn delete_wallet(data_dir: String) -> Result<()> {
    reset_wallet(data_dir.as_str())
}
