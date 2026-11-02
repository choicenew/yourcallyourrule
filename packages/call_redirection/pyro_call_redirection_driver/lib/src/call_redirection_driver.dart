import 'package:flutter/services.dart';
import 'package:pyro_call_redirection_protocol/pyro_call_redirection_protocol.dart';
import 'package:pyro_call_redirection_hub/pyro_call_redirection_hub.dart';

/// Driver for CallRedirectionService outbound fraud prevention
class CallRedirectionDriver implements ICallRedirectionAdapter {
  /// Static auto-registration hook
  static void register() {
    CallRedirectionHub.instance.registerRedirectionDriver(CallRedirectionDriver());
  }

  static const MethodChannel _channel =
      MethodChannel('com.yours.pyro_call/call_redirection');

  final Map<String, DateTime> _bypassTokens = {};

  @override
  String get providerId => 'pyro_call_redirection_driver';

  bool isEnabled;

  CallRedirectionDriver({this.isEnabled = true}) {
    _channel.setMethodCallHandler(_handleMethodCall);
  }

  Future<dynamic> _handleMethodCall(MethodCall call) async {
    if (call.method == 'evaluateCall') {
      final String rawNumber = call.arguments['phoneNumber'] as String? ?? '';
      final entity = OutgoingCallEntity(
        id: 'call_${DateTime.now().millisecondsSinceEpoch}',
        rawPhoneNumber: rawNumber,
        normalizedPhoneNumber: rawNumber.replaceAll(RegExp(r'\D'), ''),
        timestampMs: DateTime.now().millisecondsSinceEpoch,
      );
      final decision = await evaluateOutboundCall(entity);
      return decision.toMap();
    }
    return null;
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
    if (isBypassed(number)) {
      return const RedirectionDecision(
        action: RedirectionAction.proceed,
        description: 'Temporary user bypass active',
      );
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

  Future<bool> isRoleGranted() async {
    try {
      final bool? granted = await _channel.invokeMethod<bool>('isRoleGranted');
      return granted ?? false;
    } on MissingPluginException {
      return false;
    }
  }

  Future<void> requestRole() async {
    try {
      await _channel.invokeMethod('requestRole');
    } on MissingPluginException {
      // Fallback
    }
  }
}
