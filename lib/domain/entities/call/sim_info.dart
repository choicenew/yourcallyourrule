/// SIM卡信息实体类
/// 包含来电相关的SIM卡信息
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

  /// 转换为JSON
  Map<String, dynamic> toJson() {
    return {
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
  }

  /// 从JSON创建实例
  factory SimInfo.fromJson(Map<String, dynamic> json) {
    return SimInfo(
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
}