import 'package:pyro_stir_hub/pyro_stir_hub.dart';
import 'stir_api.g.dart';

/// Native STIR driver bridging to Call.Details.callerNumberVerificationStatus.
class StirDriver implements IStirCheckerAdapter {
  static StirDriver? _instance;

  static void register() {
    _instance ??= StirDriver();
    StirHub.instance.registerAdapter(_instance!);
  }

  static void unregister() {
    _instance?.dispose();
    _instance = null;
  }

  final StirHostApi _hostApi;

  StirDriver({StirHostApi? hostApi}) : _hostApi = hostApi ?? StirHostApi();

  void dispose() {
    // Clean up if needed
  }

  @override
  String get providerId => 'pyro_stir_driver';

  @override
  Future<StirResultEntity?> checkStirStatus(String phoneNumber) async {
    try {
      final response = await _hostApi.checkStirStatus(phoneNumber);
      return StirResultEntity(
        phoneNumber: response.phoneNumber,
        status: StirVerificationStatus.fromString(response.status),
        isVerified: response.isVerified,
        isFailed: response.isFailed,
      );
    } catch (_) {
      return null;
    }
  }
}
