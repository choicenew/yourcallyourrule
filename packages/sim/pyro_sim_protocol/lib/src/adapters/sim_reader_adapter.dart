import '../models/sim_card_entity.dart';
import '../models/network_info_entity.dart';

/// Abstract adapter contract for reading SIM & network information.
abstract interface class ISimReaderAdapter {
  String get providerId;

  /// Read all active SIM card subscriptions.
  Future<List<SimCardEntity>> getActiveSimCards();

  /// Read SIM info for specific slot.
  Future<SimCardEntity?> getSimBySlot(int slotIndex);

  /// Check if device has active SIM card inserted.
  Future<bool> hasSimCard();

  /// Get active cellular network information.
  Future<NetworkInfoEntity?> getNetworkInfo();
}
