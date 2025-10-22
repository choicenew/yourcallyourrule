import 'package:flutter/foundation.dart';
import 'package:yourcallyourrule/core/repositories/call_log_repository.dart';
import 'package:yourcallyourrule/data/repositories/config/config_repository.dart';
import 'time_interceptor_config.dart';

class TimeInterceptorService {
  final ConfigRepository _configRepo;
  final CallLogRepository _callLogRepository;
  TimeInterceptorConfig timeInterceptorConfig = TimeInterceptorConfig();

  TimeInterceptorService(this._configRepo, this._callLogRepository);

  Future<void> initialize() async {
    await _loadConfig();
  }

  Future<void> loadConfig() async { // 新增公共方法
    await _loadConfig();
  }

  Future<bool> shouldIntercept(String phoneNumber) async {
    if (!timeInterceptorConfig.shouldIntercept) return false;
    
    final now = DateTime.now();
    final startDate = now.subtract(timeInterceptorConfig.duration);
    
    // 获取指定日期范围内的通话记录
    final logs = await _callLogRepository.getLogsByDateRange(startDate, now);
    
    // 过滤出指定电话号码的记录
    final entries = logs.where((log) => log.phoneNumber == phoneNumber).toList();
 debugPrint('entries打印: ${entries.map((e) => e.toMap()).toList()}');
    return entries.isEmpty;
  }

  Future<void> updateConfig(Duration duration, bool shouldIntercept) async {
    // 修改第30行实现
    timeInterceptorConfig = timeInterceptorConfig.copyWith(
      duration: duration,
      shouldIntercept: shouldIntercept,
    );
    await _saveConfig();
  }

  static const String _configKey = 'config_time_interceptor';

  Future<void> _loadConfig() async {
    final configMap = await _configRepo.getConfig(_configKey);
    if (configMap != null) {
      timeInterceptorConfig = TimeInterceptorConfig.fromMap(configMap);
    }
  }

  Future<void> _saveConfig() async {
    await _configRepo.saveConfig(_configKey, timeInterceptorConfig.toMap());
  }

  TimeInterceptorConfig get config => timeInterceptorConfig;
}