/// STIR/SHAKEN验证信息实体类
/// 包含来电STIR/SHAKEN验证的结果信息
class StirInfo {
  final bool isVerified;
  final bool isNotVerified;
  final bool isFailed;
  final String? phoneNumber; // 用于匹配相关联的电话号码

  StirInfo({
    required this.isVerified,
    required this.isNotVerified,
    required this.isFailed,
    this.phoneNumber,
  });

  /// 转换为JSON
  Map<String, dynamic> toJson() {
    return {
      'isVerified': isVerified,
      'isNotVerified': isNotVerified,
      'isFailed': isFailed,
      'phoneNumber': phoneNumber,
    };
  }

  /// 从JSON创建实例
  factory StirInfo.fromJson(Map<String, dynamic> json) {
    return StirInfo(
      isVerified: json['isVerified'] ?? false,
      isNotVerified: json['isNotVerified'] ?? false,
      isFailed: json['isFailed'] ?? false,
      phoneNumber: json['phoneNumber'],
    );
  }

  /// 判断是否通过STIR验证
  bool isStirVerified() {
    return isVerified;
  }
}