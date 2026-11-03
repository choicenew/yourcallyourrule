import 'package:flutter/foundation.dart';
import 'package:pyro_sim_protocol/pyro_sim_protocol.dart';

/// IoC Locator and state manager for SIM subscription services.
class SimHub {
  static final SimHub _instance = SimHub._internal();
  static SimHub get instance => _instance;

  SimHub._internal();

  ISimReaderAdapter? _adapter;

  void registerAdapter(ISimReaderAdapter adapter) {
    _adapter = adapter;
    debugPrint('[SimHub] Registered SIM reader adapter: ${adapter.providerId}');
  }

  /// Get active SIM cards.
  Future<List<SimCardEntity>> getActiveSimCards() async {
    final adapter = _adapter;
    if (adapter == null) return [];
    return await adapter.getActiveSimCards();
  }

  /// Get SIM card by slot index.
  Future<SimCardEntity?> getSimBySlot(SimSlotIndex slot) async {
    final adapter = _adapter;
    if (adapter == null) return null;
    return await adapter.getSimBySlot(slot.rawIndex);
  }

  /// Check if device has active SIM card inserted.
  Future<bool> hasSimCard() async {
    final adapter = _adapter;
    if (adapter == null) return false;
    return await adapter.hasSimCard();
  }

  /// Get active cellular network information.
  Future<NetworkInfoEntity?> getNetworkInfo() async {
    final adapter = _adapter;
    if (adapter == null) return null;
    return await adapter.getNetworkInfo();
  }
}
