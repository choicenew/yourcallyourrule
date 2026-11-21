import 'dart:async';
import 'package:pyro_call_redirection_hub/pyro_call_redirection_hub.dart';
import 'call_redirection_api.g.dart';

typedef OutboundCallEvaluator = Future<RedirectionDecision?> Function(OutgoingCallEntity call);

/// Driver for CallRedirectionService outbound fraud prevention
class CallRedirectionDriver implements ICallRedirectionAdapter, CallRedirectionFlutterApi {
  static CallRedirectionDriver? _instance;
  static OutboundCallEvaluator? outboundEvaluator;

  /// Static auto-registration hook
  static void register() {
    _instance ??= CallRedirectionDriver();
    CallRedirectionHub.instance.registerRedirectionDriver(_instance!);
  }

  static void unregister() {
    _instance?.dispose();
    _instance = null;
  }

  /// Ensure mounted helper alias
  static void ensureMounted() => register();

  final CallRedirectionHostApi _hostApi;
  final Map<String, DateTime> _bypassTokens = {};

  @override
  String get providerId => 'pyro_call_redirection_driver';

  bool isEnabled;

  CallRedirectionDriver({this.isEnabled = true, CallRedirectionHostApi? hostApi})
      : _hostApi = hostApi ?? CallRedirectionHostApi() {
    CallRedirectionFlutterApi.setUp(this);
  }

  void dispose() {
    CallRedirectionFlutterApi.setUp(null);
  }

  @override
  Future<RedirectionDecisionDetails> evaluateCall(RedirectionRequestDetails request) async {
    final entity = OutgoingCallEntity(
      id: request.id,
      rawPhoneNumber: request.rawPhoneNumber,
      normalizedPhoneNumber: request.normalizedPhoneNumber,
      timestampMs: request.timestampMs,
      isInteractiveAllowed: request.isInteractiveAllowed,
      isCarModeActive: request.isCarModeActive,
    );

    final decision = await evaluateOutboundCall(entity);
    return RedirectionDecisionDetails(
      action: decision.action.name,
      reason: decision.reason?.name,
    );
  }

  @override
  Future<RedirectionDecision> evaluateOutboundCall(OutgoingCallEntity call) async {
    final number = call.rawPhoneNumber;
    if (isEmergencyNumber(number)) {
      return const RedirectionDecision(
        action: RedirectionAction.proceed,
        reason: RedirectionHoldReason.emergencyOverride,
        description: 'Emergency number floor override',
      );
    }
    if (isBypassed(number) || isBypassed(call.normalizedPhoneNumber)) {
      return const RedirectionDecision(
        action: RedirectionAction.proceed,
        description: 'Temporary user bypass active',
      );
    }

    if (outboundEvaluator != null) {
      final customDecision = await outboundEvaluator!(call);
      if (customDecision != null) {
        return customDecision;
      }
    }

    if (number.startsWith('+1800') || number.startsWith('+1900') || number.startsWith('400')) {
      return const RedirectionDecision(
        action: RedirectionAction.holdAndNotify,
        reason: RedirectionHoldReason.premiumRateNumber,
        description: 'High-cost premium rate number prefix detected',
      );
    }

    return RedirectionDecision.proceed;
  }

  @override
  bool isEmergencyNumber(String rawNumber) {
    const emergencyNumbers = {'911', '112', '999', '110', '120', '119'};
    return emergencyNumbers.contains(rawNumber.trim());
  }

  @override
  bool isBypassed(String phoneNumber) {
    final expiry = _bypassTokens[phoneNumber];
    if (expiry == null) return false;
    if (DateTime.now().isAfter(expiry)) {
      _bypassTokens.remove(phoneNumber);
      return false;
    }
    return true;
  }

  @override
  Future<void> addBypassToken(String phoneNumber,
      {Duration duration = const Duration(minutes: 15)}) async {
    _bypassTokens[phoneNumber] = DateTime.now().add(duration);
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
