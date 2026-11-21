import 'package:flutter/services.dart';
import 'package:pyro_sms_hub/pyro_sms_hub.dart';
import 'telephony_fallback_api.g.dart';

/// Fallback driver connecting to native Android Telephony SMS_RECEIVED BroadcastReceiver and ContentProvider
class TelephonyFallbackDriver implements SmsFilterAdapter {
  /// Registers this driver to the provided SmsHub
  static TelephonyFallbackDriver register(SmsHub hub) {
    final driver = TelephonyFallbackDriver();
    hub.registerFilter(driver);
    return driver;
  }

  final TelephonyFallbackHostApi _hostApi;
  _TelephonyFallbackFlutterApiHandler? _flutterApiHandler;

  @override
  String get providerId => 'pyro_sms_driver_telephony_fallback';

  @override
  String get displayName => 'Telephony SMS Receiver Fallback Shim';

  @override
  bool isEnabled;

  Function(SmsMessageEntity message)? _smsReceivedHandler;

  TelephonyFallbackDriver({this.isEnabled = true, TelephonyFallbackHostApi? hostApi})
      : _hostApi = hostApi ?? TelephonyFallbackHostApi() {
    _flutterApiHandler = _TelephonyFallbackFlutterApiHandler(this);
    TelephonyFallbackFlutterApi.setUp(_flutterApiHandler);
  }

  void dispose() {
    TelephonyFallbackFlutterApi.setUp(null);
    _flutterApiHandler = null;
    _smsReceivedHandler = null;
  }

  void _handleNativeSms(TelephonySmsPayloadDetails message) {
    final entity = SmsMessageEntity(
      id: message.id ?? '',
      sender: message.sender ?? '',
      body: message.body ?? '',
      timestamp: DateTime.fromMillisecondsSinceEpoch(
          message.timestampMs ?? DateTime.now().millisecondsSinceEpoch),
    );
    _smsReceivedHandler?.call(entity);
  }

  void onSmsReceived(Function(SmsMessageEntity message) handler) {
    _smsReceivedHandler = handler;
  }

  Future<bool> isSmsPermissionGranted() async {
    try {
      return await _hostApi.isSmsPermissionGranted();
    } on PlatformException {
      return false;
    }
  }

  @override
  Future<SmsScreeningResult?> screenMessage(SmsMessageEntity message) async {
    return null;
  }
}

class _TelephonyFallbackFlutterApiHandler implements TelephonyFallbackFlutterApi {
  _TelephonyFallbackFlutterApiHandler(this._driver);
  final TelephonyFallbackDriver _driver;

  @override
  void onSmsReceived(TelephonySmsPayloadDetails message) {
    _driver._handleNativeSms(message);
  }
}
