use anyhow::anyhow;
use anyhow::Result;
use bitcoin::bip32::Xpriv;
use std::fs;
use std::fs::File;
use std::io::Write;
use std::path::Path;
use std::str::FromStr;

pub fn write_seed_file(xpriv: &Xpriv, data_dir: &String) -> Result<()> {
    let data_path = Path::new(data_dir);
    fs::create_dir_all(data_path).map_err(|e| anyhow!("Failed to create data directory: {}", e))?;
    let seed_path = data_path.join("seed");
    let mut file =
        File::create(&seed_path).map_err(|e| anyhow!("Failed to create seed file: {}", e))?;

    let xprv = hex::encode(xpriv.encode());

    file.write_all(xprv.as_bytes())
        .map_err(|e| anyhow!("Failed to write seed file: {}", e))?;

    tracing::debug!(seed_path = ?seed_path, "Stored xprv in file");

    Ok(())
}

pub fn read_seed_file(data_dir: &str) -> Result<Option<Xpriv>> {
    let data_path = Path::new(data_dir);
    let seed_path = data_path.join("seed");

    // Check if seed file exists
    if !seed_path.exists() {
        tracing::debug!(seed_path = ?seed_path, "Seed file does not exist");
        return Ok(None);
    }

    // Read the file contents
    let sk_hex =
        fs::read_to_string(&seed_path).map_err(|e| anyhow!("Failed to read seed file: {}", e))?;

    let xprv = Xpriv::from_str(&sk_hex.trim())
        .map_err(|e| anyhow!("Failed to create xprv from seed file: {}", e))?;

    tracing::debug!(seed_path = ?seed_path, "Successfully read xprv from file");

    Ok(Some(xprv))
}

pub fn reset_wallet(data_dir: &str) -> Result<()> {
    let data_path = Path::new(data_dir);
    let seed_path = data_path.join("seed");

    if !seed_path.exists() {
        tracing::warn!(seed_path = ?seed_path, "Seed file does not exist");
    } else {
        fs::remove_file(&seed_path)?;
        tracing::info!("Seed file deleted");
    }

    Ok(())
}
