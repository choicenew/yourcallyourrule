import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yourcallyourrule/features/common/constants/app_prefs_keys.dart';
import '../models/setup_config.dart';

class InitialSetupService {
  final String rawConfigUrl;
  final String cdnConfigUrl;
  final String localAssetPath;

  final String rawPluginConfigUrl;
  final String cdnPluginConfigUrl;
  final String localPluginAssetPath;

  final Dio _dio;

  InitialSetupService({
    this.rawConfigUrl = 'https://raw.githubusercontent.com/choicenew/yourcallrule/main/app_delta_setup_config.json',
    this.cdnConfigUrl = 'https://cdn.jsdelivr.net/gh/choicenew/yourcallrule@main/app_delta_setup_config.json',
    this.localAssetPath = 'assets/app_delta_setup_config.json',
    this.rawPluginConfigUrl = 'https://raw.githubusercontent.com/choicenew/yourcallrule/main/app_plugin_setup_config.json',
    this.cdnPluginConfigUrl = 'https://cdn.jsdelivr.net/gh/choicenew/yourcallrule@main/app_plugin_setup_config.json',
    this.localPluginAssetPath = 'assets/app_plugin_setup_config.json',
    Dio? dio,
  })  : _dio = dio ??
            Dio(
              BaseOptions(
                connectTimeout: const Duration(seconds: 5),
                receiveTimeout: const Duration(seconds: 5),
              ),
            );

  Future<SetupConfig> loadBuiltInConfig([String? assetPath]) async {
    final path = assetPath ?? localAssetPath;
    try {
      final jsonString = await rootBundle.loadString(path);
      final data = jsonDecode(jsonString);
      if (data is Map<String, dynamic>) {
        return SetupConfig.fromMap(data);
      }
    } catch (_) {}
    if (path != localAssetPath) {
      return loadBuiltInConfig(localAssetPath);
    }
    return SetupConfig(version: '1.0.0', countriesData: []);
  }

  Future<String?> detectUserCountry() async {
    try {
      final response = await _dio.get('https://ip-api.com/json');
      if (response.statusCode == 200) {
        final data = response.data is String ? jsonDecode(response.data as String) : response.data;
        if (data is Map<String, dynamic> && data['countryCode'] != null) {
          return data['countryCode'].toString().toUpperCase();
        }
      }
    } catch (_) {}
    return null;
  }

  Future<SetupConfig> fetchConfig({
    bool useCdn = false,
    String? customUrl,
    bool isPluginConfig = false,
  }) async {
    final String targetUrl;
    if (customUrl != null && customUrl.trim().isNotEmpty) {
      targetUrl = customUrl.trim();
    } else if (isPluginConfig) {
      targetUrl = useCdn && cdnPluginConfigUrl.isNotEmpty ? cdnPluginConfigUrl : rawPluginConfigUrl;
    } else {
      targetUrl = useCdn && cdnConfigUrl.isNotEmpty ? cdnConfigUrl : rawConfigUrl;
    }

    try {
      final response = await _dio.get(targetUrl);
      if (response.statusCode == 200) {
        final data = response.data is String ? jsonDecode(response.data as String) : response.data;
        if (data is Map<String, dynamic>) {
          return SetupConfig.fromMap(data);
        }
      }
    } catch (_) {}

    return await loadBuiltInConfig(isPluginConfig ? localPluginAssetPath : localAssetPath);
  }

  Future<bool> completeInitialSetup() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('first_launch', false);
      return await prefs.setBool(AppPrefsKeys.hasCompletedInitialSetup, true);
    } catch (_) {
      return false;
    }
  }

  Future<bool> isInitialSetupCompleted() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getBool(AppPrefsKeys.hasCompletedInitialSetup) ?? false;
    } catch (_) {
      return false;
    }
  }
}
