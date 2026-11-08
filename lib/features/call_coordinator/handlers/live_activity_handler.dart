import 'package:flutter/foundation.dart';
import 'package:live_activity_kit/live_activity_kit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:pyro_telephony_protocol/pyro_telephony_protocol.dart';
import 'package:pyro_telephony_protocol/pyro_telephony_protocol.dart';
import 'package:pyro_caller_identity_protocol/pyro_caller_identity_protocol.dart';
import 'package:yourcallyourrule/features/config/data/repositories/config_repository.dart';
import 'package:yourcallyourrule/features/common/router/app_router.dart';
import 'package:yourcallyourrule/features/call/call_overlay/services/fraud_detection_service.dart';
import 'package:yourcallyourrule/features/call/live_activities/services/live_notification_config_service.dart';
import 'package:yourcallyourrule/features/call/live_activities/services/notification_payload_builder.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

part 'live_activity_handler.g.dart';

@Riverpod(keepAlive: true)
Future<LiveActivityHandler> liveActivityHandler(Ref ref) async {
  final configRepository = ref.watch(configRepositoryProvider);
  final configService = LiveNotificationConfigService(configRepository);

  final handler = LiveActivityHandler(configService: configService);
  await handler.initialize();
  return handler;
}

class LiveActivityHandler {
  final LiveNotificationConfigService _configService;
  final Uuid _uuid;

  String? _currentActivityId;

  LiveActivityHandler({required LiveNotificationConfigService configService})
      : _configService = configService,
        _uuid = const Uuid();

  Future<void> initialize({Function(String?)? onNotificationTapped}) async {}

  Future<void> showCallerIdActivity({
    required CallerIdData callerIdData,
    required SimInfo? simInfo,
    required StirInfo? stirInfo,
  }) async {
    try {
      final context = AppRouter.navigatorKey.currentContext;
      final bool isFraudCall = FraudDetectionService.checkForFraudLabels(callerIdData);

      final String securityMessageText = () {
        if (context != null) {
          return AppLocalizations.of(context).securityMessage;
        }
        return 'Do not trust any phone calls. Always verify customer service numbers independently. Never share passwords, verification codes, card numbers, or personal information.';
      }();

      final config = await _configService.loadConfigOrDefault();
      final payload = await LiveNotificationPayloadBuilder.build(
        config,
        callerIdData,
        simInfo,
        stirInfo,
        securityMessage: isFraudCall ? securityMessageText : null,
        isFraudCall: isFraudCall,
      );

      final activityId = _currentActivityId ?? _uuid.v4();

      if (_currentActivityId != null) {
        await LiveActivity.update(
          id: activityId,
          lockScreen: payload.lockScreen,
          compactLeading: payload.compactLeading,
          compactTrailing: payload.compactTrailing,
          minimal: payload.minimal,
          expandedLeading: payload.expandedLeading,
          expandedCenter: payload.expandedCenter,
          expandedBottom: payload.expandedBottom,
        );
      } else {
        await LiveActivity.show(
          id: activityId,
          lockScreen: payload.lockScreen,
          compactLeading: payload.compactLeading,
          compactTrailing: payload.compactTrailing,
          minimal: payload.minimal,
          expandedLeading: payload.expandedLeading,
          expandedCenter: payload.expandedCenter,
          expandedBottom: payload.expandedBottom,
        );
        _currentActivityId = activityId;
      }
    } catch (e) {
      debugPrint('Failed to show/update Live Activity: $e');
    }
  }

  Future<void> endActivity() async {
    if (_currentActivityId != null) {
      try {
        await LiveActivity.end(id: _currentActivityId!);
        _currentActivityId = null;
      } catch (e) {
        debugPrint('Failed to end Live Activity: $e');
        _currentActivityId = null;
      }
    }
  }
}
