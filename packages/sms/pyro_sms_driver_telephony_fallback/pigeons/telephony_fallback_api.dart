import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(PigeonOptions(
  dartOut: 'lib/src/telephony_fallback_api.g.dart',
  dartOptions: DartOptions(),
  kotlinOut:
      'android/src/main/kotlin/com/pyro/sms_telephony_fallback/TelephonyFallbackApi.g.kt',
  kotlinOptions: KotlinOptions(
    package: 'com.pyro.sms_telephony_fallback',
  ),
))
class TelephonySmsPayloadDetails {
  String? id;
  String? sender;
  String? body;
  int? timestampMs;
}

@HostApi()
abstract class TelephonyFallbackHostApi {
  bool isSmsPermissionGranted();
}

@FlutterApi()
abstract class TelephonyFallbackFlutterApi {
  void onSmsReceived(TelephonySmsPayloadDetails message);
}
