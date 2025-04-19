import 'package:shared_preferences/shared_preferences.dart';

import '../../../../common/constants/app_constants.dart';
import '../../../../common/error/exceptions.dart';

/// 应用偏好设置类
/// 负责管理应用的本地存储偏好
class AppPreferences {
  static final AppPreferences _instance = AppPreferences._internal();
  static SharedPreferences? _prefs;

  // 单例模式
  factory AppPreferences() => _instance;

  AppPreferences._internal();

  /// 初始化SharedPreferences
  Future<void> init() async {
    try {
      _prefs = await SharedPreferences.getInstance();
    } catch (e) {
      throw CacheException('初始化SharedPreferences失败: $e');
    }
  }

  /// 获取SharedPreferences实例
  SharedPreferences get prefs {
    if (_prefs == null) {
      throw CacheException('SharedPreferences未初始化');
    }
    return _prefs!;
  }

  /// 设置主题模式
  Future<bool> setThemeMode(String themeMode) async {
    return await prefs.setString(AppConstants.prefsKeyTheme, themeMode);
  }

  /// 获取主题模式
  String getThemeMode() {
    return prefs.getString(AppConstants.prefsKeyTheme) ?? 'system';
  }

  /// 设置语言代码
  Future<bool> setLanguageCode(String languageCode) async {
    return await prefs.setString(AppConstants.prefsKeyLanguage, languageCode);
  }

  /// 获取语言代码
  String getLanguageCode() {
    return prefs.getString(AppConstants.prefsKeyLanguage) ?? 'zh';
  }

  /// 设置是否首次运行
  Future<bool> setFirstRun(bool isFirstRun) async {
    return await prefs.setBool(AppConstants.prefsKeyFirstRun, isFirstRun);
  }

  /// 获取是否首次运行
  bool isFirstRun() {
    return prefs.getBool(AppConstants.prefsKeyFirstRun) ?? true;
  }

  /// 设置最后同步时间
  Future<bool> setLastSyncTime(DateTime dateTime) async {
    return await prefs.setInt(
      AppConstants.prefsKeyLastSync,
      dateTime.millisecondsSinceEpoch,
    );
  }

  /// 获取最后同步时间
  DateTime? getLastSyncTime() {
    final timestamp = prefs.getInt(AppConstants.prefsKeyLastSync);
    if (timestamp == null) return null;
    return DateTime.fromMillisecondsSinceEpoch(timestamp);
  }

  /// 保存字符串值
  Future<bool> setString(String key, String value) async {
    return await prefs.setString(key, value);
  }

  /// 获取字符串值
  String? getString(String key) {
    return prefs.getString(key);
  }

  /// 保存整数值
  Future<bool> setInt(String key, int value) async {
    return await prefs.setInt(key, value);
  }

  /// 获取整数值
  int? getInt(String key) {
    return prefs.getInt(key);
  }

  /// 保存布尔值
  Future<bool> setBool(String key, bool value) async {
    return await prefs.setBool(key, value);
  }

  /// 获取布尔值
  bool? getBool(String key) {
    return prefs.getBool(key);
  }

  /// 保存双精度值
  Future<bool> setDouble(String key, double value) async {
    return await prefs.setDouble(key, value);
  }

  /// 获取双精度值
  double? getDouble(String key) {
    return prefs.getDouble(key);
  }

  /// 保存字符串列表
  Future<bool> setStringList(String key, List<String> value) async {
    return await prefs.setStringList(key, value);
  }

  /// 获取字符串列表
  List<String>? getStringList(String key) {
    return prefs.getStringList(key);
  }

  /// 检查键是否存在
  bool containsKey(String key) {
    return prefs.containsKey(key);
  }

  /// 移除指定键的值
  Future<bool> remove(String key) async {
    return await prefs.remove(key);
  }

  /// 清除所有值
  Future<bool> clear() async {
    return await prefs.clear();
  }
}