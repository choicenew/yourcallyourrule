import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:pyro_telephony_hub/pyro_telephony_hub.dart';
import 'package:pyro_call_filter_hub/pyro_call_filter_hub.dart';
import '../../call_filter/enhanced_composite_filter_service.dart' hide enhancedCompositeFilterServiceProvider;
import '../../time_interceptor/service/time_interceptor_service.dart';

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

/// 通用呼叫策略评估服务
class CallPolicyEvaluator {
  final EnhancedCompositeFilterService _callFilterService;
  final TimeInterceptorService _timeInterceptorService;

  CallPolicyEvaluator({
    required EnhancedCompositeFilterService callFilterService,
    required TimeInterceptorService timeInterceptorService,
  })  : _callFilterService = callFilterService,
        _timeInterceptorService = timeInterceptorService;

  Future<CallPolicyResult> evaluate(String phoneNumber, {int? simSlotIndex}) async {
    final shouldTimeIntercept = await _timeInterceptorService.shouldIntercept(phoneNumber);
    if (shouldTimeIntercept) {
      return const CallPolicyResult(
        action: 'block',
        reason: 'Time interceptor triggered',
      );
    }

    final accepted = await _callFilterService.shouldAcceptCall(phoneNumber);

    return CallPolicyResult(
      action: accepted ? 'allow' : 'block',
      reason: accepted ? 'Allowed by filter' : 'Blocked by filter',
    );
  }
}

class CallPolicyResult {
  final String action;
  final String reason;

  const CallPolicyResult({
    required this.action,
    required this.reason,
  });
}
