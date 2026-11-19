import 'package:flutter/services.dart';
import 'package:pyro_sim_hub/pyro_sim_hub.dart';
import 'sim_api.g.dart';

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

  final SimHostApi _hostApi;

  SimDriver({SimHostApi? hostApi}) : _hostApi = hostApi ?? SimHostApi();

  void dispose() {
    // Clean up if needed
  }

  @override
  String get providerId => 'pyro_sim_driver';

  @override
  Future<List<SimCardEntity>> getActiveSimCards() async {
    try {
      final List<PigeonSimCard> rawList = await _hostApi.getActiveSimCards();
      return rawList.map((card) {
        return SimCardEntity(
          subscriptionId: card.subscriptionId ?? -1,
          slotIndex: SimSlotIndex.fromInt(card.simSlotIndex ?? -1),
          state: SimStateType.fromString((card.state ?? 'ready').toString()),
          phoneNumber: card.simPhoneNumber ?? '',
          iccId: card.iccId ?? '',
          isDataRoaming: card.isDataRoaming ?? false,
          isNetworkRoaming: card.isNetworkRoaming ?? false,
          carrier: SimCarrierEntity(
            carrierName: card.carrierName ?? '',
            displayName: card.displayName ?? '',
            countryIso: card.countryIso ?? '',
            mcc: card.mccString ?? '',
            mnc: card.mncString ?? '',
          ),
        );
      }).toList();
    } on PlatformException {
      return [];
    } catch (_) {
      return [];
    }
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
      return await _hostApi.hasSimCard();
    } on PlatformException {
      return false;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<NetworkInfoEntity?> getNetworkInfo() async {
    try {
      final PigeonNetworkInfo? info = await _hostApi.getNetworkInfo();
      if (info != null) {
        return NetworkInfoEntity(
          networkOperatorName: info.networkOperatorName ?? '',
          networkOperator: info.networkOperator ?? '',
          networkType: info.networkType ?? '',
          isNetworkAvailable: info.isNetworkAvailable ?? false,
          isRoaming: info.isRoaming ?? false,
        );
      }
    } on PlatformException {
      return null;
    } catch (_) {
      return null;
    }
    return null;
  }
}
