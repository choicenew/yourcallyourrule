/// Strongly typed STIR/SHAKEN caller number verification status.
enum StirVerificationStatus {
  passed('VERIFICATION_PASSED', 'Verified Caller'),
  failed('VERIFICATION_FAILED', 'Unverified / Spoofed'),
  notVerified('NOT_VERIFIED', 'Not Verified'),
  notAvailable('NOT_AVAILABLE', 'N/A');

  final String code;
  final String label;

  const StirVerificationStatus(this.code, this.label);

  static StirVerificationStatus fromString(String raw) {
    switch (raw.trim().toUpperCase()) {
      case 'PASSED':
      case 'VERIFICATION_PASSED':
        return StirVerificationStatus.passed;
      case 'FAILED':
      case 'VERIFICATION_FAILED':
        return StirVerificationStatus.failed;
      case 'NOT_VERIFIED':
        return StirVerificationStatus.notVerified;
      default:
        return StirVerificationStatus.notAvailable;
    }
  }
}
