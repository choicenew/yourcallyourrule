import 'package:flutter/foundation.dart';
import 'package:pyro_time_interceptor_protocol/pyro_time_interceptor_protocol.dart';

/// 真实内存级时间拦截驱动 (MemoryTimeInterceptorLogDriver)
class MemoryTimeInterceptorLogDriver implements TimeInterceptorLogDriver {
  final Map<String, DateTime> _lastCallTimes = {};

  MemoryTimeInterceptorLogDriver();

  @override
  Future<bool> hasCallInTimeWindow(String phoneNumber, Duration durationWindow) async {
    final lastCall = _lastCallTimes[phoneNumber];
    if (lastCall == null) return false;
    final now = DateTime.now();
    return now.difference(lastCall) <= durationWindow;
  }

  void recordCall(String phoneNumber) {
    _lastCallTimes[phoneNumber] = DateTime.now();
    debugPrint('[MemoryTimeInterceptorDriver] 记录已知来电时间: $phoneNumber');
  }
}
