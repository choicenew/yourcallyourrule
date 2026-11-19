import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_phone_call_interception_policy_protocol/pyro_phone_call_interception_policy_protocol.dart';

part 'call_policy_control_center.g.dart';

@Riverpod(keepAlive: true)
CallPolicyControlCenter callPolicyControlCenter(Ref ref) {
  return CallPolicyControlCenter();
}

/// 通话防护策略控制中心 (CallPolicyControlCenter)
class CallPolicyControlCenter {
  CallPolicyControlCenter();

  CallPolicyStorageDriver? _storageDriver;
  Map<String, InterceptAction> _labelActionPolicies = {};

  void registerStorageDriver(CallPolicyStorageDriver driver) {
    _storageDriver = driver;
    debugPrint('[CallPolicyHub] 已挂载注册策略驱动: ${driver.runtimeType}');
  }

  CallPolicyStorageDriver? get storageDriver => _storageDriver;

  void updateLabelActionPolicies(Map<String, InterceptAction> policies) {
    _labelActionPolicies = Map.unmodifiable(policies);
  }

  Map<String, InterceptAction> get labelActionPolicies => _labelActionPolicies;

  /// 根据命中的标签列表裁决最终的拦截动作 (按策略覆写)
  InterceptAction resolveActionForLabels({
    required Iterable<String> labels,
    InterceptAction defaultAction = InterceptAction.endCall,
  }) {
    if (labels.isEmpty || _labelActionPolicies.isEmpty) {
      return defaultAction;
    }
    for (final label in labels) {
      final action = _labelActionPolicies[label];
      if (action != null && action.isAllow) {
        return InterceptAction.allow;
      }
    }
    for (final label in labels) {
      final action = _labelActionPolicies[label];
      if (action != null) {
        return action;
      }
    }
    return defaultAction;
  }

  InterceptAction evaluateInterceptAction({
    required bool filterAccepted,
    required bool isTimeIntercepted,
  }) {
    if (!filterAccepted) {
      if (isTimeIntercepted) {
        return InterceptAction.silenceNoAnswer;
      }
      return InterceptAction.endCall;
    }
    return InterceptAction.endCall;
  }
}
