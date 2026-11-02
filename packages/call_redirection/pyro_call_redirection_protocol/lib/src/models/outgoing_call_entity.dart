import 'package:flutter/foundation.dart';
import '../enums/redirection_enums.dart';

/// Entity representing an outbound call attempt.
@immutable
class OutgoingCallEntity {
  final String id;
  final String rawPhoneNumber;
  final String normalizedPhoneNumber;
  final int timestampMs;
  final bool isInteractiveAllowed;
  final bool isCarModeActive;

  const OutgoingCallEntity({
    required this.id,
    required this.rawPhoneNumber,
    required this.normalizedPhoneNumber,
    required this.timestampMs,
    this.isInteractiveAllowed = true,
    this.isCarModeActive = false,
  });

  Map<String, dynamic> toMap() {
    return {
      RedirectionMapKeys.id: id,
      RedirectionMapKeys.rawPhoneNumber: rawPhoneNumber,
      RedirectionMapKeys.normalizedPhoneNumber: normalizedPhoneNumber,
      RedirectionMapKeys.timestampMs: timestampMs,
      RedirectionMapKeys.isInteractiveAllowed: isInteractiveAllowed,
      RedirectionMapKeys.isCarModeActive: isCarModeActive,
    };
  }

  factory OutgoingCallEntity.fromMap(Map<String, dynamic> map) {
    return OutgoingCallEntity(
      id: map[RedirectionMapKeys.id] as String? ?? '',
      rawPhoneNumber: map[RedirectionMapKeys.rawPhoneNumber] as String? ?? '',
      normalizedPhoneNumber: map[RedirectionMapKeys.normalizedPhoneNumber] as String? ?? '',
      timestampMs: map[RedirectionMapKeys.timestampMs] as int? ?? DateTime.now().millisecondsSinceEpoch,
      isInteractiveAllowed: map[RedirectionMapKeys.isInteractiveAllowed] as bool? ?? true,
      isCarModeActive: map[RedirectionMapKeys.isCarModeActive] as bool? ?? false,
    );
  }
}
