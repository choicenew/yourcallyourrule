// lib/features/call/call_overlay/configuration/configuration_manager.dart

import 'dart:io';
import 'package:yourcallyourrule/features/config/data/repositories/config_repository.dart';
import 'package:yourcallyourrule/features/call/call_overlay/configuration/call_overlay_config.dart';
import 'package:yourcallyourrule/features/call/call_overlay/configuration/call_overlay_config_service.dart';
import 'package:yourcallyourrule/features/call/call_overlay/configuration/call_overlay_import_export_service.dart';



// 删除了旧�?Provider import
// import 'package:yourcallyourrule/core/provider/providers/core_security_message_provider.dart';
// import 'package:yourcallyourrule/features/call/call_overlay/providers/security_message_provider.dart';
// import '../providers/caller_id_style_provider.dart';

/// 来电显示配置管理�?
/// 负责协调来电显示样式的保存、加载、导入和导出�?
/// 这个类现在是纯粹的业务逻辑层，与任何UI状态管理库（如Riverpod）解耦�?
class ConfigurationManager {
  final CallOverlayConfigService _configService;
  final CallOverlayImportExportService _importExportService;
  final ConfigRepository _configRepository;

  ConfigurationManager(this._configRepository)
      : _configService = CallOverlayConfigService(_configRepository),
        _importExportService = CallOverlayImportExportService(
            CallOverlayConfigService(_configRepository));

  /// 保存配置到仓�?
  /// 方法签名已更改：现在接收一�?CallOverlayConfig 数据对象�?
  Future<void> saveConfig(CallOverlayConfig config) async {
    await _configService.saveConfig(config);
  }

  /// 从仓库加载配�?
  /// 方法签名已更改：现在返回一�?CallOverlayConfig 数据对象�?
  /// 如果没有已保存的配置，它会加载并返回默认配置�?
  Future<CallOverlayConfig> loadConfig() async {
    final config = await _configService.loadConfig();
    if (config != null) {
      return config;
    } else {
      // 如果没有保存的配置，初始化并返回默认配置
      return await _configService.initializeDefault();
    }
  }

  /// 重置为默认配�?
  /// 方法签名已更改：现在返回重置后的默认 CallOverlayConfig 数据对象�?
  Future<CallOverlayConfig> resetToDefault() async {
    return await _configService.initializeDefault();
  }

  /// 导入配置
  /// 方法签名已更改：现在返回导入并加载后的新 CallOverlayConfig 数据对象�?
  Future<CallOverlayConfig> importConfig(String filePath) async {
    final file = File(filePath);
    await _importExportService.importConfig(file);
    // 导入后重新加载配置并返回
    return await loadConfig();
  }

  /// 导出配置 (此方法保持不�?
  Future<File> exportConfig() async {
    return await _importExportService.exportConfig();
  }

  // 静态方�?updateConfigFromMap 已不再需要，因为我们不再直接操作旧的 ChangeNotifierProvider�?
  // 如果其他地方仍有需要，可以保留，但其内部实现需要调整。为清晰起见，此处移除�?
}