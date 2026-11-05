import 'package:flutter/services.dart';
import 'package:pyro_sms_hub/pyro_sms_hub.dart';

/// NotificationListenerService-based driver allowing permission-free SMS/messaging notification screening
class SmsNotificationListenerDriver implements SmsNotificationListenerAdapter {
  static SmsNotificationListenerDriver? _instance;

  /// Self-registers this driver instance to SmsHub
  static void register() {
    _instance ??= SmsNotificationListenerDriver();
    SmsHub.instance.registerNotificationListener(_instance!);
  }

  static void unregister() {
    _instance?.dispose();
    _instance = null;
  }

  static const MethodChannel _channel = MethodChannel('net.pyro.telephony/sms_notification_listener');

  @override
  String get providerId => 'pyro_sms_driver_notification_listener';

  Function(SmsMessageEntity message)? _messageHandler;
  final List<SmsEvidenceItem> _inMemoryEvidenceLogs = [];
  List<String> _protectedPackages = ProtectedAppInfo.defaults.map((e) => e.packageName).toList();

  SmsNotificationListenerDriver() {
    _channel.setMethodCallHandler(_handleMethodCall);
  }

  void dispose() {
    _channel.setMethodCallHandler(null);
    _messageHandler = null;
  }

  Future<dynamic> _handleMethodCall(MethodCall call) async {
    if (call.method == 'onNotificationReceived') {
      final map = Map<String, dynamic>.from(call.arguments as Map);
      final entity = SmsMessageEntity.fromJson(map);
      _messageHandler?.call(entity);
    }
  }

  @override
  Future<bool> isPermissionGranted() async {
    try {
      final bool? granted = await _channel.invokeMethod<bool>('isPermissionGranted');
      return granted ?? false;
    } on MissingPluginException {
      return false;
    }
  }

  @override
  Future<void> requestPermission() async {
    try {
      await _channel.invokeMethod('requestPermission');
    } on MissingPluginException {
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
      final bool? success = await _channel.invokeMethod<bool>('cancelNotification', {
        'key': notificationKey,
      });
      return success ?? true;
    } on MissingPluginException {
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
      await _channel.invokeMethod('saveEvidence', evidence.toJson());
    } on MissingPluginException {
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
      await _channel.invokeMethod('setProtectedPackages', {'packages': packageNames});
    } on MissingPluginException {
      // Fallback
    }
  }
}
