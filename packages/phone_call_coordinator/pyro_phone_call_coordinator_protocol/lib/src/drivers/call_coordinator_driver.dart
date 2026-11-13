import 'package:pyro_phone_call_coordinator_protocol/src/models/call_coordinator_data.dart';

/// Coordinator 界面/通知响应驱动 Driver 抽象接口契约 (CallCoordinatorDriver)
abstract class CallCoordinatorDriver {
  Future<void> onCallDataPublished(CallCoordinatorData data);
}
