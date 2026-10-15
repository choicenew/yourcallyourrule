/// 全局统一规则类型静态常量表 (包含所有 5 种规则类型)
class RuleTypeKeys {
  RuleTypeKeys._();

  static const String phone = 'phone_rule';
  static const String allowBlock = 'allow_block';
  static const String regex = 'regex';
  static const String simSlot = 'sim_slot';
  static const String smsRegex = 'sms_regex';
}

/// 规则类型强类型枚举
enum RuleType {
  /// 电话号码规则 ('phone_rule')
  phone,

  /// 允许/阻止规则 ('allow_block')
  allowBlock,

  /// 正则表达式规则 ('regex')
  regex,

  /// SIM 卡槽规则 ('sim_slot')
  simSlot,

  /// 短信正则规则 ('sms_regex')
  smsRegex;

  /// 从数据库或 Map 安全创建枚举
  factory RuleType.fromString(dynamic raw) {
    if (raw == null) return RuleType.phone;
    final str = raw.toString().trim().toLowerCase();
    switch (str) {
      case RuleTypeKeys.allowBlock:
      case 'alloworblock':
      case 'white_black':
        return RuleType.allowBlock;
      case RuleTypeKeys.regex:
        return RuleType.regex;
      case RuleTypeKeys.simSlot:
        return RuleType.simSlot;
      case RuleTypeKeys.smsRegex:
        return RuleType.smsRegex;
      case RuleTypeKeys.phone:
      default:
        return RuleType.phone;
    }
  }

  /// 转换回物理存储字符串
  String toRawString() {
    switch (this) {
      case RuleType.phone:
        return RuleTypeKeys.phone;
      case RuleType.allowBlock:
        return RuleTypeKeys.allowBlock;
      case RuleType.regex:
        return RuleTypeKeys.regex;
      case RuleType.simSlot:
        return RuleTypeKeys.simSlot;
      case RuleType.smsRegex:
        return RuleTypeKeys.smsRegex;
    }
  }
}
