import 'dart:async';
import 'package:flutter/services.dart';
import 'package:pyro_call_redirection_protocol/pyro_call_redirection_protocol.dart';
import 'package:pyro_call_redirection_hub/pyro_call_redirection_hub.dart';
import 'emergency_number_floor.dart';
import 'car_mode_guard.dart';

/// Concrete driver with Automatic Self-Registration logic.
/// Automatically registers itself into [CallRedirectionHub.instance] upon class loading.
class CallRedirectionDriver implements ICallRedirectionAdapter {
  static const MethodChannel _channel = MethodChannel('com.yours.yourcallyourrule/call_redirection');

  final Map<String, DateTime> _bypassCache = {};
  static const Duration _defaultDeadline = Duration(milliseconds: 3000);

  // 🔥 Automatic Self-Registration Execution Hook
  static final bool _autoRegistrationTrigger = _performAutoRegistration();

  static bool _performAutoRegistration() {
    final driver = CallRedirectionDriver._internal();
    CallRedirectionHub.instance.registerRedirectionDriver(driver);
    return true;
  }

  /// Ensures automatic self-registration has executed.
  static void ensureMounted() {
    assert(_autoRegistrationTrigger);
  }

  /// Factory constructor ensuring automatic self-registration.
  factory CallRedirectionDriver() {
    ensureMounted();
    final registered = CallRedirectionHub.instance.redirectionDriver;
    if (registered is CallRedirectionDriver) return registered;
    return CallRedirectionDriver._internal();
  }

  CallRedirectionDriver._internal();

  @override
  bool isEmergencyNumber(String rawNumber) {
    return EmergencyNumberFloor.isEmergency(rawNumber);
  }

  @override
  bool isBypassed(String phoneNumber) {
    final expireAt = _bypassCache[phoneNumber];
    if (expireAt == null) return false;
    if (DateTime.now().isAfter(expireAt)) {
      _bypassCache.remove(phoneNumber);
      return false;
    }
    return true;
  }

  @override
  Future<void> addBypassToken(String phoneNumber, {Duration duration = const Duration(minutes: 15)}) async {
    _bypassCache[phoneNumber] = DateTime.now().add(duration);
  }

  @override
  Future<RedirectionDecision> evaluateOutboundCall(OutgoingCallEntity call) async {
    final startTime = DateTime.now().millisecondsSinceEpoch;

    // 1. Check Emergency Floor -> Immediate Proceed
    if (isEmergencyNumber(call.rawPhoneNumber) || isEmergencyNumber(call.normalizedPhoneNumber)) {
      return const RedirectionDecision(
        action: RedirectionAction.proceed,
        reason: RedirectionHoldReason.emergencyOverride,
        description: 'Emergency number floor override applied.',
      );
    }

    // 2. Check Car Mode / Non-Interactive -> Proceed to avoid ghost calls
    if (!CarModeGuard.canShowInteractiveHold(
      isCarModeActive: call.isCarModeActive,
      isInteractiveAllowed: call.isInteractiveAllowed,
    )) {
      return const RedirectionDecision(
        action: RedirectionAction.proceed,
        description: 'Non-interactive or Car mode active, bypassing hold.',
      );
    }

    // 3. Check "Call Anyway" temporary bypass token -> Proceed
    if (isBypassed(call.normalizedPhoneNumber)) {
      return const RedirectionDecision(
        action: RedirectionAction.proceed,
        description: 'User "Call Anyway" temporary bypass token valid.',
      );
    }

    // 4. Wrap Native evaluation with strict 3000ms deadline timeout
    try {
      final result = await _channel.invokeMethod<Map<dynamic, dynamic>>(
        'evaluateCall',
        call.toMap(),
      ).timeout(_defaultDeadline, onTimeout: () {
        return {
          'action': 'proceed',
          'description': '3000ms Telecom deadline exceeded, fallback to proceed.',
        };
      });

      final elapsed = DateTime.now().millisecondsSinceEpoch - startTime;
      if (result != null) {
        final resultMap = Map<String, dynamic>.from(result);
        resultMap['evaluationTimeMs'] = elapsed;
        return RedirectionDecision.fromMap(resultMap);
      }
    } catch (_) {
      // Fallback on method channel exception
    }

    return RedirectionDecision(
      action: RedirectionAction.proceed,
      description: 'Fallback proceed on driver channel exception.',
      evaluationTimeMs: DateTime.now().millisecondsSinceEpoch - startTime,
    );
  }
}
