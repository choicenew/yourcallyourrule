import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/provider/providers/locale_service_provider.dart';
// import 'package:yourcallyourrule/features/language/config/locale_config.dart'; // 如果没用到可以删除

// 1. LocaleState 类不再需要，可以直接删除。

// 2. 将 LocaleNotifier 从 StateNotifier 重构为 AsyncNotifier
class LocaleNotifier extends AsyncNotifier<Locale> {
  // build 方法用于提供初始状态
  // 它必须是异步的，并且会在 Provider 第一次被读取时执行
  @override
  Future<Locale> build() async {
    final localeService = ref.watch(localeServiceProvider);
    final savedConfig = await localeService.loadConfig();

    // 如果有保存的配置，则返回它，否则返回默认值
    return savedConfig?.locale ?? const Locale('en', 'US');
  }

  // 3. 添加一个公共方法来更新状态
  Future<void> updateLocale(Locale newLocale) async {
    // 读取 service
    final localeService = ref.read(localeServiceProvider);

    // 将 UI 状态设置为新值。
    // AsyncValue.data 表示一个成功的状态
    state = AsyncValue.data(newLocale);

    // 异步地将新设置保存到存储中
    await localeService.saveConfig(newLocale.languageCode, newLocale.countryCode);
  }
}

// 4. 将 StateNotifierProvider 更新为 AsyncNotifierProvider
final localeProvider = AsyncNotifierProvider<LocaleNotifier, Locale>(() {
  return LocaleNotifier();
});

// 5. LocaleProvider (ChangeNotifier) 和 legacyLocaleProvider 不再需要，可以完全删除。