import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsService {
  // Keys for SharedPreferences
  static const String _esploraUrlKey = 'esplora_url';
  static const String _arkServerUrlKey = 'ark_server_url';
  static const String _arkNetworkKey = 'ark_network';

  // Default values from environment variables
  static String get defaultEsploraUrl =>
      dotenv.env['ESPLORA_URL'] ?? 'http://localhost:30000';
  static String get defaultArkServerUrl =>
      dotenv.env['ARK_SERVER_URL'] ?? 'http://localhost:7070';
  static String get defaultArkNetwork => dotenv.env['ARK_NETWORK'] ?? 'regtest';

  // Singleton instance
  static final SettingsService _instance = SettingsService._internal();

  // Factory constructor
  factory SettingsService() => _instance;

  // Private constructor
  SettingsService._internal();

  // Get Esplora URL
  Future<String> getEsploraUrl() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_esploraUrlKey) ?? defaultEsploraUrl;
  }

  // Save Esplora URL
  Future<bool> saveEsploraUrl(String url) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(_esploraUrlKey, url);
  }

  // Get Ark Server URL
  Future<String> getArkServerUrl() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_arkServerUrlKey) ?? defaultArkServerUrl;
  }

  // Save Ark Server URL
  Future<bool> saveArkServerUrl(String url) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(_arkServerUrlKey, url);
  }

  // Get Ark Network
  Future<String> getNetwork() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_arkNetworkKey) ?? defaultArkNetwork;
  }

  // Save Network
  Future<bool> saveNetwork(String network) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(_arkNetworkKey, network);
  }

  // Reset to defaults
  Future<void> resetToDefaults() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_esploraUrlKey);
    await prefs.remove(_arkServerUrlKey);
    await prefs.remove(_arkNetworkKey);
  }
}
