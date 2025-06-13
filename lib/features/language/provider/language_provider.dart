import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/provider/providers/locale_service_provider.dart';
import 'package:yourcallyourrule/features/language/config/locale_config.dart';
import 'package:yourcallyourrule/features/language/services/locale_service.dart';

// 定义 LocaleState 状态类
class LocaleState {
  final Locale locale;

  const LocaleState({this.locale = const Locale('en', 'US')});

  // 创建状态的副本并更新特定字段
  LocaleState copyWith({Locale? locale}) {
    return LocaleState(
      locale: locale ?? this.locale,
    );
  }
}

// 使用 StateNotifier 替代 ChangeNotifier
class LocaleNotifier extends StateNotifier<LocaleState> {
  final LocaleService _localeService;

  LocaleNotifier(this._localeService) : super(const LocaleState()) {
    loadSavedLocale();
  }

  // 获取当前语言设置
  Locale get locale => state.locale;

  Future<void> loadSavedLocale() async {
    final savedLocale = await _localeService.loadConfig();
    if (savedLocale != null) {
      state = state.copyWith(locale: savedLocale.locale);
    }
  }

  Future<void> updateLocale(Locale newLocale) async {
    state = state.copyWith(locale: newLocale);
    await _localeService.saveConfig(newLocale.languageCode, newLocale.countryCode);
  }
}

// 创建 LocaleNotifier 的 Provider
final localeProvider = StateNotifierProvider<LocaleNotifier, LocaleState>((ref) {
  final localeService = ref.read(localeServiceProvider);
  return LocaleNotifier(localeService);
});

// 为了向后兼容，保留 LocaleProvider 类，但内部使用 Riverpod
class LocaleProvider with ChangeNotifier {
  final LocaleService _localeService;
  Locale _locale = const Locale('en', 'US');
  
  LocaleProvider(this._localeService) {
    _loadSavedLocale();
  }

  Locale get locale => _locale;

  void _loadSavedLocale() async {
    final config = await _localeService.loadConfig();
    if (config != null) {
      _locale = config.locale;
      notifyListeners();
    }
  }

  Future<void> updateLocale(Locale newLocale) async {
    if (_locale != newLocale) {
      _locale = newLocale;
      notifyListeners();
      await _localeService.saveConfig(newLocale.languageCode, newLocale.countryCode);
    }
  }
}

