import 'dart:convert';
import 'dart:io';
import 'package:yourcallyourrule/core/entities/cloud_data_converter.dart';

import 'package:yourcallyourrule/core/entities/label/label_phone_entry.dart';
import 'package:yourcallyourrule/core/entities/location/location_entry.dart';
import 'package:yourcallyourrule/cloud_sync/services/local_storage_service.dart';
import 'package:yourcallyourrule/core/entities/rule/rule_base.dart';
import 'package:yourcallyourrule/data/repositories/call/config_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RuleImportExportService {
  final LocalStorageService _storage;
  final ConfigRepository _configRepository;

  RuleImportExportService(this._storage, {ConfigRepository? configRepository})
      : _configRepository = configRepository ?? SharedPreferencesConfigRepository();

  LocalStorageService get storage => _storage;

  Future<File> exportRulePackage(String filePath, {
    bool includeRules = true,
    bool includeLabels = true,
    bool includeLocations = true,
    bool includeConfigs = true,
    List<String>? configKeys,
  }) async {
    final package = {};
    
    if (includeRules) {
      package['rules'] = CloudDataConverter.serialize(await _storage.loadRules());
    }
    
    if (includeLabels) {
      package['labels'] = CloudDataConverter.serialize(await _storage.loadLabels());
    } else {
      package['labels'] = [];
    }
    
    if (includeLocations) {
      package['locations'] = CloudDataConverter.serialize(await _storage.loadLocations());
    } else {
      package['locations'] = [];
    }
    
    // 添加配置数据
    if (includeConfigs) {
      final configData = await _exportConfigs(configKeys);
      package['configs'] = configData;
    }

    return await _writeToFile(filePath, package);
  }

  Future<void> importRulePackage(File file, {
    bool importRules = true,
    bool importLabels = true,
    bool importLocations = true,
    bool importConfigs = true,
    List<String>? configKeys,
  }) async {
    final package = await _readFromFile(file);
    
    if (importRules && package.containsKey('rules')) {
      await _storage.saveRules(_convertList<RuleBase>(package['rules']));
    }
    
    if (importLabels && package.containsKey('labels')) {
      await _storage.saveLabels(_convertList<LabelPhoneEntry>(package['labels']));
    }
    
    if (importLocations && package.containsKey('locations')) {
      await _storage.saveLocations(_convertList<LocationEntry>(package['locations']));
    }
    
    // 导入配置数据
    if (importConfigs && package.containsKey('configs')) {
      await _importConfigs(package['configs'], configKeys: configKeys);
    }
  }

  List<T> _convertList<T>(dynamic data) {
    return (data as List).map((e) => CloudDataConverter.deserialize<T>(e)).toList();
  }

  Future<File> _writeToFile(String path, dynamic data) async {
    final file = File(path);
    await file.writeAsString(jsonEncode(data));
    return file;
  }

  Future<Map<String, dynamic>> _readFromFile(File file) async {
    final content = await file.readAsString();
    final data = jsonDecode(content) as Map<String, dynamic>;
    
    // 验证包格式 - 至少包含rules或configs之一
    if (!data.containsKey('rules') && !data.containsKey('configs')) {
      throw const FormatException('Invalid package format: missing both rules and configs');
    }
    
    return data;
  }
  
  /// 导出配置数据
  Future<Map<String, dynamic>> _exportConfigs(List<String>? configKeys) async {
    // 获取所有配置键或使用指定的键
    final List<String> keys;
    if (configKeys != null && configKeys.isNotEmpty) {
      keys = configKeys;
    } else {
      // 从SharedPreferences获取所有键
      final prefs = await SharedPreferences.getInstance();
      keys = prefs.getKeys().toList();
    }
    
    // 收集配置数据
    final Map<String, dynamic> configData = {};
    for (final key in keys) {
      final config = await _configRepository.getConfig(key);
      if (config != null) {
        configData[key] = config;
      }
    }

    return {
      'type': 'config_backup',
      'version': 1,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'data': configData,
    };
  }
  
  /// 导入配置数据
  Future<void> _importConfigs(Map<String, dynamic> configData, {List<String>? configKeys}) async {
    // 验证数据格式
    if (configData['type'] != 'config_backup') {
      throw FormatException('无效的配置备份数据格式');
    }

    final data = configData['data'] as Map<String, dynamic>;
    
    // 如果指定了键，只恢复这些键
    if (configKeys != null && configKeys.isNotEmpty) {
      for (final key in configKeys) {
        if (data.containsKey(key)) {
          await _configRepository.saveConfig(
            key, 
            data[key] as Map<String, dynamic>
          );
        }
      }
    } else {
      // 否则恢复所有配置
      for (final entry in data.entries) {
        await _configRepository.saveConfig(
          entry.key, 
          entry.value as Map<String, dynamic>
        );
      }
    }
  }
}