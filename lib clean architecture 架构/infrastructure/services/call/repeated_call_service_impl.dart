import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/services/repeated_call_service.dart';
import '../../../domain/value_objects/phone_number.dart';
import '../base_service_impl.dart';

/// 重复来电处理服务实现
class RepeatedCallServiceImpl extends BaseServiceImpl implements RepeatedCallService {
  final SharedPreferences _preferences;
  
  // 配置
  bool _enabled = true;
  int _timeWindowMinutes = 30;
  int _callCountThreshold = 3;
  
  // 来电记录
  final Map<String, List<DateTime>> _callRecords = {};
  
  static const String repeatedCallEnabledKey = 'repeated_call_enabled';
  static const String repeatedCallTimeWindowKey = 'repeated_call_time_window';
  static const String repeatedCallThresholdKey = 'repeated_call_threshold';
  
  RepeatedCallServiceImpl(this._preferences);
  
  @override
  Future<void> loadConfig() async {
    _enabled = _preferences.getBool(repeatedCallEnabledKey) ?? true;
    _timeWindowMinutes = _preferences.getInt(repeatedCallTimeWindowKey) ?? 30;
    _callCountThreshold = _preferences.getInt(repeatedCallThresholdKey) ?? 3;
  }
  
  @override
  Future<void> saveConfig() async {
    await _preferences.setBool(repeatedCallEnabledKey, _enabled);
    await _preferences.setInt(repeatedCallTimeWindowKey, _timeWindowMinutes);
    await _preferences.setInt(repeatedCallThresholdKey, _callCountThreshold);
  }
  
  @override
  Future<void> recordCall(PhoneNumber phoneNumber) async {
    if (!_enabled) return;
    
    final now = DateTime.now();
    
    // 获取号码的记录列表
    final records = _callRecords[phoneNumber.value] ?? [];
    
    // 清理过期记录
    final validRecords = records.where((time) {
      final diff = now.difference(time);
      return diff.inMinutes <= _timeWindowMinutes;
    }).toList();
    
    // 添加新记录
    validRecords.add(now);
    
    // 更新记录
    _callRecords[phoneNumber.value] = validRecords;
  }
  
  @override
  Future<bool> isRepeatedCall(PhoneNumber phoneNumber) async {
    if (!_enabled) return false;
    
    final count = await getCallCount(phoneNumber);
    return count >= _callCountThreshold;
  }
  
  @override
  Future<int> getCallCount(PhoneNumber phoneNumber) async {
    if (!_enabled) return 0;
    
    final now = DateTime.now();
    final records = _callRecords[phoneNumber.value] ?? [];
    
    // 计算有效时间窗口内的记录数
    final validRecords = records.where((time) {
      final diff = now.difference(time);
      return diff.inMinutes <= _timeWindowMinutes;
    }).toList();
    
    return validRecords.length;
  }
  
  @override
  Future<void> clearRecords() async {
    _callRecords.clear();
  }
}