import '../enums/call_action_type.dart';

/// Context parameters required for executing a call action.
class CallActionContext {
  /// Unique identifier of the call session.
  final String callId;

  /// Incoming or target phone number.
  final String phoneNumber;

  /// Action type to execute.
  final CallActionType actionType;

  /// Delay duration in milliseconds for answer-then-hangup execution (default 1000ms).
  final int delayHangupMs;

  /// Whether to enable microphone mute background protection during answer-then-hangup.
  final bool enableMicMuteProtection;

  /// Epoch milliseconds timestamp when action was requested.
  final int timestampMs;

  const CallActionContext({
    required this.callId,
    required this.phoneNumber,
    required this.actionType,
    this.delayHangupMs = 1000,
    this.enableMicMuteProtection = true,
    int? timestampMs,
  }) : timestampMs = timestampMs ?? 0;

  Map<String, dynamic> toMap() {
    return {
      'callId': callId,
      'phoneNumber': phoneNumber,
      'actionType': actionType.toCode(),
      'delayHangupMs': delayHangupMs,
      'enableMicMuteProtection': enableMicMuteProtection,
      'timestampMs': timestampMs == 0 ? DateTime.now().millisecondsSinceEpoch : timestampMs,
    };
  }

  factory CallActionContext.fromMap(Map<dynamic, dynamic> map) {
    return CallActionContext(
      callId: (map['callId'] ?? map['id'] ?? '').toString(),
      phoneNumber: (map['phoneNumber'] ?? map['number'] ?? '').toString(),
      actionType: CallActionType.fromString((map['actionType'] ?? map['action'] ?? 'allow').toString()),
      delayHangupMs: map['delayHangupMs'] is int ? map['delayHangupMs'] as int : 1000,
      enableMicMuteProtection: map['enableMicMuteProtection'] as bool? ?? true,
      timestampMs: map['timestampMs'] is int ? map['timestampMs'] as int : DateTime.now().millisecondsSinceEpoch,
    );
  }
}
