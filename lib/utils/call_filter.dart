import 'package:shared_preferences/shared_preferences.dart';


import '../services/allowed_blocked_service.dart';

import '../services/blacklist_whitelist_service.dart';

import '../services/regex_service.dart';
import 'package:sqflite/sqflite.dart';

class CallFilterConfig {
  bool rejectAllNumbers;
  bool allowAllAllowedNumbers;
  bool allowRegexWhitelistedPatterns;
  bool allowBlockedNumbers;
  bool allowAllWhitelistedNumbers;
  bool allowRegexBlacklistedPatterns;
  bool allowAllBlacklistedNumbers;

  CallFilterConfig({
    this.rejectAllNumbers = false,
    this.allowAllAllowedNumbers = true,
    this.allowRegexWhitelistedPatterns = true,
    this.allowBlockedNumbers = false,
    this.allowAllWhitelistedNumbers = true,
    this.allowRegexBlacklistedPatterns = true,
    this.allowAllBlacklistedNumbers = false,
  });
}

class CallFilter {

  final RegexService regexService;
  final AllowedService allowedService;
  final BlockedService blockedService;
  final WhitelistService whitelistService;
  final BlacklistService blacklistService;
 
 CallFilterConfig config = CallFilterConfig(); // 使用默认配置初始化

  CallFilter({
    required this.regexService,
    required this.allowedService,
    required this.blockedService,
    required this.whitelistService,
    required this.blacklistService,
  });






  // 从 Shared Preferences 加载配置
  Future<void> loadConfig() async {
    final SharedPreferencesAsync asyncPrefs = SharedPreferencesAsync();
    config = CallFilterConfig(
      rejectAllNumbers: await asyncPrefs.getBool('rejectAllNumbers') ?? false,
      allowAllAllowedNumbers: await asyncPrefs.getBool('allowAllAllowedNumbers') ?? true,
      allowRegexWhitelistedPatterns: await asyncPrefs.getBool('allowRegexWhitelistedPatterns') ?? true,
      allowBlockedNumbers: await asyncPrefs.getBool('allowBlockedNumbers') ?? false,
      allowAllWhitelistedNumbers: await asyncPrefs.getBool('allowAllWhitelistedNumbers') ?? true,
      allowRegexBlacklistedPatterns: await asyncPrefs.getBool('allowRegexBlacklistedPatterns') ?? true,
      allowAllBlacklistedNumbers: await asyncPrefs.getBool('allowAllBlacklistedNumbers') ?? false,
    );
  }

  // 保存配置到 Shared Preferences
  Future<void> saveConfig() async {
    final SharedPreferencesAsync asyncPrefs = SharedPreferencesAsync();
    await asyncPrefs.setBool('rejectAllNumbers', config.rejectAllNumbers);
    await asyncPrefs.setBool('allowAllAllowedNumbers', config.allowAllAllowedNumbers);
    await asyncPrefs.setBool('allowRegexWhitelistedPatterns', config.allowRegexWhitelistedPatterns);
    await asyncPrefs.setBool('allowBlockedNumbers', config.allowBlockedNumbers);
    await asyncPrefs.setBool('allowAllWhitelistedNumbers', config.allowAllWhitelistedNumbers);
    await asyncPrefs.setBool('allowRegexBlacklistedPatterns', config.allowRegexBlacklistedPatterns);
    await asyncPrefs.setBool('allowAllBlacklistedNumbers', config.allowAllBlacklistedNumbers);
  }



  // 工厂方法创建 CallFilter 实例
  static Future<CallFilter> create({required Database database}) async {
    final CallFilter filter = CallFilter(
      regexService: RegexService(database),
      allowedService: AllowedService(database),
      blockedService: BlockedService(database),
      whitelistService: WhitelistService(database),
      blacklistService: BlacklistService(database),
    );
    await filter.initialize(); // 初始化 CallFilter，加载配置信息
    return filter;
  }

  // 初始化方法，加载配置
  Future<void> initialize() async {
    await loadConfig();
  }

  




  //return config.allowBlockedNumbers ? true : "silence";
  // 如果拒绝所有号码，则直接返回 false
  Future<bool> shouldAcceptCall(String phoneNumber) async {
    if (config.rejectAllNumbers) {
      return false;
    }
    // 检查号码是否在允许名单中
    if (config.allowAllAllowedNumbers &&
        await allowedService.contains(phoneNumber)) {
      return true;
    }

    // 检查号码是否在阻止名单中
    if (await blockedService.contains(phoneNumber) &&
        !config.allowBlockedNumbers) {
      return false;
    }
    // 检查号码是否匹配白名单通配符
    if (config.allowRegexWhitelistedPatterns) {
      final whitelistedPatterns =
          await regexService.getWhitelistedPatterns();
      for (var rexPattern in whitelistedPatterns) {
        if (rexPattern.enabled &&
            regexService.matchesPattern(phoneNumber, rexPattern.pattern)) {
          return true;
        }
      }
    }

    // 检查号码是否在白名单中
    if (config.allowAllWhitelistedNumbers &&
        await whitelistService.contains(phoneNumber)) {
      return true;
    }
// 检查号码是否匹配黑名单通配符
    if (config.allowRegexBlacklistedPatterns) {
      final blacklistedPatterns =
          await regexService.getBlacklistedPatterns();
      for (var rexPattern in blacklistedPatterns) {
        if (rexPattern.enabled &&
            regexService.matchesPattern(phoneNumber, rexPattern.pattern)) {
              // 添加打印语句
          return false;
        }
      }
       // 添加打印语句
    }
    // 检查号码是否在黑名单中
    // 如果允许所有黑名单号码，则放行
    if (await blacklistService.contains(phoneNumber) &&
        !config.allowAllBlacklistedNumbers) {
      return false;
    }
    // 放行所有其他号码
    return true;
  }

  void updateConfig(CallFilterConfig newConfig) {
    // 添加打印日志
    config = newConfig;
    // 添加打印日志 确认赋值是否成功
  }
}
