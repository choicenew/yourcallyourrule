import 'package:flutter/services.dart';
import 'package:pyro_sim_hub/pyro_sim_hub.dart';

/// Native SIM driver bridging to Android SubscriptionManager, SimCheckerImpl, sim_reader, & sim_card_code.
class SimDriver implements ISimReaderAdapter {
  static SimDriver? _instance;

  static void register() {
    _instance ??= SimDriver();
    SimHub.instance.registerAdapter(_instance!);
  }

  static void unregister() {
    _instance?.dispose();
    _instance = null;
  }

  static const MethodChannel _channel = MethodChannel('net.pyro.telephony/sim');

  void dispose() {
    // Clean up if needed
  }

  @override
  String get providerId => 'pyro_sim_driver';

  @override
  Future<List<SimCardEntity>> getActiveSimCards() async {
    try {
      final List<dynamic>? rawList = await _channel.invokeListMethod<dynamic>('getActiveSimCards');
      if (rawList != null) {
        return rawList
            .whereType<Map<dynamic, dynamic>>()
            .map((map) => SimCardEntity.fromMap(map))
            .toList();
      }
    } on MissingPluginException {
      // Fallback
    } catch (_) {}
    return [];
  }

  @override
  Future<SimCardEntity?> getSimBySlot(int slotIndex) async {
    final activeCards = await getActiveSimCards();
    for (final card in activeCards) {
      if (card.slotIndex.rawIndex == slotIndex) {
        return card;
      }
    }
    return null;
  }

  @override
  Future<bool> hasSimCard() async {
    try {
      final bool? hasSim = await _channel.invokeMethod<bool>('hasSimCard');
      return hasSim ?? false;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<NetworkInfoEntity?> getNetworkInfo() async {
    try {
      final Map<dynamic, dynamic>? map = await _channel.invokeMethod<Map<dynamic, dynamic>>('getNetworkInfo');
      if (map != null) {
        return NetworkInfoEntity.fromMap(map);
      }
    } catch (_) {}
    return null;
  }
}
