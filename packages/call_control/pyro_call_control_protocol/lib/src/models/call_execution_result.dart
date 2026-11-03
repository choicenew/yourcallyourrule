import '../enums/call_action_type.dart';

/// Result status of an executed call action.
class CallExecutionResult {
  /// Whether the action execution succeeded.
  final bool success;

  /// The action type that was executed.
  final CallActionType actionType;

  /// Detailed message or error description.
  final String message;

  /// Timestamp when execution completed.
  final DateTime executedAt;

  CallExecutionResult({
    required this.success,
    required this.actionType,
    required this.message,
    DateTime? executedAt,
  }) : executedAt = executedAt ?? DateTime.now();

  static final CallExecutionResult allowed = CallExecutionResult(
    success: true,
    actionType: CallActionType.allow,
    message: 'Call ringing through without action',
  );

  Map<String, dynamic> toMap() {
    return {
      'success': success,
      'actionType': actionType.toCode(),
      'message': message,
      'executedAtMs': executedAt.millisecondsSinceEpoch,
    };
  }

  factory CallExecutionResult.fromMap(Map<dynamic, dynamic> map) {
    return CallExecutionResult(
      success: map['success'] as bool? ?? false,
      actionType: CallActionType.fromString((map['actionType'] ?? 'allow').toString()),
      message: (map['message'] ?? '').toString(),
      executedAt: map['executedAtMs'] is int
          ? DateTime.fromMillisecondsSinceEpoch(map['executedAtMs'] as int)
          : DateTime.now(),
    );
  }
}
