/// SIM卡信息实体
/// 包含SIM卡相关信息
class SimInfo {
  final int? simSlot;
  final String? simId;
  final String? carrierName;
  final String? phoneNumber;

  SimInfo({
    this.simSlot,
    this.simId,
    this.carrierName,
    this.phoneNumber,
  });

  /// 从JSON创建实体
  factory SimInfo.fromJson(Map<String, dynamic> json) {
    return SimInfo(
      simSlot: json['simSlot'],
      simId: json['simId'],
      carrierName: json['carrierName'],
      phoneNumber: json['phoneNumber'],
    );
  }

  /// 转换为JSON
  Map<String, dynamic> toJson() {
    return {
      'simSlot': simSlot,
      'simId': simId,
      'carrierName': carrierName,
      'phoneNumber': phoneNumber,
    };
  }
}