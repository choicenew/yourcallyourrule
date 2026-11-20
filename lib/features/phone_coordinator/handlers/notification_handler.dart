import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_phone_caller_identity_protocol/pyro_phone_caller_identity_protocol.dart';
import 'package:yourcallyourrule/core/coordinator/app_coordinator.dart';
import 'package:yourcallyourrule/features/phone_call/call_overlay/services/fraud_detection_service.dart';

final notificationHandlerProvider = Provider<NotificationHandler>((ref) {
  return NotificationHandler(ref);
});

class NotificationHandler {
  final Ref _ref;

  NotificationHandler(this._ref);

  Future<void> showCallerIdNotification({
    required CallerIdData callerIdData,
    required Map<String, dynamic>? simInfo,
    required Map<String, dynamic>? stirInfo,
  }) async {
    final isFraudCall = FraudDetectionService.checkForFraudLabels(callerIdData);
    final String title = (callerIdData.name != null && callerIdData.name!.isNotEmpty)
        ? callerIdData.name!
        : callerIdData.phoneNumber;

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

    final coordinator = _ref.read(appCoordinatorProvider);
    coordinator.emit('show_system_notification', {
      'title': title,
      'body': locationInfo.isNotEmpty ? locationInfo : callerIdData.phoneNumber,
      'type': 'blocked_call',
      'notificationId': callerIdData.phoneNumber.hashCode,
      'payload': {
        'phoneNumber': callerIdData.phoneNumber,
        'isFraud': isFraudCall,
      },
    });
  }

  Future<void> cancelNotification() async {
    final coordinator = _ref.read(appCoordinatorProvider);
    coordinator.emit('clear_notifications_by_type', {'type': 'blocked_call'});
  }
}
