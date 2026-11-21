import 'package:flutter/services.dart';
import 'package:pyro_sms_hub/pyro_sms_hub.dart';
import 'sms_notification_listener_api.g.dart';

/// NotificationListenerService-based driver allowing permission-free SMS/messaging notification screening
class SmsNotificationListenerDriver implements SmsNotificationListenerAdapter {
  /// Registers this driver to the provided SmsHub
  static SmsNotificationListenerDriver register(SmsHub hub) {
    final driver = SmsNotificationListenerDriver();
    hub.registerNotificationListener(driver);
    return driver;
  }

  final SmsNotificationListenerHostApi _hostApi;
  _NotificationListenerFlutterApiHandler? _flutterApiHandler;

  @override
  String get providerId => 'pyro_sms_driver_notification_listener';

  Function(SmsMessageEntity message)? _messageHandler;
  final List<SmsEvidenceItem> _inMemoryEvidenceLogs = [];
  List<String> _protectedPackages = ProtectedAppInfo.defaults.map((e) => e.packageName).toList();

  SmsNotificationListenerDriver({SmsNotificationListenerHostApi? hostApi})
      : _hostApi = hostApi ?? SmsNotificationListenerHostApi() {
    _flutterApiHandler = _NotificationListenerFlutterApiHandler(this);
    SmsNotificationListenerFlutterApi.setUp(_flutterApiHandler);
  }

  void dispose() {
    SmsNotificationListenerFlutterApi.setUp(null);
    _flutterApiHandler = null;
    _messageHandler = null;
  }

  void _handleNativeNotification(SmsNotificationPayloadDetails notification) {
    final entity = SmsMessageEntity(
      id: notification.id ?? '',
      sender: notification.sender ?? '',
      body: notification.body ?? '',
      timestamp: DateTime.fromMillisecondsSinceEpoch(
          notification.timestampMs ?? DateTime.now().millisecondsSinceEpoch),
      packageName: notification.packageName,
    );
    _messageHandler?.call(entity);
  }

  @override
  Future<bool> isPermissionGranted() async {
    try {
      return await _hostApi.isPermissionGranted();
    } on PlatformException {
      return false;
    }
  }

  @override
  Future<void> requestPermission() async {
    try {
      await _hostApi.requestPermission();
    } on PlatformException {
      // Fallback
    }
  }

  @override
  void onNotificationReceived(Function(SmsMessageEntity message) handler) {
    _messageHandler = handler;
  }

  @override
  Future<bool> cancelNotification(String notificationKey) async {
    try {
      return await _hostApi.cancelNotification(notificationKey);
    } on PlatformException {
      return true;
    }
  }

  @override
  Future<void> saveEvidence(SmsEvidenceItem evidence) async {
    _inMemoryEvidenceLogs.insert(0, evidence);
    if (_inMemoryEvidenceLogs.length > 200) {
      _inMemoryEvidenceLogs.removeLast();
    }
    try {
      await _hostApi.saveEvidence(SmsEvidencePayloadDetails(
        key: evidence.evidenceId,
        packageName: evidence.message.packageName,
        sender: evidence.message.sender,
        body: evidence.message.body,
        timestampMs: evidence.capturedAt.millisecondsSinceEpoch,
      ));
    } on PlatformException {
      // In-memory fallback
    }
  }

  List<SmsEvidenceItem> getCapturedEvidenceLogs() => List.unmodifiable(_inMemoryEvidenceLogs);

  @override
  Future<List<String>> getProtectedPackages() async => _protectedPackages;

  @override
  Future<void> setProtectedPackages(List<String> packageNames) async {
    _protectedPackages = List.from(packageNames);
    try {
      await _hostApi.setProtectedPackages(packageNames);
    } on PlatformException {
      // Fallback
    }
  }
}

class _NotificationListenerFlutterApiHandler implements SmsNotificationListenerFlutterApi {
  _NotificationListenerFlutterApiHandler(this._driver);
  final SmsNotificationListenerDriver _driver;

  @override
  void onNotificationReceived(SmsNotificationPayloadDetails notification) {
    _driver._handleNativeNotification(notification);
  }
}
