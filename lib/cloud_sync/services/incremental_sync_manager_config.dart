import 'dart:convert';
import 'package:yourcallyourrule/data/repositories/config/config_repository.dart';

/// 为IncrementalSyncManager提供配置存储功能的类
class IncrementalSyncManagerConfig {
  final ConfigRepository _configRepository;
  
  /// 构造函数
  IncrementalSyncManagerConfig({required ConfigRepository configRepository})
      : _configRepository = configRepository;
  
  /// 获取最后同步时间
  Future<DateTime?> getLastSyncTime(String serviceType, String dataType) async {
    final key = 'last_sync_${serviceType}_$dataType';
    final config = await _configRepository.getConfig(key);
    final timestamp = config?['value'] as String?;
    
    if (timestamp == null) return null;
    
    try {
      return DateTime.parse(timestamp);
    } catch (e) {
      return null;
    }
  }
  
  /// 保存最后同步时间
  Future<void> saveLastSyncTime(String serviceType, String dataType) async {
    final key = 'last_sync_${serviceType}_$dataType';
    final now = DateTime.now().toIso8601String();
    
    await _configRepository.saveConfig(key, {'value': now});
  }
  
  /// 获取最后同步哈希值
  Future<String?> getLastSyncHash(String serviceType, String dataType) async {
    final key = 'last_sync_hash_${serviceType}_$dataType';
    final config = await _configRepository.getConfig(key);
    return config?['value'] as String?;
  }
  
  /// 保存最后同步哈希值
  Future<void> saveLastSyncHash(String serviceType, String dataType, String hash) async {
    final key = 'last_sync_hash_${serviceType}_$dataType';
    await _configRepository.saveConfig(key, {'value': hash});
  }
  
  /// 记录同步历史
  Future<void> recordSyncHistory(String serviceType, String dataType, Map<String, dynamic> details) async {
    final historyKey = 'sync_history_${serviceType}_$dataType';
    
    // 获取现有历史记录
    final config = await _configRepository.getConfig(historyKey);
    final historyJson = config?['value'] as String? ?? '[]';
    final List<dynamic> history = jsonDecode(historyJson);
    
    // 添加新条目（限制为最后50条）
    history.add(details);
    if (history.length > 50) {
      history.removeRange(0, history.length - 50);
    }
    
    // 保存更新后的历史记录
    await _configRepository.saveConfig(historyKey, {'value': jsonEncode(history)});
  }
  
  /// 获取同步历史
  Future<List<Map<String, dynamic>>> getSyncHistory(String serviceType, String dataType) async {
    final historyKey = 'sync_history_${serviceType}_$dataType';
    
    final config = await _configRepository.getConfig(historyKey);
    final historyJson = config?['value'] as String? ?? '[]';
    final List<dynamic> history = jsonDecode(historyJson);
    
    return history.map((item) => item as Map<String, dynamic>).toList();
  }
  
  /// 清除同步历史
  Future<void> clearSyncHistory(String serviceType, String dataType) async {
    final historyKey = 'sync_history_${serviceType}_$dataType';
    await _configRepository.removeConfig(historyKey);
  }
}