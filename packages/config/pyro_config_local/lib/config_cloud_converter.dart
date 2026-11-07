import 'package:pyro_config_protocol/pyro_config_protocol.dart';

/// 配置云数据转换器
/// 负责将 ConfigRepository 托管的数据转换为基于 pyro_config_protocol 纯契约的 Payload 结构
/// 与云盘传输引擎 (clouddrive) 保持 100% 零代码依赖与彻底物理隔离
class ConfigCloudConverter {
  final ConfigRepository _configRepository;

  ConfigCloudConverter(this._configRepository);

  /// 将配置数据转换为 ConfigBackupPayload 标准数据体 (纯 Map 导出)
  Future<Map<String, dynamic>> convertToCloudFormat({
    List<String>? configKeys,
  }) async {
    final List<String> keys = (configKeys != null && configKeys.isNotEmpty)
        ? configKeys
        : await getAllConfigKeys();

    final Map<String, dynamic> configData = {};
    for (final key in keys) {
      final config = await _configRepository.getConfig(key);
      if (config != null) {
        configData[key] = config;
      }
    }

    final payload = ConfigBackupPayload(
      timestamp: DateTime.now().millisecondsSinceEpoch,
      data: configData,
    );

    return payload.toMap();
  }

  /// 从云同步或磁盘导出的 Payload 还原恢复配置数据
  Future<void> restoreFromCloudFormat(
    Map<String, dynamic> cloudData, {
    List<String>? configKeys,
  }) async {
    final payload = ConfigBackupPayload.fromMap(cloudData);

    if (payload.type != 'config_backup') {
      throw FormatException('无效的配置备份数据格式，缺少 config_backup 标志位');
    }

    final data = payload.data;

    if (configKeys != null && configKeys.isNotEmpty) {
      for (final key in configKeys) {
        if (data.containsKey(key)) {
          final entryValue = data[key];
          if (entryValue is Map<String, dynamic>) {
            await _configRepository.saveConfig(key, entryValue);
          } else if (entryValue != null) {
            await _configRepository.saveConfig(key, {'value': entryValue});
          }
        }
      }
    } else {
      for (final entry in data.entries) {
        final entryValue = entry.value;
        if (entryValue is Map<String, dynamic>) {
          await _configRepository.saveConfig(entry.key, entryValue);
        } else if (entryValue != null) {
          await _configRepository.saveConfig(entry.key, {'value': entryValue});
        }
      }
    }
  }

  /// 自动感应并获取底层配置仓库所有已托管的 Key 列表
  Future<List<String>> getAllConfigKeys() async {
    return await _configRepository.getAllKeys();
  }
}
