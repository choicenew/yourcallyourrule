// VIP兑换规则模型，用于定义VIP兑换规则

// VIP兑换规则类
class VipExchangeRule {
  // 所需标记次数
  final int requiredMarks;
  // VIP天数
  final int days;
  // 是否有广告
  final bool hasAds;
  // 是否支持同步
  final bool hasSync;
  // 描述
  final String description;
  
  // 构造函数
  const VipExchangeRule({
    required this.requiredMarks,
    required this.days,
    required this.hasAds,
    required this.hasSync,
    required this.description,
  });
  
  // 从Map创建模型
  factory VipExchangeRule.fromMap(Map<String, dynamic> map) {
    return VipExchangeRule(
      requiredMarks: map['required_marks'],
      days: map['days'],
      hasAds: map['has_ads'],
      hasSync: map['has_sync'],
      description: map['description'],
    );
  }
  
  // 将模型转换为Map
  Map<String, dynamic> toMap() {
    return {
      'required_marks': requiredMarks,
      'days': days,
      'has_ads': hasAds,
      'has_sync': hasSync,
      'description': description,
    };
  }
}

// VIP兑换结果类
class VipExchangeResult {
  // 是否成功
  final bool success;
  // 消息
  final String message;
  // 当前标记次数
  final int currentMarks;
  // 到期时间
  final DateTime? expiryDate;
  
  // 构造函数
  const VipExchangeResult({
    required this.success,
    required this.message,
    required this.currentMarks,
    this.expiryDate,
  });
}