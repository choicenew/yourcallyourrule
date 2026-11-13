import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_phone_call_interception_policy_protocol/pyro_phone_call_interception_policy_protocol.dart';

part 'call_policy_control_center.g.dart';

@Riverpod(keepAlive: true)
CallPolicyControlCenter callPolicyControlCenter(Ref ref) {
  return CallPolicyControlCenter.instance;
}

/// 通话防护策略控制中心 (CallPolicyControlCenter)
class CallPolicyControlCenter {
  static final CallPolicyControlCenter instance = CallPolicyControlCenter._();

  CallPolicyControlCenter._();

  CallPolicyStorageDriver? _storageDriver;

  void registerStorageDriver(CallPolicyStorageDriver driver) {
    _storageDriver = driver;
    debugPrint('[CallPolicyHub] 已挂载注册策略驱动: ${driver.runtimeType}');
  }

  CallPolicyStorageDriver? get storageDriver => _storageDriver;

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
