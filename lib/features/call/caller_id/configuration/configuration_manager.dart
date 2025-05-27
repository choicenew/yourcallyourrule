import 'dart:convert';
import 'dart:io';



import 'package:yourcallyourrule/common/error/logger.dart';
import 'package:yourcallyourrule/data/repositories/config/config_repository.dart';
import 'package:yourcallyourrule/features/call/caller_id/configuration/caller_id_config.dart';

import '../providers/caller_id_style_provider.dart';

import 'caller_id_config_service.dart';
import 'caller_id_import_export_service.dart';

/// 来电显示配置管理器
/// 负责协调来电显示样式的保存、加载、导入和导出
class ConfigurationManager {
  final CallerIdConfigService _configService;
  final CallerIdImportExportService _importExportService;
  final ConfigRepository _configRepository;

  ConfigurationManager(this._configRepository)
      : _configService = CallerIdConfigService(_configRepository),
        _importExportService = CallerIdImportExportService(
            CallerIdConfigService(_configRepository));

  /// 保存配置到仓库
  Future<void> saveToRepository(CallerIdStyleProvider styleProvider) async {
    final config = CallerIdConfigX.fromStyleProvider(styleProvider);
    await _configService.saveConfig(config);
  }

  /// 从仓库加载配置
  Future<void> loadFromRepository(CallerIdStyleProvider styleProvider) async {
    final config = await _configService.loadConfig();
    if (config != null) {
      config.applyToProvider(styleProvider);
    } else {
      // 如果没有保存的配置，初始化默认配置
      final defaultConfig = await _configService.initializeDefault();
      defaultConfig.applyToProvider(styleProvider);
    }
  }

  /// 重置为默认配置
  Future<void> resetToDefault(CallerIdStyleProvider styleProvider) async {
    final defaultConfig = await _configService.initializeDefault();
    defaultConfig.applyToProvider(styleProvider);
  }

  /// 导入配置
  Future<void> importConfig(String filePath, CallerIdStyleProvider styleProvider) async {
    final file = File(filePath);
    await _importExportService.importConfig(file);
    // 导入后重新加载配置
    await loadFromRepository(styleProvider);
  }

  /// 导出配置
  Future<File> exportConfig() async {
    return await _importExportService.exportConfig();
  }

  /// 静态方法：更新配置从Map
  /// 用于跨进程通信时更新配置
  static void updateConfigFromMap(
      Map<String, dynamic> config, CallerIdStyleProvider styleProvider) {
    final callerIdConfig = CallerIdConfig.fromMap(config);
    callerIdConfig.applyToProvider(styleProvider);
  }
}


/*
/// 配置仓库异步包装类
/// 提供异步访问配置仓库的方法
class ConfigRepositoryAsync {
  final ConfigRepository _repository;
  
  ConfigRepositoryAsync(this._repository);
  
  Future<String?> getString(String key) async {
    final config = await _repository.getConfig(key);
    if (config == null) return null;
    return json.encode(config);
  }

  Future<void> setString(String key, String value) async {
    try {
      final config = json.decode(value) as Map<String, dynamic>;
      await _repository.saveConfig(key, config);
    } catch (e) {
      // 解析失败时不保存
       AppLogger.error('解析和保存失败', e);
    }
  }
}
*/