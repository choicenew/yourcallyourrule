import '../enums/sim_slot_index.dart';
import '../enums/sim_state_type.dart';
import 'sim_carrier_entity.dart';

/// Fully absorbed SIM card entity incorporating sim_reader & sim_card_code parameters.
class SimCardEntity {
  final int subscriptionId;
  final SimSlotIndex slotIndex;
  final SimStateType state;
  final String phoneNumber;
  final String iccId;
  final bool isDataRoaming;
  final bool isNetworkRoaming;
  final SimCarrierEntity carrier;

  const SimCardEntity({
    required this.subscriptionId,
    required this.slotIndex,
    required this.state,
    required this.phoneNumber,
    required this.iccId,
    this.isDataRoaming = false,
    this.isNetworkRoaming = false,
    required this.carrier,
  });

  /// Compatibility getters for seamless migration from sim_reader
  int get simSlotIndex => slotIndex.rawIndex;
  String? get carrierName => carrier.carrierName.isNotEmpty ? carrier.carrierName : carrier.displayName;
  String? get displayName => carrier.displayName.isNotEmpty ? carrier.displayName : carrier.carrierName;
  String? get countryCode => carrier.countryIso;
  String get simPhoneNumber => phoneNumber;
  String get mcc => carrier.mcc;
  String get mnc => carrier.mnc;

  Map<String, dynamic> toMap() {
    return {
      'subscriptionId': subscriptionId,
      'simSlotIndex': slotIndex.rawIndex,
      'state': state.name,
      'simPhoneNumber': phoneNumber,
      'iccId': iccId,
      'isDataRoaming': isDataRoaming,
      'isNetworkRoaming': isNetworkRoaming,
      ...carrier.toMap(),
    };
  }

  factory SimCardEntity.fromMap(Map<dynamic, dynamic> map) {
    return SimCardEntity(
      subscriptionId: map['subscriptionId'] is int ? map['subscriptionId'] as int : -1,
      slotIndex: SimSlotIndex.fromInt(map['simSlotIndex'] is int ? map['simSlotIndex'] as int : -1),
      state: SimStateType.fromString((map['state'] ?? 'ready').toString()),
      phoneNumber: (map['simPhoneNumber'] ?? map['incomingPhoneNumber'] ?? '').toString(),
      iccId: (map['iccId'] ?? '').toString(),
      isDataRoaming: map['isDataRoaming'] as bool? ?? false,
      isNetworkRoaming: map['isNetworkRoaming'] as bool? ?? false,
      carrier: SimCarrierEntity.fromMap(map),
    );
  }
}
