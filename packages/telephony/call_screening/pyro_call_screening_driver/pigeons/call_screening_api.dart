import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(PigeonOptions(
  dartOut: 'lib/src/call_screening_api.g.dart',
  kotlinOut: 'android/src/main/kotlin/com/pyro/call_screening/CallScreeningApi.g.kt',
  kotlinOptions: KotlinOptions(package: 'com.pyro.call_screening'),
))

class CallScreeningRequest {
  CallScreeningRequest({
    required this.callId,
    required this.phoneNumber,
    required this.normalizedNumber,
    required this.timestampMs,
  });

  String callId;
  String phoneNumber;
  String normalizedNumber;
  int timestampMs;
}

class CallScreeningDecision {
  CallScreeningDecision({
    required this.action,
    this.reason,
  });

  String action;
  String? reason;
}

@FlutterApi()
abstract class CallScreeningFlutterApi {
  @async
  CallScreeningDecision evaluateCall(CallScreeningRequest request);
}

@HostApi()
abstract class CallScreeningHostApi {
  bool isServiceActive();
  bool isRoleGranted();
  bool requestRole();
}

