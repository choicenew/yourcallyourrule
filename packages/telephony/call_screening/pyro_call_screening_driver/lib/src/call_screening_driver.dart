import 'package:pyro_call_screening_hub/pyro_call_screening_hub.dart';
import 'call_screening_api.g.dart';

class CallScreeningDriver implements ICallScreeningAdapter, CallScreeningFlutterApi {
  static CallScreeningDriver? _instance;

  static void register() {
    _instance ??= CallScreeningDriver();
    CallScreeningHub.instance.registerAdapter(_instance!);
  }

  static void unregister() {
    _instance?.dispose();
    _instance = null;
  }

  final CallScreeningHostApi _hostApi;

  CallScreeningDriver({CallScreeningHostApi? hostApi})
      : _hostApi = hostApi ?? CallScreeningHostApi() {
    CallScreeningFlutterApi.setUp(this);
  }

  void dispose() {
    CallScreeningFlutterApi.setUp(null);
  }

  @override
  Future<CallScreeningDecision> evaluateCall(CallScreeningRequest request) async {
    final entity = IncomingCallEntity(
      callId: request.callId,
      phoneNumber: request.phoneNumber,
      normalizedNumber: request.normalizedNumber,
      timestampMs: request.timestampMs,
    );
    final action = await onScreeningRequested(entity);
    return CallScreeningDecision(
      action: action.toCode(),
      reason: 'Evaluated via CallScreeningHub',
    );
  }

  @override
  String get providerId => 'pyro_call_screening_driver';

  @override
  Future<CallActionType> onScreeningRequested(IncomingCallEntity call) async {
    return await CallScreeningHub.instance.evaluateIncomingCall(call);
  }

  Future<bool> isServiceActive() async {
    try {
      return await _hostApi.isServiceActive();
    } catch (_) {
      return false;
    }
  }

  Future<bool> isRoleGranted() async {
    try {
      return await _hostApi.isRoleGranted();
    } catch (_) {
      return false;
    }
  }

  Future<void> requestRole() async {
    try {
      await _hostApi.requestRole();
    } catch (_) {}
  }
}
