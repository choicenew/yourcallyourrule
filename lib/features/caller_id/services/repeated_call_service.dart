import 'package:call_log/call_log.dart';
import 'package:yourcallyourrule/core/base/base_service.dart';
import 'package:yourcallyourrule/core/entities/call/time_interceptor_config.dart';

import 'package:yourcallyourrule/data/repositories/call/time_interceptor_config_repository_impl.dart';

class RepeatedCallService extends BaseService {
  final TimeInterceptorConfigRepositoryImpl _configRepository;

  RepeatedCallService(this._configRepository) : super(_configRepository);

  Future<bool> shouldIntercept(String phoneNumber) async {
    final config = await _getConfig();
    if (!config.shouldIntercept) return false;

    final now = DateTime.now();
    final entries = await CallLog.query(
      dateFrom: now.subtract(config.duration).millisecondsSinceEpoch,
      dateTo: now.millisecondsSinceEpoch,
      number: phoneNumber,
      type: CallType.incoming,
    );

    return entries.isNotEmpty;
  }

  Future<void> updateConfig(Duration duration, bool shouldIntercept) async {
    final newConfig = TimeBasedInterceptorConfig(
      duration: duration,
      shouldIntercept: shouldIntercept,
    );
    await _configRepository.save(newConfig);
  }

  Future<TimeBasedInterceptorConfig> _getConfig() async {
    final configs = await _configRepository.getAll();
    return configs.isNotEmpty 
        ? configs.first 
        : const TimeBasedInterceptorConfig();
  }
}