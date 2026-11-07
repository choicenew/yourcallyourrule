library pyro_time_interceptor_connector;

import 'package:pyro_time_interceptor_protocol/pyro_time_interceptor_protocol.dart';
import 'package:pyro_time_interceptor_hub/pyro_time_interceptor_hub.dart';
import 'package:pyro_time_interceptor_driver/pyro_time_interceptor_driver.dart';
import 'package:pyro_call_filter_protocol/pyro_call_filter_protocol.dart';
import 'package:pyro_call_filter_hub/pyro_call_filter_hub.dart';

/// 自提供的时间窗口过滤器 Driver
class TimeWindowFilterDriver implements CallFilterInterface {
  @override
  CallFilterType get filterType => const CallFilterType(id: 'timeWindow');

  @override
  Future<bool> shouldAcceptCall(String phoneNumber) async {
    final shouldIntercept = await TimeInterceptorControlCenter.instance.shouldIntercept(phoneNumber);
    return !shouldIntercept;
  }

  @override
  Future<void> initialize() async {}
}

/// 时间拦截外观装配线 (Facade Assembly & Self-Registration)
class PyroTimeInterceptorConnector {
  static void registerAll({TimeInterceptorLogDriver? customLogDriver}) {
    final driver = customLogDriver ?? MemoryTimeInterceptorLogDriver();
    TimeInterceptorControlCenter.instance.registerLogDriver(driver);

    // 【核心：自提供 + 向 call_filter 自注册】
    EnhancedCompositeFilterService.instance.registerFilter(TimeWindowFilterDriver());
  }
}
