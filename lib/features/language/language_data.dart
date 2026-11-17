import 'dart:ui';

final List<Map<String, dynamic>> languages = [
  {'name': '中文简体 (中国)', 'code': const Locale('zh', 'CN'), 'flag': 'CN'},
  {'name': '中文 (简体)', 'code': const Locale('zh'), 'flag': 'CN'},
  {'name': 'English', 'code': const Locale('en'), 'flag': 'US'},
  {'name': '繁體中文 (台湾)', 'code': const Locale('zh', 'TW'), 'flag': 'TW'},
  {'name': '繁體中文 (香港)', 'code': const Locale('zh', 'HK'), 'flag': 'HK'},
  {'name': '繁體中文 (澳门)', 'code': const Locale('zh', 'MO'), 'flag': 'MO'},
  {'name': '日本語', 'code': const Locale('ja', 'JP'), 'flag': 'JP'},
  {'name': 'العربية', 'code': const Locale('ar'), 'flag': 'SA'},
  {'name': 'Bahasa Malaysia', 'code': const Locale('ms', 'MY'), 'flag': 'MY'},
  {'name': 'Bahasa Indonesia', 'code': const Locale('id', 'ID'), 'flag': 'ID'},
  {'name': 'Dansk', 'code': const Locale('da', 'DK'), 'flag': 'DK'},
  {'name': 'Deutsch', 'code': const Locale('de'), 'flag': 'DE'},
  {'name': 'English (UK)', 'code': const Locale('en', 'GB'), 'flag': 'GB'},
  {'name': 'English (US)', 'code': const Locale('en', 'US'), 'flag': 'US'},
  {'name': 'Español', 'code': const Locale('es'), 'flag': 'ES'},
  {'name': 'Français', 'code': const Locale('fr'), 'flag': 'FR'},
  {'name': 'Italiano', 'code': const Locale('it'), 'flag': 'IT'},
  {'name': 'Nederlands', 'code': const Locale('nl', 'NL'), 'flag': 'NL'},
  {'name': 'Polski', 'code': const Locale('pl', 'PL'), 'flag': 'PL'},
  {'name': 'Português', 'code': const Locale('pt'), 'flag': 'PT'},
  {'name': 'Русский', 'code': const Locale('ru', 'RU'), 'flag': 'RU'},
  {'name': 'Svenska', 'code': const Locale('sv', 'SE'), 'flag': 'SE'},
  {'name': 'Türkçe', 'code': const Locale('tr', 'TR'), 'flag': 'TR'},
  {'name': 'Ελληνικά', 'code': const Locale('el', 'GR'), 'flag': 'GR'},
  {'name': 'עברית', 'code': const Locale('he', 'IL'), 'flag': 'IL'},
  {'name': 'Українська', 'code': const Locale('uk', 'UA'), 'flag': 'UA'},
  {'name': 'ภาษาไทย', 'code': const Locale('th', 'TH'), 'flag': 'TH'},
  {'name': 'Norsk', 'code': const Locale('nb', 'NO'), 'flag': 'NO'},
  {'name': 'Suomi', 'code': const Locale('fi', 'FI'), 'flag': 'FI'},
  {'name': 'Čeština', 'code': const Locale('cs', 'CZ'), 'flag': 'CZ'},
  {'name': 'Română', 'code': const Locale('ro', 'RO'), 'flag': 'RO'},
  {'name': '한국어', 'code': const Locale('ko', 'KR'), 'flag': 'KR'},
  {'name': 'မြန်မာ', 'code': const Locale('my', 'MM'), 'flag': 'MM'},
  {'name': 'Tiếng Việt', 'code': const Locale('vi', 'VN'), 'flag': 'VN'},
  {'name': 'हिंदी', 'code': const Locale('hi', 'IN'), 'flag': 'IN'},
  {'name': 'বাংলা', 'code': const Locale('bn', 'BD'), 'flag': 'BD'},
  {'name': 'اردو', 'code': const Locale('ur', 'PK'), 'flag': 'PK'},
  {'name': 'Filipino', 'code': const Locale('fil', 'PH'), 'flag': 'PH'},
  {'name': 'فارسی', 'code': const Locale('fa', 'IR'), 'flag': 'IR'},
  {'name': 'Kiswahili', 'code': const Locale('sw'), 'flag': 'KE'},
  {'name': 'Hausa', 'code': const Locale('ha'), 'flag': 'NG'},
  {'name': 'isiZulu', 'code': const Locale('zu', 'ZA'), 'flag': 'ZA'},
  {'name': 'isiXhosa', 'code': const Locale('xh', 'ZA'), 'flag': 'ZA'},
  {'name': 'Afrikaans', 'code': const Locale('af', 'ZA'), 'flag': 'ZA'},
  {'name': 'አማርኛ', 'code': const Locale('am'), 'flag': 'ET'},
  {'name': 'Eesti', 'code': const Locale('et'), 'flag': 'EE'},
  {'name': 'ខ្មែរ', 'code': const Locale('km', 'KH'), 'flag': 'KH'},
  {'name': 'Slovenčina', 'code': const Locale('sk', 'SK'), 'flag': 'SK'},
  {'name': 'Oʻzbekcha', 'code': const Locale('uz'), 'flag': 'UZ'},
  {'name': 'Basa Jawa', 'code': const Locale('jv', 'ID'), 'flag': 'ID'},
  {'name': 'Yorùbá', 'code': const Locale('yo', 'NG'), 'flag': 'NG'},
  {'name': 'Magyar', 'code': const Locale('hu', 'HU'), 'flag': 'HU'},
];

final Map<String, String> languageFlagMap = {
  for (final lang in languages)
    (lang['code'] as Locale).languageCode: (lang['flag'] as String? ?? '')
};

String resolveLanguageFlag(dynamic language) {
  if (language is Map<String, dynamic>) {
    final flag = language['flag'];
    if (flag is String && flag.isNotEmpty) return flag;
    final code = language['code'];
    if (code is Locale) {
      if (code.countryCode != null && code.countryCode!.isNotEmpty) {
        return code.countryCode!;
      }
      return languageFlagMap[code.languageCode] ?? '';
    }
  } else if (language is Locale) {
    if (language.countryCode != null && language.countryCode!.isNotEmpty) {
      return language.countryCode!;
    }
    return languageFlagMap[language.languageCode] ?? '';
  }
  return '';
}
