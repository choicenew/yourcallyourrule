class LabelMarkRecordModel {
  final String id;
  final String phoneNumber;
  final String labelId;
  final DateTime markedAt;
  final bool isCounted;

  const LabelMarkRecordModel({
    required this.id,
    required this.phoneNumber,
    required this.labelId,
    required this.markedAt,
    this.isCounted = true,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'phoneNumber': phoneNumber,
      'labelId': labelId,
      'markedAt': markedAt.toIso8601String(),
      'isCounted': isCounted,
    };
  }

  factory LabelMarkRecordModel.fromMap(Map<String, dynamic> map) {
    return LabelMarkRecordModel(
      id: map['id'] as String? ?? '',
      phoneNumber: map['phoneNumber'] as String? ?? '',
      labelId: map['labelId'] as String? ?? '',
      markedAt: map['markedAt'] != null ? DateTime.parse(map['markedAt'] as String) : DateTime.now(),
      isCounted: map['isCounted'] as bool? ?? true,
    );
  }
}
