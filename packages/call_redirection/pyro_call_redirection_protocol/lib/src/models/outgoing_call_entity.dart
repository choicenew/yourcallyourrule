import 'package:flutter/foundation.dart';

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
      'id': id,
      'rawPhoneNumber': rawPhoneNumber,
      'normalizedPhoneNumber': normalizedPhoneNumber,
      'timestampMs': timestampMs,
      'isInteractiveAllowed': isInteractiveAllowed,
      'isCarModeActive': isCarModeActive,
    };
  }

  factory OutgoingCallEntity.fromMap(Map<String, dynamic> map) {
    return OutgoingCallEntity(
      id: map['id'] as String? ?? '',
      rawPhoneNumber: map['rawPhoneNumber'] as String? ?? '',
      normalizedPhoneNumber: map['normalizedPhoneNumber'] as String? ?? '',
      timestampMs: map['timestampMs'] as int? ?? DateTime.now().millisecondsSinceEpoch,
      isInteractiveAllowed: map['isInteractiveAllowed'] as bool? ?? true,
      isCarModeActive: map['isCarModeActive'] as bool? ?? false,
    );
  }
}
