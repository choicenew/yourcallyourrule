import 'package:flutter/foundation.dart';
import 'package:pyro_call_interception_policy_protocol/pyro_call_interception_policy_protocol.dart';

/// 真实内存级策略持久化驱动 (MemoryCallPolicyStorageDriver)
class MemoryCallPolicyStorageDriver implements CallPolicyStorageDriver {
  InterceptAction _defaultAction = InterceptAction.endCall;

  MemoryCallPolicyStorageDriver();

  @override
  Future<InterceptAction> getDefaultAction() async {
    return _defaultAction;
  }

  @override
  Future<void> setDefaultAction(InterceptAction action) async {
    _defaultAction = action;
    debugPrint('[MemoryPolicyDriver] 持久化保存默认拦截动作: ${action.actionName}');
  }
}
