import 'dart:io';
import 'package:yourcallyourrule/features/config/data/repositories/config_repository.dart';
import 'package:yourcallyourrule/features/call/call_overlay/configuration/call_overlay_config.dart';
import 'package:yourcallyourrule/features/call/call_overlay/configuration/call_overlay_config_service.dart';
import 'package:yourcallyourrule/features/call/call_overlay/configuration/call_overlay_import_export_service.dart';

/// 来电显示配置管理器
class ConfigurationManager {
  final CallOverlayConfigService _configService;
  final CallOverlayImportExportService _importExportService;
  final ConfigRepository _configRepository;

  ConfigurationManager(this._configRepository)
      : _configService = CallOverlayConfigService(_configRepository),
        _importExportService = CallOverlayImportExportService(
            CallOverlayConfigService(_configRepository));

  Future<void> saveConfig(CallOverlayConfig config) async {
    await _configService.saveConfig(config);
  }

  Future<CallOverlayConfig> loadConfig() async {
    final config = await _configService.loadConfig();
    if (config != null) {
      return config;
    } else {
      return await _configService.initializeDefault();
    }
  }

  Future<CallOverlayConfig> resetToDefault() async {
    return await _configService.initializeDefault();
  }

  Future<CallOverlayConfig> importConfig(String filePath) async {
    final file = File(filePath);
    await _importExportService.importConfig(file);
    return await loadConfig();
  }

  Future<File> exportConfig() async {
    return await _importExportService.exportConfig();
  }
}
