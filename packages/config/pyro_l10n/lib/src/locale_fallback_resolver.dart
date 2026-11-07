import 'package:material_ui/material_ui.dart';

/// 级联语言降级决议器 (Locale Fallback Cascade Resolver)
/// 支持多级精准匹配降级（例如：zh_HK -> zh_TW -> zh_Hant -> zh -> defaultFallback）
abstract final class LocaleFallbackResolver {
  /// 匹配并求解最适 Locale
  static Locale resolveLocale(
    Locale? requested,
    List<Locale> supportedLocales, {
    Locale defaultFallback = const Locale('en'),
  }) {
    if (requested == null) {
      return supportedLocales.isNotEmpty ? supportedLocales.first : defaultFallback;
    }

    // 1. 尝试 1:1 完全精准匹配（Language, Country, Script 全部一致）
    for (final supported in supportedLocales) {
      if (supported.languageCode == requested.languageCode &&
          supported.countryCode == requested.countryCode &&
          supported.scriptCode == requested.scriptCode) {
        return supported;
      }
    }

    // 2. 尝试 Language + Country 匹配
    if (requested.countryCode != null && requested.countryCode!.isNotEmpty) {
      for (final supported in supportedLocales) {
        if (supported.languageCode == requested.languageCode &&
            supported.countryCode == requested.countryCode) {
          return supported;
        }
      }
    }

    // 3. 尝试 Language + Script 匹配
    if (requested.scriptCode != null && requested.scriptCode!.isNotEmpty) {
      for (final supported in supportedLocales) {
        if (supported.languageCode == requested.languageCode &&
            supported.scriptCode == requested.scriptCode) {
          return supported;
        }
      }
    }

    // 4. 语言组特别替代路线（如繁体中文区域变体 HK/MO/TW 优先配对其他繁体）
    if (requested.languageCode == 'zh') {
      final isTraditional = requested.countryCode == 'HK' ||
          requested.countryCode == 'MO' ||
          requested.countryCode == 'TW' ||
          requested.scriptCode == 'Hant';

      if (isTraditional) {
        for (final supported in supportedLocales) {
          if (supported.languageCode == 'zh' &&
              (supported.countryCode == 'TW' ||
                  supported.countryCode == 'HK' ||
                  supported.countryCode == 'MO' ||
                  supported.scriptCode == 'Hant')) {
            return supported;
          }
        }
      }
    }

    // 5. 尝试仅 Language 匹配 (如 es_MX -> es)
    for (final supported in supportedLocales) {
      if (supported.languageCode == requested.languageCode) {
        return supported;
      }
    }

    // 6. 最终兜底降级
    return supportedLocales.contains(defaultFallback)
        ? defaultFallback
        : (supportedLocales.isNotEmpty ? supportedLocales.first : defaultFallback);
  }
}
