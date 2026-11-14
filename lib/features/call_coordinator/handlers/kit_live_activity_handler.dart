import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:live_activity_kit/live_activity_kit.dart';
import 'package:pyro_phone_caller_identity_protocol/pyro_phone_caller_identity_protocol.dart';
import 'package:yourcallyourrule/features/call/call_overlay/services/fraud_detection_service.dart';
import 'package:yourcallyourrule/features/call/live_activities/live_activity_config/live_notification_config.dart';
import 'package:yourcallyourrule/features/call/live_activities/providers/live_notification_config_provider.dart';

final kitLiveActivityHandlerProvider = FutureProvider<KitLiveActivityHandler>((ref) async {
  final config = await ref.watch(liveNotificationConfigProvider.future);
  return KitLiveActivityHandler(ref, config);
});

class KitLiveActivityHandler {
  final Ref _ref;
  final LiveNotificationConfig _config;
  String? _currentActivityId;

  KitLiveActivityHandler(this._ref, this._config);

  Future<void> showCallerIdActivity({
    required CallerIdData callerIdData,
    required Map<String, dynamic>? simCardData,
    required Map<String, dynamic>? stirData,
  }) async {
    final bool isFraudCall = FraudDetectionService.checkForFraudLabels(callerIdData);

    try {
      if (_currentActivityId != null) {
        await LiveActivity.update(
          id: _currentActivityId!,
          lockScreen: LA.text(callerIdData.name ?? 'Incoming Call'),
        );
      } else {
        final id = 'call_activity_${DateTime.now().millisecondsSinceEpoch}';
        await LiveActivity.show(
          id: id,
          lockScreen: LA.text(callerIdData.name ?? 'Incoming Call'),
        );
        _currentActivityId = id;
      }
    } catch (e) {
      debugPrint('[KitLiveActivityHandler] Error managing Live Activity: $e');
    }
  }

  Future<void> endActivity() async {
    if (_currentActivityId != null) {
      try {
        await LiveActivity.end(id: _currentActivityId!);
        _currentActivityId = null;
      } catch (e) {
        debugPrint('[KitLiveActivityHandler] Error ending Live Activity: $e');
      }
    }
  }
}
