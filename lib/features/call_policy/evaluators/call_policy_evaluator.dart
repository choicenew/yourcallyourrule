import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:yourcallyourrule/core/entities/call/sim_info.dart';
import 'package:yourcallyourrule/features/call/call_filter/call_filter_interface.dart';
import 'package:yourcallyourrule/features/call/call_filter/enhanced_composite_filter_service.dart';
import 'package:yourcallyourrule/features/call/time_interceptor/service/time_interceptor_service.dart';

part 'call_policy_evaluator.g.dart';

@Riverpod(keepAlive: true)
CallPolicyEvaluator callPolicyEvaluator(Ref ref) {
  final callFilterService = ref.watch(enhancedCompositeFilterServiceProvider);
  final timeInterceptorService = ref.watch(timeInterceptorServiceProvider);
  return CallPolicyEvaluator(
    callFilterService: callFilterService,
    timeInterceptorService: timeInterceptorService,
  );
}

/// 通用呼叫策略评估服务 (支持号码多格式并行测试、卡槽规则与时间段拦截决策)
class CallPolicyEvaluator {
  final CallFilterInterface _callFilterService;
  final TimeInterceptorService _timeInterceptorService;

  CallPolicyEvaluator({
    required CallFilterInterface callFilterService,
    required TimeInterceptorService timeInterceptorService,
  })  : _callFilterService = callFilterService,
        _timeInterceptorService = timeInterceptorService;

  /// 评估号码是否应该放行 (true 表示放行，false 表示拦截/拒接)
  Future<bool> evaluateShouldAccept({
    required String rawNumber,
    required String nationalNumber,
    required String e164Number,
    SimInfo? simInfo,
  }) async {
    final numbersToTest = [
      rawNumber,
      nationalNumber,
      e164Number,
    ].where((n) => n.isNotEmpty).cast<String>();

    final filterService = _callFilterService;
    if (filterService is EnhancedCompositeFilterService) {
      await filterService.initialize();
    }

    final shouldAccept = await Future.any(
      numbersToTest.map((number) async {
        bool decision;
        if (filterService is EnhancedCompositeFilterService && simInfo != null) {
          decision = await filterService.shouldAcceptCallWithSim(number, simInfo: simInfo);
        } else {
          decision = await _callFilterService.shouldAcceptCall(number);
        }

        if (!decision) {
          decision = !await _timeInterceptorService.shouldIntercept(number);
        }
        return decision;
      }),
    );

    debugPrint('[CallPolicyEvaluator] 策略评估完成: $rawNumber -> 放行? $shouldAccept');
    return shouldAccept;
  }
}
