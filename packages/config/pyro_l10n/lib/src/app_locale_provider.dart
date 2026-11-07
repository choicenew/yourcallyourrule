import 'dart:ui';

import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_config_protocol/pyro_config_protocol.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dynamic/dynamic_text_translator.dart';
import 'locale_fallback_resolver.dart';

abstract final class PyroL10nStorageKeys {
  static const String prefix = 'pyro_l10n_';

  // 静态闭包在类首次加载时自动向 PyroConfigRegistry 注册前缀
  static final bool _autoRegistered = () {
    PyroConfigRegistry.registerPrefix(prefix);
    return true;
  }();

  static void ensureRegistered() => _autoRegistered;

  static const String appLocale = '${prefix}locale';
  static const String regionalLocale = '${prefix}regional_locale';
}

/// 可覆写/注入的预加载 SharedPreferences Provider
final sharedPreferencesProvider = Provider<SharedPreferences?>((ref) {
  return null;
});

/// 全局非 UI / 无 Context 访问单例通道 (包含静态/动态翻译)
abstract final class PyroL10nGlobal {
  static Locale? _currentLocale;
  static Locale? _regionalLocale;

  /// 无 Context 获取操作系统当前真实的 Platform Locale
  static Locale get systemPlatformLocale => PlatformDispatcher.instance.locale;

  /// 获取当前实际生效的 Locale (未设置/跟随系统时，自动感知返回操作系统真实的 Locale)
  static Locale get effectiveLocale => _currentLocale ?? systemPlatformLocale;

  /// 格式化 Locale 代码 (如 'zh_CN', 'en_US', 'ja')
  static String formatLocaleCode(Locale locale) {
    return locale.countryCode != null && locale.countryCode!.isNotEmpty
        ? '${locale.languageCode}_${locale.countryCode}'
        : locale.languageCode;
  }

  static DynamicTextTranslator _translator = DynamicTextTranslator(
    localeCode: formatLocaleCode(PlatformDispatcher.instance.locale),
    dict: const {},
  );

  static Locale? get currentLocale => _currentLocale;
  static Locale? get regionalLocale => _regionalLocale;
  static DynamicTextTranslator get dynamicTranslator => _translator;

  static void syncLocale(Locale? appLocale, Locale? regional) {
    _currentLocale = appLocale;
    _regionalLocale = regional;
    final targetLocale = appLocale ?? systemPlatformLocale;
    final code = formatLocaleCode(targetLocale);
    _translator = DynamicTextTranslator(
      localeCode: code,
      dict: const {},
    );
  }

  /// 注册/注册覆盖全域动态转译词典
  static void setDynamicTranslator(DynamicTextTranslator translator) {
    _translator = translator;
  }

  /// 非 UI 场景下的动态长文本转译（长词优先替换，零硬编码）
  static String translateDynamicText(String rawText) {
    return _translator.translateDynamicText(rawText);
  }
}

/// 基于 Riverpod 3.0 与 SharedPreferences 持久化的 App UI Locale 管理器
class AppLocaleNotifier extends Notifier<Locale?> {
  SharedPreferences? _prefs;

  @override
  Locale? build() {
    _prefs = ref.watch(sharedPreferencesProvider);
    if (_prefs != null) {
      final savedCode = _prefs?.getString(PyroL10nStorageKeys.appLocale);
      if (savedCode != null && savedCode.isNotEmpty) {
        final loc = _parseLocale(savedCode);
        PyroL10nGlobal.syncLocale(loc, PyroL10nGlobal.regionalLocale);
        return loc;
      }
    } else {
      _initStorage();
    }
    return null; // null 表示跟随系统的默认 Locale
  }

  Future<void> _initStorage() async {
    _prefs = await SharedPreferences.getInstance();
    final savedCode = _prefs?.getString(PyroL10nStorageKeys.appLocale);
    if (savedCode != null && savedCode.isNotEmpty) {
      final loc = _parseLocale(savedCode);
      state = loc;
      PyroL10nGlobal.syncLocale(loc, PyroL10nGlobal.regionalLocale);
    }
  }

  Locale _parseLocale(String code) {
    if (code.contains('_')) {
      final parts = code.split('_');
      return Locale(parts[0], parts[1]);
    }
    return Locale(code);
  }

  /// 无感实时切换 App Locale（传入 null 表示还原为跟随原生系统语言）
  void setLocale(Locale? locale) {
    state = locale;
    PyroL10nGlobal.syncLocale(locale, PyroL10nGlobal.regionalLocale);
    if (locale == null) {
      _prefs?.remove(PyroL10nStorageKeys.appLocale);
    } else {
      final code = locale.countryCode != null && locale.countryCode!.isNotEmpty
          ? '${locale.languageCode}_${locale.countryCode}'
          : locale.languageCode;
      _prefs?.setString(PyroL10nStorageKeys.appLocale, code);
    }
  }

  /// 根据语言代码 (如 'en', 'zh'，传入 null 重置为系统) 快速切换
  void setLanguageCode(String? code) {
    if (code == null || code.isEmpty) {
      setLocale(null);
    } else {
      setLocale(_parseLocale(code));
    }
  }
}

/// 全局持久化 Locale Provider (Riverpod 3.0)
final appLocaleProvider =
    NotifierProvider<AppLocaleNotifier, Locale?>(AppLocaleNotifier.new);

/// 基于 Riverpod 3.0 的区域与格式化 Locale 控制器 (允许语言与货币/日期格式化地区分离)
class RegionalLocaleNotifier extends Notifier<Locale?> {
  SharedPreferences? _prefs;

  @override
  Locale? build() {
    _prefs = ref.watch(sharedPreferencesProvider);
    if (_prefs != null) {
      final savedCode = _prefs?.getString(PyroL10nStorageKeys.regionalLocale);
      if (savedCode != null && savedCode.isNotEmpty) {
        final loc = _parseLocale(savedCode);
        PyroL10nGlobal.syncLocale(PyroL10nGlobal.currentLocale, loc);
        return loc;
      }
    } else {
      _initStorage();
    }
    return null;
  }

  Future<void> _initStorage() async {
    _prefs = await SharedPreferences.getInstance();
    final savedCode = _prefs?.getString(PyroL10nStorageKeys.regionalLocale);
    if (savedCode != null && savedCode.isNotEmpty) {
      final loc = _parseLocale(savedCode);
      state = loc;
      PyroL10nGlobal.syncLocale(PyroL10nGlobal.currentLocale, loc);
    }
  }

  Locale _parseLocale(String code) {
    if (code.contains('_')) {
      final parts = code.split('_');
      return Locale(parts[0], parts[1]);
    }
    return Locale(code);
  }

  void setRegionalLocale(Locale? locale) {
    state = locale;
    PyroL10nGlobal.syncLocale(PyroL10nGlobal.currentLocale, locale);
    if (locale == null) {
      _prefs?.remove(PyroL10nStorageKeys.regionalLocale);
    } else {
      final code = locale.countryCode != null && locale.countryCode!.isNotEmpty
          ? '${locale.languageCode}_${locale.countryCode}'
          : locale.languageCode;
      _prefs?.setString(PyroL10nStorageKeys.regionalLocale, code);
    }
  }
}

final regionalLocaleProvider =
    NotifierProvider<RegionalLocaleNotifier, Locale?>(RegionalLocaleNotifier.new);

/// 原生 [BuildContext] 快捷扩展糖：无硬编码原生获取当前 Context 的 [TextDirection] 与 RTL 状态
extension PyroNativeL10nContextX on BuildContext {
  /// 原生获取当前界面的文本方向 (RTL vs LTR)
  TextDirection get textDirection => Directionality.of(this);

  /// 原生判断当前界面是否为从右至左 (RTL) 布局
  bool get isRtl => textDirection == TextDirection.rtl;
}

/// 官方 gen-l10n 与 AppLocalizations 脚手架胶水配置
abstract final class PyroL10nHelper {
  /// 标准 Flutter/Material_UI 原生全局 Localizations Delegates
  static List<LocalizationsDelegate<dynamic>> get defaultLocalizationsDelegates =>
      GlobalMaterialLocalizations.delegates;

  /// 组合包含官方 [AppLocalizations.delegate] 的全量 LocalizationsDelegates
  static List<LocalizationsDelegate<dynamic>> combineDelegates(
    LocalizationsDelegate<dynamic> appDelegate,
  ) {
    return [
      appDelegate,
      ...defaultLocalizationsDelegates,
    ];
  }

  /// 级联降级匹配 Locale
  static Locale resolveLocale(
    Locale? requested,
    List<Locale> supportedLocales, {
    Locale defaultFallback = const Locale('en'),
  }) {
    return LocaleFallbackResolver.resolveLocale(
      requested,
      supportedLocales,
      defaultFallback: defaultFallback,
    );
  }
}
