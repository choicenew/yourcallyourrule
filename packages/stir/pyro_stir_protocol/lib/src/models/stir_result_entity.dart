import '../enums/stir_verification_status.dart';

/// Strongly typed entity representing STIR/SHAKEN caller verification result.
class StirResultEntity {
  final String phoneNumber;
  final StirVerificationStatus status;
  final bool isVerified;
  final bool isFailed;
  final int timestampMs;

  const StirResultEntity({
    required this.phoneNumber,
    required this.status,
    required this.isVerified,
    required this.isFailed,
    int? timestampMs,
  }) : timestampMs = timestampMs ?? 0;

  Map<String, dynamic> toMap() {
    return {
      'phoneNumber': phoneNumber,
      'status': status.code,
      'isVerified': isVerified,
      'isFailed': isFailed,
      'timestampMs': timestampMs == 0 ? DateTime.now().millisecondsSinceEpoch : timestampMs,
    };
  }

  factory StirResultEntity.fromMap(Map<dynamic, dynamic> map) {
    final isVer = map['isVerified'] as bool? ?? false;
    final isFail = map['isFailed'] as bool? ?? false;
    final rawStatus = (map['status'] ?? (isVer ? 'PASSED' : (isFail ? 'FAILED' : 'NOT_VERIFIED'))).toString();

    return StirResultEntity(
      phoneNumber: (map['phoneNumber'] ?? '').toString(),
      status: StirVerificationStatus.fromString(rawStatus),
      isVerified: isVer,
      isFailed: isFail,
      timestampMs: map['timestampMs'] is int ? map['timestampMs'] as int : DateTime.now().millisecondsSinceEpoch,
    );
  }
}
