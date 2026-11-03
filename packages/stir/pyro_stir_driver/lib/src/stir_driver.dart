import 'package:flutter/services.dart';
import 'package:pyro_stir_hub/pyro_stir_hub.dart';

/// Native STIR driver bridging to Call.Details.callerNumberVerificationStatus.
class StirDriver implements IStirCheckerAdapter {
  static void register() {
    StirHub.instance.registerAdapter(StirDriver());
  }

  static const MethodChannel _channel = MethodChannel('com.yours.yourcallyourrule/stir_check');

  @override
  String get providerId => 'pyro_stir_driver';

  @override
  Future<StirResultEntity?> checkStirStatus(String phoneNumber) async {
    try {
      final Map<dynamic, dynamic>? response = await _channel.invokeMethod<Map<dynamic, dynamic>>(
        'checkStirStatus',
        {'phoneNumber': phoneNumber},
      );

      if (response != null) {
        return StirResultEntity.fromMap(response);
      }
    } on MissingPluginException {
      // Fallback
    } catch (_) {}
    return null;
  }
}
