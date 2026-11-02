import 'package:flutter/foundation.dart';
import '../enums/redirection_enums.dart';

/// Decision result after evaluating an outbound call.
@immutable
class RedirectionDecision {
  final RedirectionAction action;
  final RedirectionHoldReason? reason;
  final String description;
  final int evaluationTimeMs;

  const RedirectionDecision({
    required this.action,
    this.reason,
    this.description = '',
    this.evaluationTimeMs = 0,
  });

  static const RedirectionDecision proceed = RedirectionDecision(
    action: RedirectionAction.proceed,
    description: 'Allowed by default or emergency floor.',
  );

  Map<String, dynamic> toMap() {
    return {
      RedirectionMapKeys.action: action.name,
      RedirectionMapKeys.reason: reason?.name,
      RedirectionMapKeys.description: description,
      RedirectionMapKeys.evaluationTimeMs: evaluationTimeMs,
    };
  }

  factory RedirectionDecision.fromMap(Map<String, dynamic> map) {
    return RedirectionDecision(
      action: RedirectionAction.values.firstWhere(
        (e) => e.name == map[RedirectionMapKeys.action],
        orElse: () => RedirectionAction.proceed,
      ),
      reason: map[RedirectionMapKeys.reason] != null
          ? RedirectionHoldReason.values.firstWhere(
              (e) => e.name == map[RedirectionMapKeys.reason],
              orElse: () => RedirectionHoldReason.databaseMatch,
            )
          : null,
      description: map[RedirectionMapKeys.description] as String? ?? '',
      evaluationTimeMs: map[RedirectionMapKeys.evaluationTimeMs] as int? ?? 0,
    );
  }
}
