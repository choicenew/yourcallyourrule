/// 规则常量类
class RuleConstants {
  const RuleConstants._();

  // 规则类型
  static const String typeAllowed = 'allowed';
  static const String typeBlocked = 'blocked';
  static const String typeWhitelist = 'whitelist';
  static const String typeBlacklist = 'blacklist';
  static const String typeRegex = 'regex';
  static const String typeDefault = 'default';
  
  // 规则来源
  static const String sourceUser = 'user'; // 用户手动添加
  static const String sourceSubscription = 'subscription'; // 订阅获取
  static const String sourceSystem = 'system'; // 系统默认
  
  // 规则优先级（数值越小优先级越高）
  static const int priorityAllowed = 1;
  static const int priorityBlocked = 2;
  static const int priorityWhitelist = 3;
  static const int priorityBlacklist = 4;
  static const int priorityRegex = 5;
  static const int priorityDefault = 99;
  
  // 规则动作
  static const String actionAllow = 'allow'; // 允许
  static const String actionBlock = 'block'; // 阻止
  static const String actionSilent = 'silent'; // 静音
  static const String actionRedirect = 'redirect'; // 重定向
  static const String actionNotify = 'notify'; // 通知
  
  // 规则匹配模式
  static const String matchExact = 'exact'; // 精确匹配
  static const String matchPrefix = 'prefix'; // 前缀匹配
  static const String matchSuffix = 'suffix'; // 后缀匹配
  static const String matchContains = 'contains'; // 包含匹配
  static const String matchRegex = 'regex'; // 正则表达式匹配
  
  // 规则状态
  static const String statusActive = 'active'; // 激活
  static const String statusInactive = 'inactive'; // 未激活
  static const String statusExpired = 'expired'; // 已过期
  
  // 规则标签
  static const List<String> predefinedLabels = [
    '骚扰电话',
    '诈骗电话',
    '推销电话',
    '快递',
    '外卖',
    '银行',
    '保险',
    '教育',
    '医疗',
    '政府',
    '其他'
  ];
  
  // 规则导入导出
  static const String exportVersion = '1.0';
  static const String exportDateFormat = 'yyyy-MM-dd HH:mm:ss';
  
  // 规则限制
  static const int maxUserRules = 1000; // 用户可创建的最大规则数
  static const int maxSubscriptionRules = 10000; // 订阅规则的最大数量
}