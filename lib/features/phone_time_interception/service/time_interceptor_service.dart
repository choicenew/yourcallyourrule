import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yourcallyourrule/features/phone_history/repositories/call_log_repository.dart';
import 'package:yourcallyourrule/features/phone_history/data/repositories/call_log_repository_impl.dart';
import 'package:yourcallyourrule/features/phone_time_interception/provider/time_interceptor_provider.dart';

part 'time_interceptor_service.g.dart';

/// 时间段拦截服务
class TimeInterceptorService {
  final Ref _ref;

  CallLogRepository get _callLogRepository => _ref.read(callLogRepositoryProvider);

  TimeInterceptorService(this._ref);

  Future<bool> shouldIntercept(String phoneNumber) async {
    final config = await _ref.read(timeInterceptorConfigProvider.future);

    if (!config.shouldIntercept) return false;

    final now = DateTime.now();
    final startDate = now.subtract(config.duration);

    final logs = await _callLogRepository.getLogsByDateRange(startDate, now);
    final entries = logs.where((log) => log.phoneNumber == phoneNumber).toList();

    // 根据业务定义（短时间内拦截同一号码的频繁连拨），若在指定时段内已有记录则拦截
    return entries.isNotEmpty;
  }
}

@riverpod
TimeInterceptorService timeInterceptorService(Ref ref) {
  return TimeInterceptorService(ref);
}
