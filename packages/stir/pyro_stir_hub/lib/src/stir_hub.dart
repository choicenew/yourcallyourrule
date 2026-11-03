import 'package:flutter/foundation.dart';
import 'package:pyro_stir_protocol/pyro_stir_protocol.dart';

/// IoC Locator and state manager for STIR/SHAKEN caller authentication.
class StirHub {
  static final StirHub _instance = StirHub._internal();
  static StirHub get instance => _instance;

  StirHub._internal();

  IStirCheckerAdapter? _adapter;

  void registerAdapter(IStirCheckerAdapter adapter) {
    _adapter = adapter;
    debugPrint('[StirHub] Registered STIR checker adapter: ${adapter.providerId}');
  }

  /// Check STIR status for incoming call number.
  Future<StirResultEntity?> checkStirStatus(String phoneNumber) async {
    final adapter = _adapter;
    if (adapter == null) {
      debugPrint('[StirHub] Warning: No IStirCheckerAdapter registered!');
      return null;
    }
    return await adapter.checkStirStatus(phoneNumber);
  }
}
