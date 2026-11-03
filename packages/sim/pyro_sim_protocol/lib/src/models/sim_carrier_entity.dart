/// Strongly typed entity representing SIM Carrier network metadata.
class SimCarrierEntity {
  final String carrierName;
  final String displayName;
  final String countryIso;
  final String mcc;
  final String mnc;

  const SimCarrierEntity({
    required this.carrierName,
    required this.displayName,
    required this.countryIso,
    required this.mcc,
    required this.mnc,
  });

  static const SimCarrierEntity unknown = SimCarrierEntity(
    carrierName: 'Unknown Carrier',
    displayName: 'Unknown',
    countryIso: '',
    mcc: '',
    mnc: '',
  );

  Map<String, dynamic> toMap() {
    return {
      'carrierName': carrierName,
      'displayName': displayName,
      'countryIso': countryIso,
      'mcc': mcc,
      'mnc': mnc,
    };
  }

  factory SimCarrierEntity.fromMap(Map<dynamic, dynamic> map) {
    return SimCarrierEntity(
      carrierName: (map['carrierName'] ?? '').toString(),
      displayName: (map['displayName'] ?? map['carrierName'] ?? '').toString(),
      countryIso: (map['countryIso'] ?? '').toString(),
      mcc: (map['mccString'] ?? map['mcc'] ?? '').toString(),
      mnc: (map['mncString'] ?? map['mnc'] ?? '').toString(),
    );
  }
}
