import 'package:flutter/services.dart';
import 'package:pyro_sms_protocol/pyro_sms_protocol.dart';
import 'package:pyro_sms_hub/pyro_sms_hub.dart';

/// Fallback driver connecting to native Android Telephony SMS_RECEIVED BroadcastReceiver and ContentProvider
class TelephonyFallbackDriver implements SmsFilterAdapter {
  /// Self-registers this driver instance to SmsHub
  static void register() {
    SmsHub.instance.registerFilter(TelephonyFallbackDriver());
  }

  static const MethodChannel _channel =
      MethodChannel('com.yours.pyro_sms/telephony_fallback');

  @override
  String get providerId => 'pyro_sms_driver_telephony_fallback';

  @override
  String get displayName => 'Telephony SMS Receiver Fallback Shim';

  @override
  bool isEnabled;

  Function(SmsMessageEntity message)? _smsReceivedHandler;

  TelephonyFallbackDriver({this.isEnabled = true}) {
    _channel.setMethodCallHandler(_handleMethodCall);
  }

  Future<dynamic> _handleMethodCall(MethodCall call) async {
    if (call.method == 'onSmsReceived') {
      final map = Map<String, dynamic>.from(call.arguments as Map);
      final entity = SmsMessageEntity.fromJson(map);
      _smsReceivedHandler?.call(entity);
    }
  }

  void onSmsReceived(Function(SmsMessageEntity message) handler) {
    _smsReceivedHandler = handler;
  }

  Future<bool> isSmsPermissionGranted() async {
    try {
      final bool? granted = await _channel.invokeMethod<bool>('isSmsPermissionGranted');
      return granted ?? false;
    } on MissingPluginException {
      return false;
    }
  }

  @override
  Future<SmsScreeningResult?> screenMessage(SmsMessageEntity message) async {
    return null;
  }
}
