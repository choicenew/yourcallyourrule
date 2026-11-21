import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_phone_caller_identity_protocol/pyro_phone_caller_identity_protocol.dart';
import 'package:yourcallyourrule/features/phone_evaluators/evaluators/call_policy_evaluator.dart';

part 'live_activity_handler.g.dart';

@Riverpod(keepAlive: true)
LiveActivityHandler liveActivityHandler(Ref ref) {
  return LiveActivityHandler(ref);
}

class LiveActivityHandler {
  final Ref _ref;

  LiveActivityHandler(this._ref);

  Future<void> showCallerIdActivity({
    required CallerIdData callerIdData,
    required Map<String, dynamic>? simInfo,
    required Map<String, dynamic>? stirInfo,
  }) async {
    final bool isFraudCall = CallPolicyEvaluator.hasFraudIndicator(
      phoneNumber: callerIdData.phoneNumber,
      labels: callerIdData.labels,
    );
    debugPrint('[LiveActivityHandler] Showing Live Activity for ${callerIdData.phoneNumber}, Fraud? $isFraudCall');
  }

  Future<void> endActivity() async {}
}
