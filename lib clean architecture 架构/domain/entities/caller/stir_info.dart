/// STIR/SHAKEN验证信息实体
/// 包含电话号码验证状态信息
class StirInfo {
  final bool isVerified;
  final bool isNotVerified;
  final bool isFailed;
  final String? phoneNumber;

  StirInfo({
    required this.isVerified,
    required this.isNotVerified,
    required this.isFailed,
    this.phoneNumber,
  });

  /// 从JSON创建实体
  factory StirInfo.fromJson(Map<String, dynamic> json) {
    return StirInfo(
      isVerified: json['isVerified'] ?? false,
      isNotVerified: json['isNotVerified'] ?? false,
      isFailed: json['isFailed'] ?? false,
      phoneNumber: json['phoneNumber'],
    );
  }

  /// 转换为JSON
  Map<String, dynamic> toJson() {
    return {
      'isVerified': isVerified,
      'isNotVerified': isNotVerified,
      'isFailed': isFailed,
      'phoneNumber': phoneNumber,
    };
  }
}