/// Entity model for an incoming call attempt.
class IncomingCallEntity {
  final String callId;
  final String phoneNumber;
  final String normalizedNumber;
  final int simSlot;
  final int timestampMs;

  const IncomingCallEntity({
    required this.callId,
    required this.phoneNumber,
    required this.normalizedNumber,
    this.simSlot = 0,
    int? timestampMs,
  }) : timestampMs = timestampMs ?? 0;

  Map<String, dynamic> toMap() {
    return {
      'callId': callId,
      'phoneNumber': phoneNumber,
      'normalizedNumber': normalizedNumber,
      'simSlot': simSlot,
      'timestampMs': timestampMs == 0 ? DateTime.now().millisecondsSinceEpoch : timestampMs,
    };
  }

  factory IncomingCallEntity.fromMap(Map<dynamic, dynamic> map) {
    return IncomingCallEntity(
      callId: (map['callId'] ?? map['id'] ?? '').toString(),
      phoneNumber: (map['phoneNumber'] ?? map['number'] ?? '').toString(),
      normalizedNumber: (map['normalizedNumber'] ?? map['phoneNumber'] ?? '').toString(),
      simSlot: map['simSlot'] is int ? map['simSlot'] as int : 0,
      timestampMs: map['timestampMs'] is int ? map['timestampMs'] as int : DateTime.now().millisecondsSinceEpoch,
    );
  }
}
