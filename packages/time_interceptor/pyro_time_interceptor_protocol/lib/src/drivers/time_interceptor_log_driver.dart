/// 通话日志时间窗口查询 Driver 抽象接口契约 (TimeInterceptorLogDriver)
abstract class TimeInterceptorLogDriver {
  Future<bool> hasCallInTimeWindow(String phoneNumber, Duration durationWindow);
}
