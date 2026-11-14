import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_phone_caller_identity_protocol/pyro_phone_caller_identity_protocol.dart';
import 'package:yourcallyourrule/features/common/utils/avatar_utils.dart';
import 'package:yourcallyourrule/features/common/router/app_router.dart';
import 'package:yourcallyourrule/features/call/call_overlay/services/fraud_detection_service.dart';
import 'package:yourcallyourrule/features/notifications/service/notification_service.dart';
import 'package:yourcallyourrule/features/notifications/providers/notification_providers.dart';

final notificationHandlerProvider = Provider<NotificationHandler>((ref) {
  final notificationService = ref.watch(notificationServiceProvider);
  return NotificationHandler(ref, notificationService);
});

class NotificationHandler {
  final Ref _ref;
  final dynamic _notificationService;

  NotificationHandler(this._ref, this._notificationService);

  Future<void> showCallerIdNotification({
    required CallerIdData callerIdData,
    required Map<String, dynamic>? simInfo,
    required Map<String, dynamic>? stirInfo,
  }) async {
    final isFraudCall = FraudDetectionService.checkForFraudLabels(callerIdData);
    final String title = (callerIdData.name != null && callerIdData.name!.isNotEmpty)
        ? callerIdData.name!
        : callerIdData.phoneNumber;

    final String? labelText = callerIdData.labels.isNotEmpty ? callerIdData.labels.first : null;
    final ImageProvider? avatarProvider = AvatarUtils.getAvatarImage(null, labelText);

    final List<String> details = [];
    if (callerIdData.carrier != null && callerIdData.carrier!.isNotEmpty) {
      details.add(callerIdData.carrier!);
    }
    if (callerIdData.region != null && callerIdData.region!.isNotEmpty) {
      details.add(callerIdData.region!);
    }
    if (callerIdData.countryName != null && callerIdData.countryName!.isNotEmpty) {
      details.add(callerIdData.countryName!);
    }
    final String locationInfo = details.join(' · ');

    final context = AppRouter.navigatorKey.currentContext;
    if (context != null) {
      final config = NotificationService.blockedCallConfig(context);
      await _notificationService.showNotification(
        title: title,
        body: locationInfo.isNotEmpty ? locationInfo : callerIdData.phoneNumber,
        config: config,
        notificationId: callerIdData.phoneNumber.hashCode,
        payload: {
          'phoneNumber': callerIdData.phoneNumber,
          'isFraud': isFraudCall,
        },
      );
    }
  }

  Future<void> cancelNotification() async {
    await _notificationService.cancelAllNotifications();
  }
}
