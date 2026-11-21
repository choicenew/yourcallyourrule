import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(PigeonOptions(
  dartOut: 'lib/src/sms_notification_listener_api.g.dart',
  dartOptions: DartOptions(),
  kotlinOut:
      'android/src/main/kotlin/com/pyro/sms_notification_listener/SmsNotificationListenerApi.g.kt',
  kotlinOptions: KotlinOptions(
    package: 'com.pyro.sms_notification_listener',
  ),
))
class SmsNotificationPayloadDetails {
  String? id;
  String? sender;
  String? body;
  String? packageName;
  int? timestampMs;
}

class SmsEvidencePayloadDetails {
  String? key;
  String? packageName;
  String? sender;
  String? body;
  int? timestampMs;
}

@HostApi()
abstract class SmsNotificationListenerHostApi {
  bool isPermissionGranted();
  void requestPermission();
  bool cancelNotification(String key);
  bool saveEvidence(SmsEvidencePayloadDetails evidence);
  bool setProtectedPackages(List<String> packages);
}

@FlutterApi()
abstract class SmsNotificationListenerFlutterApi {
  void onNotificationReceived(SmsNotificationPayloadDetails notification);
}
