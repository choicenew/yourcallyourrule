import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(PigeonOptions(
  dartOut: 'lib/src/call_redirection_api.g.dart',
  kotlinOut: 'android/src/main/kotlin/com/pyro/call_redirection/CallRedirectionApi.g.kt',
  kotlinOptions: KotlinOptions(package: 'com.pyro.call_redirection'),
))

class PigeonRedirectionRequest {
  PigeonRedirectionRequest({
    required this.id,
    required this.rawPhoneNumber,
    required this.normalizedPhoneNumber,
    required this.timestampMs,
    required this.isInteractiveAllowed,
    required this.isCarModeActive,
  });

  String id;
  String rawPhoneNumber;
  String normalizedPhoneNumber;
  int timestampMs;
  bool isInteractiveAllowed;
  bool isCarModeActive;
}

class PigeonRedirectionDecision {
  PigeonRedirectionDecision({
    required this.action,
    this.reason,
  });

  String action;
  String? reason;
}

@FlutterApi()
abstract class CallRedirectionFlutterApi {
  @async
  PigeonRedirectionDecision evaluateCall(PigeonRedirectionRequest request);
}

@HostApi()
abstract class CallRedirectionHostApi {
  bool isServiceActive();
  bool isRoleGranted();
  bool requestRole();
}
