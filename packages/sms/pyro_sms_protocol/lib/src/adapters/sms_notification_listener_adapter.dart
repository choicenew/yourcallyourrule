import '../models/sms_evidence_item.dart';
import '../models/sms_message_entity.dart';

/// Adapter for NotificationListenerService-based SMS notification screening without SMS permissions
abstract class SmsNotificationListenerAdapter {
  String get providerId;
  Future<bool> isPermissionGranted();
  Future<void> requestPermission();
  
  /// Register callback for intercepted notifications from protected messaging apps
  void onNotificationReceived(Function(SmsMessageEntity message) handler);

  /// Dismiss/cancel system notification by key/id
  Future<bool> cancelNotification(String notificationKey);

  /// Save captured evidence sample
  Future<void> saveEvidence(SmsEvidenceItem evidence);

  /// Get list of protected messaging app package names
  Future<List<String>> getProtectedPackages();

  /// Set protected messaging app package names
  Future<void> setProtectedPackages(List<String> packageNames);
}
