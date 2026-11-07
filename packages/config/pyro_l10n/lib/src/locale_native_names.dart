import 'package:material_ui/material_ui.dart';

/// 全局权威 Locale 母语自称 (Autonym) 映射表
abstract final class PyroLocaleNativeNames {
  static const Map<String, String> _nativeNames = {
    'ar': 'العربية',
    'bg': 'Български',
    'bn': 'বাংলা',
    'ca': 'Català',
    'cs': 'Čeština',
    'da': 'Dansk',
    'de': 'Deutsch',
    'el': 'Ελληνικά',
    'en': 'English',
    'es': 'Español',
    'et': 'Eesti',
    'fa': 'فارسی',
    'fi': 'Suomi',
    'fil': 'Filipino',
    'fr': 'Français',
    'gu': 'ગુજરાતી',
    'he': 'עברית',
    'hi': 'हिन्दी',
    'hr': 'Hrvatski',
    'hu': 'Magyar',
    'id': 'Bahasa Indonesia',
    'it': 'Italiano',
    'ja': '日本語',
    'kn': 'ಕನ್ನಡ',
    'ko': '한국어',
    'lt': 'Lietuvių',
    'lv': 'Latviešu',
    'ml': 'മലയാളം',
    'mr': 'मराठी',
    'ms': 'Bahasa Melayu',
    'nb': 'Norsk Bokmål',
    'nl': 'Nederlands',
    'pl': 'Polski',
    'pt': 'Português',
    'pt_BR': 'Português (Brasil)',
    'pt_PT': 'Português (Portugal)',
    'ro': 'Română',
    'ru': 'Русский',
    'sk': 'Slovenčina',
    'sl': 'Slovenščina',
    'sr': 'Српски',
    'sv': 'Svenska',
    'ta': 'தமிழ்',
    'te': 'తెలుగు',
    'th': 'ไทย',
    'tr': 'Türkçe',
    'uk': 'Українська',
    'ur': 'اردو',
    'vi': 'Tiếng Việt',
    'zh': '中文',
    'zh_CN': '简体中文',
    'zh_HK': '繁體中文 (香港)',
    'zh_TW': '繁體中文 (台灣)',
  };

  /// 获取指定 [Locale] 的标准母语自称 (如 '简体中文', 'English', 'Русский')
  static String getNativeName(Locale? locale, {String? defaultText}) {
    if (locale == null) return defaultText ?? 'System Default';

    // 优先完整 Tag (如 zh_CN, pt_BR)
    final fullTag = locale.countryCode != null && locale.countryCode!.isNotEmpty
        ? '${locale.languageCode}_${locale.countryCode}'
        : locale.languageCode;

    if (_nativeNames.containsKey(fullTag)) {
      return _nativeNames[fullTag]!;
    }

    // 降级只查 2 位语言代码 (如 zh)
    final langCode = locale.languageCode;
    if (_nativeNames.containsKey(langCode)) {
      return _nativeNames[langCode]!;
    }

    return fullTag;
  }
}

/// 扩展糖：便捷获取 Locale 的母语名称
extension PyroLocaleNativeNameX on Locale {
  String get nativeName => PyroLocaleNativeNames.getNativeName(this);
}
