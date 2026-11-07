import 'package:pyro_call_interception_policy_protocol/src/models/intercept_action.dart';

/// 策略配置 Driver 抽象接口契约 (CallPolicyStorageDriver)
abstract class CallPolicyStorageDriver {
  Future<InterceptAction> getDefaultAction();
  Future<void> setDefaultAction(InterceptAction action);
}
