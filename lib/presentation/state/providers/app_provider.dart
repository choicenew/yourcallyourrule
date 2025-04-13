import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../infrastructure/datasources/local/preferences/app_preferences.dart';
import '../base/base_provider.dart';

/// 应用Provider
/// 负责管理应用全局状态
class AppProvider extends BaseProvider {
  final AppPreferences _preferences;

  ThemeMode _themeMode = ThemeMode.system;
  Locale _locale = const Locale('zh', 'CN'); // 默认中文
  bool _notificationsEnabled = true;
  bool _callFilteringEnabled = true;
  bool _smsFilteringEnabled = true;

  /// 构造函数
  AppProvider({
    required AppPreferences preferences,
  }) : _preferences = preferences {
    _loadSettings();
  }

  /// 主题模式
  ThemeMode get themeMode => _themeMode;

  /// 当前语言
  Locale get locale => _locale;

  /// 通知是否启用
  bool get notificationsEnabled => _notificationsEnabled;

  /// 通话过滤是否启用
  bool get callFilteringEnabled => _callFilteringEnabled;

  /// 短信过滤是否启用
  bool get smsFilteringEnabled => _smsFilteringEnabled;

  /// 加载设置
  Future<void> _loadSettings() async {
    setLoading(true);
    clearError();

    try {
      // 加载主题设置
      final themeModeIndex = await _preferences.getInt('theme_mode') ?? 0;
      _themeMode = ThemeMode.values[themeModeIndex];

      // 加载语言设置
      final languageCode = await _preferences.getString('language_code') ?? 'zh';
      final countryCode = await _preferences.getString('country_code') ?? 'CN';
      _locale = Locale(languageCode, countryCode);

      // 加载功能开关设置
      _notificationsEnabled = await _preferences.getBool('notifications_enabled') ?? true;
      _callFilteringEnabled = await _preferences.getBool('call_filtering_enabled') ?? true;
      _smsFilteringEnabled = await _preferences.getBool('sms_filtering_enabled') ?? true;

      notifyListeners();
    } catch (e) {
      setError(e.toString());
    } finally {
      setLoading(false);
    }
  }

  /// 设置主题模式
  Future<void> setThemeMode(ThemeMode mode) async {
    if (_themeMode == mode) return;

    try {
      await _preferences.setInt('theme_mode', mode.index);
      _themeMode = mode;
      notifyListeners();
    } catch (e) {
      setError(e.toString());
    }
  }

  /// 设置语言
  Future<void> setLocale(Locale newLocale) async {
    if (_locale == newLocale) return;

    try {
      await _preferences.setString('language_code', newLocale.languageCode);
      await _preferences.setString('country_code', newLocale.countryCode ?? '');
      _locale = newLocale;
      notifyListeners();
    } catch (e) {
      setError(e.toString());
    }
  }

  /// 设置通知开关
  Future<void> setNotificationsEnabled(bool enabled) async {
    if (_notificationsEnabled == enabled) return;

    try {
      await _preferences.setBool('notifications_enabled', enabled);
      _notificationsEnabled = enabled;
      notifyListeners();
    } catch (e) {
      setError(e.toString());
    }
  }

  /// 设置通话过滤开关
  Future<void> setCallFilteringEnabled(bool enabled) async {
    if (_callFilteringEnabled == enabled) return;

    try {
      await _preferences.setBool('call_filtering_enabled', enabled);
      _callFilteringEnabled = enabled;
      notifyListeners();
    } catch (e) {
      setError(e.toString());
    }
  }

  /// 设置短信过滤开关
  Future<void> setSmsFilteringEnabled(bool enabled) async {
    if (_smsFilteringEnabled == enabled) return;

    try {
      await _preferences.setBool('sms_filtering_enabled', enabled);
      _smsFilteringEnabled = enabled;
      notifyListeners();
    } catch (e) {
      setError(e.toString());
    }
  }

  /// 重置所有设置
  Future<void> resetSettings() async {
    try {
      await _preferences.remove('theme_mode');
      await _preferences.remove('language_code');
      await _preferences.remove('country_code');
      await _preferences.remove('notifications_enabled');
      await _preferences.remove('call_filtering_enabled');
      await _preferences.remove('sms_filtering_enabled');
      
      // 重新加载默认设置
      await _loadSettings();
    } catch (e) {
      setError(e.toString());
    }
  }
}