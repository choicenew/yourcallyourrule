import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yourcallyourrule/core/provider/basic_provider/call_log_repository_provider.dart';
import 'package:yourcallyourrule/core/repositories/call_log_repository.dart';
import 'package:yourcallyourrule/features/call/time_interceptor/provider/time_interceptor_provider.dart';

part 'time_interceptor_service.g.dart';

/// 这个 Service 只负责核心的业务逻辑，不管理任何状态。
class TimeInterceptorService {
  final Ref _ref;

  CallLogRepository get _callLogRepository => _ref.read(callLogRepositoryProvider);

  TimeInterceptorService(this._ref);

  /// 根据最新的配置，判断一个号码是否应该被拦截。
  Future<bool> shouldIntercept(String phoneNumber) async {
    // 从 Notifier 获取最新的配置状态
    final config = await _ref.read(timeInterceptorConfigProvider.future);

    if (!config.shouldIntercept) return false;

    final now = DateTime.now();
    final startDate = now.subtract(config.duration);

    final logs = await _callLogRepository.getLogsByDateRange(startDate, now);
    final entries = logs.where((log) => log.phoneNumber == phoneNumber).toList();

    // 您的原始逻辑：如果时间窗口内没有记录，则拦截。
    // 这意味着拦截第一次来电。请确认这是否是您想要的业务逻辑。
    return entries.isEmpty;
  }
}

/// 使用生成器创建 Service 的 Provider
@riverpod
TimeInterceptorService timeInterceptorService(Ref ref) {
  return TimeInterceptorService(ref);
}