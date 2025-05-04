class SimInfo {
  final String? carrierName;
  final String? displayName;
  final String? iccId;
  final String? countryIso;
  final String? phoneNumber;
  final int? simSlotIndex;
  final int? subscriptionId;
  final String? mccString;
  final String? mncString;
  final String? simPhoneNumber;
  final String? callType;

  SimInfo({
    this.carrierName,
    this.displayName,
    this.iccId,
    this.countryIso,
    this.phoneNumber,
    this.simSlotIndex,
    this.subscriptionId,
    this.mccString,
    this.mncString,
    this.simPhoneNumber,
    this.callType,
  });

  Map<String, dynamic> toJson() => {
    'carrierName': carrierName,
    'displayName': displayName,
    'iccId': iccId,
    'countryIso': countryIso,
    'phoneNumber': phoneNumber,
    'simSlotIndex': simSlotIndex,
    'subscriptionId': subscriptionId,
    'mccString': mccString,
    'mncString': mncString,
    'simPhoneNumber': simPhoneNumber,
    'callType': callType,
  };

  factory SimInfo.fromJson(Map<String, dynamic> json) => SimInfo(
    carrierName: json['carrierName'],
    displayName: json['displayName'],
    iccId: json['iccId'],
    countryIso: json['countryIso'],
    phoneNumber: json['phoneNumber'],
    simSlotIndex: json['simSlotIndex'],
    subscriptionId: json['subscriptionId'],
    mccString: json['mccString'],
    mncString: json['mncString'],
    simPhoneNumber: json['simPhoneNumber'],
    callType: json['callType'],
  );
}