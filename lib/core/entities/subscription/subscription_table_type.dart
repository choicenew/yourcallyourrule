/// 全局统一订阅表类型静态常量表 (Subscription Table Type Keys)
class SubscriptionTableKeys {
  SubscriptionTableKeys._();

  /// 电话规则订阅表类型 ('phone')
  static const String phone = 'phone';

  /// 短信规则订阅表类型 ('sms')
  static const String sms = 'sms';

  /// 联系人订阅表类型 ('contact')
  static const String contact = 'contact';
}

/// 订阅表类型强类型枚举
enum SubscriptionTableType {
  /// 电话规则订阅 ('phone')
  phone,

  /// 短信规则订阅 ('sms')
  sms,

  /// 联系人订阅 ('contact')
  contact;

  /// 从字符串安全创建枚举
  factory SubscriptionTableType.fromString(dynamic raw) {
    if (raw == null) return SubscriptionTableType.phone;
    final str = raw.toString().trim().toLowerCase();
    switch (str) {
      case SubscriptionTableKeys.sms:
        return SubscriptionTableType.sms;
      case SubscriptionTableKeys.contact:
        return SubscriptionTableType.contact;
      case SubscriptionTableKeys.phone:
      default:
        return SubscriptionTableType.phone;
    }
  }

  /// 转换回物理存储字符串 ('phone', 'sms', 'contact')
  String toRawString() {
    switch (this) {
      case SubscriptionTableType.phone:
        return SubscriptionTableKeys.phone;
      case SubscriptionTableType.sms:
        return SubscriptionTableKeys.sms;
      case SubscriptionTableType.contact:
        return SubscriptionTableKeys.contact;
    }
  }
}
