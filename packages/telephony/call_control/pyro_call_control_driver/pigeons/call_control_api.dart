import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(PigeonOptions(
  dartOut: 'lib/src/call_control_api.g.dart',
  kotlinOut: 'android/src/main/kotlin/com/pyro/call_control/CallControlApi.g.kt',
  kotlinOptions: KotlinOptions(package: 'com.pyro.call_control'),
))

class CallControlActionRequest {
  CallControlActionRequest({
    required this.actionType,
    required this.phoneNumber,
    required this.delayHangupMs,
    required this.enableMicMuteProtection,
  });

  String actionType;
  String phoneNumber;
  int delayHangupMs;
  bool enableMicMuteProtection;
}

class CallControlActionResult {
  CallControlActionResult({
    required this.success,
    required this.actionType,
    required this.message,
    required this.executedAtMs,
  });

  bool success;
  String actionType;
  String message;
  int executedAtMs;
}

@HostApi()
abstract class CallControlHostApi {
  CallControlActionResult executeAction(CallControlActionRequest request);
  bool setMicrophoneMuted(bool muted);
}

