use crate::api::ark_api::InvoiceEvent;
use crate::ark::esplora::EsploraClient;
use crate::ark::storage::InMemoryDb;
use crate::frb_generated::StreamSink;
use crate::logger::LogEntry;
use ark_bdk_wallet::Wallet;
use ark_client::SqliteSwapStorage;
use ark_client::{Bip32KeyProvider, Client};
use parking_lot::RwLock;
use state::InitCell;
use std::sync::Arc;

pub static LOG_STREAM_SINK: InitCell<RwLock<Arc<StreamSink<LogEntry>>>> = InitCell::new();
#[allow(clippy::type_complexity)]
pub static ARK_CLIENT: InitCell<
    RwLock<Arc<Client<EsploraClient, Wallet<InMemoryDb>, SqliteSwapStorage, Bip32KeyProvider>>>,
> = InitCell::new();
pub static SWAP_STORAGE: InitCell<RwLock<Arc<SqliteSwapStorage>>> = InitCell::new();
pub static INVOICE_STREAM_SINK: InitCell<RwLock<Arc<StreamSink<InvoiceEvent>>>> = InitCell::new();
