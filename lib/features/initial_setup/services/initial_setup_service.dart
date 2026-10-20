import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yourcallyourrule/core/constants/app_prefs_keys.dart';
import 'package:yourcallyourrule/data/repositories/config/config_repository.dart';
import '../models/setup_config.dart';

/// 负责从云端拉取 Initial Setup 页面所需的动态配置，并提供内置 JSON 资产文件兜底和 IP 地区探测
class InitialSetupService {
  final String rawConfigUrl;
  final String cdnConfigUrl;
  final String localAssetPath;
  final Dio _dio;
  final ConfigRepository _configRepository;

  InitialSetupService({
    ConfigRepository? configRepository,
    this.rawConfigUrl = 'https://raw.githubusercontent.com/choicenew/yourcallrule/main/app_delta_setup_config.json',
    this.cdnConfigUrl = 'https://cdn.jsdelivr.net/gh/choicenew/yourcallrule@main/app_delta_setup_config.json',
    this.localAssetPath = 'assets/app_delta_setup_config.json',
    Dio? dio,
  })  : _configRepository = configRepository ?? SharedPreferencesConfigRepository(),
        _dio = dio ??
            Dio(
              BaseOptions(
                connectTimeout: const Duration(seconds: 5),
                receiveTimeout: const Duration(seconds: 5),
              ),
            );

  /// 从应用内置的 JSON 文件中加载兜底配置，避免网络不佳时白屏
  Future<SetupConfig> loadBuiltInConfig() async {
    try {
      final jsonString = await rootBundle.loadString(localAssetPath);
      final data = jsonDecode(jsonString);
      if (data is Map<String, dynamic>) {
        return SetupConfig.fromMap(data);
      }
    } catch (_) {}
    return SetupConfig(version: '1.0.0', countriesData: []);
  }

  /// 基于 IP API 自动探测用户当前网络所在国家/地区代码（例如 "CN", "US", "FR"）
  Future<String?> detectUserCountry() async {
    try {
      final response = await _dio.get('http://ip-api.com/json');
      if (response.statusCode == 200) {
        final data = response.data is String ? jsonDecode(response.data as String) : response.data;
        if (data is Map<String, dynamic> && data['countryCode'] != null) {
          return data['countryCode'].toString().toUpperCase();
        }
      }
    } catch (_) {}
    return null;
  }

  /// 获取初始配置。若网络故障则自动从本地 assets/app_delta_setup_config.json 加载兜底，绝不白屏
  Future<SetupConfig> fetchConfig({bool useCdn = false, String? customUrl}) async {
    final String targetUrl;
    if (customUrl != null && customUrl.trim().isNotEmpty) {
      targetUrl = customUrl.trim();
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

    // 网络不可用或请求失败时，从内置 JSON 资产文件中读取兜底配置
    return await loadBuiltInConfig();
  }

  /// 统一标记 Initial Setup 流程完成（保存 config_has_completed_initial_setup）
  Future<bool> completeInitialSetup() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.reload();
      await _configRepository.saveConfig(AppPrefsKeys.hasCompletedInitialSetup, {'value': true});
      await prefs.setBool(AppPrefsKeys.hasCompletedInitialSetup, true);
      return true;
    } catch (_) {
      return false;
    }
  }

  /// 检查 Initial Setup 流程是否已完成
  Future<bool> isInitialSetupCompleted() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.reload();

      // 1. 优先读取 ConfigRepository 标准 JSON 结构（对齐 purchase_state）
      final config = await _configRepository.getConfig(AppPrefsKeys.hasCompletedInitialSetup);
      if (config != null && config.containsKey('value')) {
        return config['value'] as bool? ?? false;
      }

      // 2. 兜底兼容原生 SharedPreferences 存储
      final val = prefs.get(AppPrefsKeys.hasCompletedInitialSetup);
      if (val is bool) return val;
      if (val is String) return val.toLowerCase().trim() == 'true';
      if (val is num) return val != 0;
      return false;
    } catch (_) {
      return false;
    }
  }
}
