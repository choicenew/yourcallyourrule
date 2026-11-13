import 'package:flutter/foundation.dart';
import 'package:pyro_phone_call_coordinator_protocol/pyro_phone_call_coordinator_protocol.dart';

/// 真实日志打印编排驱动 (LoggingCallCoordinatorDriver)
class LoggingCallCoordinatorDriver implements CallCoordinatorDriver {
  LoggingCallCoordinatorDriver();

  @override
  Future<void> onCallDataPublished(CallCoordinatorData data) async {
    debugPrint('[LoggingCoordinatorDriver] 监听到 Coordinator 发布 CallData: ${data.phoneNumber} (${data.actionName})');
  }
}
