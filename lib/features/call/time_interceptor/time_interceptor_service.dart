import 'package:call_log/call_log.dart';
import 'package:yourcallyourrule/data/repositories/call/config_repository.dart';
import 'time_interceptor_config.dart';

class TimeInterceptorService {
  final ConfigRepository _configRepo;
  TimeInterceptorConfig timeInterceptorConfig = TimeInterceptorConfig();

  TimeInterceptorService(this._configRepo);

  Future<void> initialize() async {
    await _loadConfig();
  }

  Future<void> loadConfig() async { // 新增公共方法
    await _loadConfig();
  }

  Future<bool> shouldIntercept(String phoneNumber) async {
    if (!timeInterceptorConfig.shouldIntercept) return false;
    
    final now = DateTime.now();
    final entries = await CallLog.query(
      dateFrom: now.subtract(timeInterceptorConfig.duration).millisecondsSinceEpoch,
      dateTo: now.millisecondsSinceEpoch,
      number: phoneNumber,
      type: CallType.incoming,
    );

    return entries.isNotEmpty;
  }

  Future<void> updateConfig(Duration duration, bool shouldIntercept) async {
    // 修改第30行实现
    timeInterceptorConfig = timeInterceptorConfig.copyWith(
      duration: duration,
      shouldIntercept: shouldIntercept,
    );
    await _saveConfig();
  }

  Future<void> _loadConfig() async {
    final configMap = await _configRepo.getConfig('time_interceptor');
    if (configMap != null) {
      timeInterceptorConfig = TimeInterceptorConfig.fromMap(configMap);
    }
  }

  Future<void> _saveConfig() async {
    await _configRepo.saveConfig('time_interceptor', timeInterceptorConfig.toMap());
  }

  TimeInterceptorConfig get config => timeInterceptorConfig;
}