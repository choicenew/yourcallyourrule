import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/services/time_interceptor_service.dart';
import '../../../domain/value_objects/phone_number.dart';
import '../base_service_impl.dart';

/// 时间拦截器服务实现
class TimeInterceptorServiceImpl extends BaseServiceImpl implements TimeInterceptorService {
  final SharedPreferences _preferences;
  
  // 配置
  bool _enabled = false;
  int _startHour = 22;
  int _endHour = 7;
  List<String> _exemptNumbers = [];
  
  static const String timeInterceptorEnabledKey = 'time_interceptor_enabled';
  static const String timeInterceptorStartHourKey = 'time_interceptor_start_hour';
  static const String timeInterceptorEndHourKey = 'time_interceptor_end_hour';
  static const String timeInterceptorExemptNumbersKey = 'time_interceptor_exempt_numbers';
  
  TimeInterceptorServiceImpl(this._preferences);
  
  @override
  Future<void> loadConfig() async {
    _enabled = _preferences.getBool(timeInterceptorEnabledKey) ?? false;
    _startHour = _preferences.getInt(timeInterceptorStartHourKey) ?? 22;
    _endHour = _preferences.getInt(timeInterceptorEndHourKey) ?? 7;
    _exemptNumbers = _preferences.getStringList(timeInterceptorExemptNumbersKey) ?? [];
  }
  
  @override
  Future<void> saveConfig() async {
    await _preferences.setBool(timeInterceptorEnabledKey, _enabled);
    await _preferences.setInt(timeInterceptorStartHourKey, _startHour);
    await _preferences.setInt(timeInterceptorEndHourKey, _endHour);
    await _preferences.setStringList(timeInterceptorExemptNumbersKey, _exemptNumbers);
  }
  
  @override
  Future<bool> shouldIntercept(PhoneNumber phoneNumber) async {
    // 如果未启用，不拦截
    if (!_enabled) return false;
    
    // 如果号码在豁免列表中，不拦截
    if (_exemptNumbers.contains(phoneNumber.value)) return false;
    
    // 获取当前小时
    final now = DateTime.now();
    final currentHour = now.hour;
    
    // 判断是否在拦截时间范围内
    if (_startHour < _endHour) {
      // 例如：22:00 - 7:00
      return currentHour >= _startHour || currentHour < _endHour;
    } else {
      // 例如：22:00 - 7:00
      return currentHour >= _startHour && currentHour < _endHour;
    }
  }
  
  @override
  Map<String, dynamic> getConfig() {
    return {
      'enabled': _enabled,
      'startHour': _startHour,
      'endHour': _endHour,
      'exemptNumbers': _exemptNumbers,
      'shouldIntercept': _enabled,
    };
  }
  
  @override
  Future<void> updateConfig(Map<String, dynamic> config) async {
    _enabled = config['enabled'] ?? _enabled;
    _startHour = config['startHour'] ?? _startHour;
    _endHour = config['endHour'] ?? _endHour;
    _exemptNumbers = List<String>.from(config['exemptNumbers'] ?? _exemptNumbers);
    
    await saveConfig();
  }
}