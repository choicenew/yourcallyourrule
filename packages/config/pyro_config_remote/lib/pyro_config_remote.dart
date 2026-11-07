import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';

/// App-Agnostic Remote Config Service
/// 
/// Consolidates "Dual Cloud" logic (Cloudflare + Firebase) and Local Caching.
/// Does NOT contain app-specific keys or defaults.
class AuraRemoteConfig {
  final String cloudflareUrl;
  final Map<String, dynamic> defaults;
  final String cacheKey;

  // Stream for Hot Reload (Architecture Ready)
  final StreamController<Map<String, dynamic>> _configStream = StreamController.broadcast();
  Stream<Map<String, dynamic>> get onConfigUpdated => _configStream.stream;

  Map<String, dynamic> _activeConfig = {};
  
  // Dependency Injection for Testing
  final FirebaseRemoteConfig? _firebaseConfigOverride;
  FirebaseRemoteConfig get _firebaseConfig => _firebaseConfigOverride ?? FirebaseRemoteConfig.instance;
  
  // Public accessor for raw config (useful for debugging)
  Map<String, dynamic> get currentConfig => _activeConfig;

  AuraRemoteConfig({
    required this.cloudflareUrl,
    required this.defaults,
    this.cacheKey = 'aura_remote_config_cache',
    FirebaseRemoteConfig? firebaseRemoteConfig,
  }) : _firebaseConfigOverride = firebaseRemoteConfig {
    _activeConfig = Map.from(defaults);
  }

  /// Initialize: Load Cache -> Init Firebase -> Fetch Remote
  Future<void> init() async {
    try {
      // 1. Load from local cache immediately (Fastest)
      await _loadFromCache();

      // 2. Initialize Firebase defaults
      await _initFirebase();

      // 3. Fetch remote configs (Async update)
      _fetchAndActivate();
    } catch (e) {
      debugPrint("AuraRemoteConfig init error: $e");
    }
  }

  // --- Core Logic ---

  Future<void> _fetchAndActivate() async {
    try {
      // Parallel fetch: Cloudflare (Fast/Realtime) vs Firebase (Reliable/Slow)
      final cfFuture = _fetchCloudflare();
      final fbFuture = _firebaseConfig.fetchAndActivate();

      // Strategy: Prioritize Cloudflare
      final cfConfig = await cfFuture;

      if (cfConfig != null) {
        debugPrint("[AuraRemoteConfig] ✅ Cloudflare config applied (Priority 1)");
        _applyNewConfig(cfConfig);
      } else {
        debugPrint("[AuraRemoteConfig] ⚠️ Cloudflare failed/timeout, checking Firebase (Priority 2)");
        // Wait for Firebase to finish
        await fbFuture; 

        // Firebase sends config as a string JSON blob in 'aura_master_json'
        // OR as individual keys. We support the 'aura_master_json' pattern for bulk update.
        final fbJson = _firebaseConfig.getString('aura_master_json');
        if (fbJson.isNotEmpty) {
          try {
            final fbConfig = jsonDecode(fbJson);
             debugPrint("[AuraRemoteConfig] ✅ Firebase config applied");
             _applyNewConfig(fbConfig);
          } catch (e) {
             debugPrint("[AuraRemoteConfig] ❌ Invalid JSON from Firebase");
          }
        }
      }
    } catch (e) {
      debugPrint("[AuraRemoteConfig] ❌ Remote Config Fetch Error: $e");
    }
  }

  Future<Map<String, dynamic>?> _fetchCloudflare() async {
    if (cloudflareUrl.isEmpty) return null;
    try {
      final response = await http
          .get(Uri.parse(cloudflareUrl))
          .timeout(const Duration(seconds: 3));

      if (response.statusCode == 200) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  Future<void> _initFirebase() async {
    try {
      await _firebaseConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(minutes: 1),
        minimumFetchInterval: const Duration(hours: 1),
      ));
      
      // We set defaults here too to ensure Firebase has *something*
      // Wrapping defaults in the 'aura_master_json' key if needed by strategy,
      // but usually setDefaults accepts a flat map. 
      // For compatibility with the JSON blob strategy:
      await _firebaseConfig.setDefaults({'aura_master_json': jsonEncode(defaults)});
    } catch (e) { 
        debugPrint("[AuraRemoteConfig] Firebase init warning: $e");
    }
  }

  Future<void> _loadFromCache() async {
    final prefs = await SharedPreferences.getInstance();
    final cachedStr = prefs.getString(cacheKey);
    if (cachedStr != null) {
      try {
        _activeConfig = jsonDecode(cachedStr);
         // Merge with defaults to ensure missing keys are present
         // (Deep merge is overkill here, standard merge is usually fine for top-level)
      } catch (_) {}
    }
  }

  void _applyNewConfig(Map<String, dynamic> newConfig) {
    _activeConfig = newConfig;
    _saveToCache(newConfig);
    _configStream.add(newConfig); // Notify listeners (Hot Reload)
  }

  Future<void> _saveToCache(Map<String, dynamic> config) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(cacheKey, jsonEncode(config));
  }

  // --- Generic Getters ---
  // Safe getters that fall back to defaults if key is missing or wrong type

  T _getValue<T>(String section, String key) {
    // 1. Try Active Config
    if (_activeConfig.containsKey(section)) {
        final sectionMap = _activeConfig[section];
        if (sectionMap is Map && sectionMap.containsKey(key)) {
            final val = sectionMap[key];
            if (val is T) return val;
            // Handle number conversions (int <-> double)
            if (val is num && T == double) return val.toDouble() as T;
            if (val is num && T == int) return val.toInt() as T;
        }
    }
    
    // 2. Fallback to Defaults
    if (defaults.containsKey(section)) {
         final sectionMap = defaults[section];
         if (sectionMap is Map && sectionMap.containsKey(key)) {
             final val = sectionMap[key];
              if (val is T) return val;
              if (val is num && T == double) return val.toDouble() as T;
              if (val is num && T == int) return val.toInt() as T;
         }
    }
    
    throw Exception("Config key not found: $section/$key");
  }

  double getDouble(String section, String key) => _getValue<double>(section, key);
  int getInt(String section, String key) => _getValue<int>(section, key);
  bool getBool(String section, String key) => _getValue<bool>(section, key);
  String getString(String section, String key) => _getValue<String>(section, key);

  List<String> getList(String section, String key) {
      // List handling is tricky due to dynamic types in JSON
      var val = _activeConfig[section]?[key];
      if (val == null) val = defaults[section]?[key];
      
      if (val is List) {
          return val.map((e) => e.toString()).toList();
      }
      return [];
  }
  
  Map<String, dynamic> getSection(String section) {
      var val = _activeConfig[section];
      if (val == null) val = defaults[section];
      if (val is Map) return Map<String, dynamic>.from(val);
      return {};
  }
}
