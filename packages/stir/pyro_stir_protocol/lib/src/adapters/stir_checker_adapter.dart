import '../models/stir_result_entity.dart';

/// Abstract adapter contract for STIR/SHAKEN caller verification.
abstract interface class IStirCheckerAdapter {
  String get providerId;

  /// Check STIR/SHAKEN verification result for a call.
  Future<StirResultEntity?> checkStirStatus(String phoneNumber);
}
