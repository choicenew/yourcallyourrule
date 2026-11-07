import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_time_interceptor_protocol/pyro_time_interceptor_protocol.dart';

part 'time_interceptor_control_center.g.dart';

@Riverpod(keepAlive: true)
TimeInterceptorControlCenter timeInterceptorControlCenter(Ref ref) {
  return TimeInterceptorControlCenter.instance;
}

/// 时间窗口拦截控制中心 (TimeInterceptorControlCenter)
class TimeInterceptorControlCenter {
  static final TimeInterceptorControlCenter instance = TimeInterceptorControlCenter._();

  TimeInterceptorControlCenter._();

  TimeInterceptorLogDriver? _logDriver;
  TimeInterceptorConfig _config = const TimeInterceptorConfig();

  void registerLogDriver(TimeInterceptorLogDriver driver) {
    _logDriver = driver;
    debugPrint('[TimeInterceptorHub] 已挂载注册日志查询驱动: ${driver.runtimeType}');
  }

  TimeInterceptorLogDriver? get logDriver => _logDriver;

  void updateConfig(TimeInterceptorConfig config) {
    _config = config;
  }

  TimeInterceptorConfig get config => _config;

  Future<bool> shouldIntercept(String phoneNumber) async {
    if (!_config.shouldIntercept) return false;
    final hasRecentCall = await _logDriver?.hasCallInTimeWindow(
      phoneNumber,
      Duration(minutes: _config.durationMinutes),
    ) ?? false;

    // 如果指定窗口内无历史通话记录，则拦截二次重复来电
    return !hasRecentCall;
  }
}
