import 'dart:ui';

final List<Map<String, dynamic>> languages = [
  {'name': '中文简体 (中国)', 'code': const Locale('zh', 'CN')},
  {'name': '中文 (简体)', 'code': const Locale('zh')},
  {'name': 'English', 'code': const Locale('en')},
  {'name': '繁體中文 (台湾)', 'code': const Locale('zh', 'TW')},
  {'name': '繁體中文 (香港)', 'code': const Locale('zh', 'HK')},
  {'name': '繁體中文 (澳门)', 'code': const Locale('zh', 'MO')},
  {'name': '日本語', 'code': const Locale('ja', 'JP')},
  {'name': 'العربية', 'code': const Locale('ar')},
  {'name': 'Bahasa Malaysia', 'code': const Locale('ms', 'MY')},
  {'name': 'Bahasa Indonesia', 'code': const Locale('id', 'ID')},
  {'name': 'Dansk', 'code': const Locale('da', 'DK')},
  {'name': 'Deutsch', 'code': const Locale('de')},
  {'name': 'English (UK)', 'code': const Locale('en', 'GB')},
  {'name': 'English (US)', 'code': const Locale('en', 'US')},
  {'name': 'Español', 'code': const Locale('es')},
  {'name': 'Français', 'code': const Locale('fr')},
  {'name': 'Italiano', 'code': const Locale('it')},
  {'name': 'Nederlands', 'code': const Locale('nl', 'NL')},
  {'name': 'Polski', 'code': const Locale('pl', 'PL')},
  {'name': 'Português', 'code': const Locale('pt')},
  {'name': 'Русский', 'code': const Locale('ru', 'RU')},
  {'name': 'Svenska', 'code': const Locale('sv', 'SE')},
  {'name': 'Türkçe', 'code': const Locale('tr', 'TR')},
  {'name': 'Ελληνικά', 'code': const Locale('el', 'GR')},
  {'name': 'עברית', 'code': const Locale('he', 'IL')},
  {'name': 'Українська', 'code': const Locale('uk', 'UA')},
  {'name': 'ภาษาไทย', 'code': const Locale('th', 'TH')},
  // -- 新增的4个欧洲语言 --
  {'name': 'Norsk', 'code': const Locale('nb', 'NO')},          // 挪威语
  {'name': 'Suomi', 'code': const Locale('fi', 'FI')},          // 芬兰语
  {'name': 'Čeština', 'code': const Locale('cs', 'CZ')},          // 捷克语
  {'name': 'Română', 'code': const Locale('ro', 'RO')},          // 罗马尼亚语

  {'name': '한국어', 'code': const Locale('ko', 'KR')},
  {'name': 'မြန်မာ', 'code': const Locale('my', 'MM')},

  {'name': 'Tiếng Việt', 'code': const Locale('vi', 'VN')},
  // Add more languages as needed
  {'name': 'हिंदी', 'code': const Locale('hi', 'IN')},          // 印地语 (印度)
  {'name': 'বাংলা', 'code': const Locale('bn', 'BD')},          // 孟加拉语 (孟加拉国)
  {'name': 'اردو', 'code': const Locale('ur', 'PK')},            // 乌尔都语 (巴基斯坦)
  {'name': 'Filipino', 'code': const Locale('fil', 'PH')},      // 菲律宾语 (菲律宾)
  {'name': 'فارسی', 'code': const Locale('fa', 'IR')},           // 波斯语 (伊朗)
  {'name': 'Kiswahili', 'code': const Locale('sw')},             // 斯瓦希里语 (东非)
  {'name': 'Hausa', 'code': const Locale('ha')},                 // 豪萨语 (西非)
    {'name': 'isiZulu', 'code': const Locale('zu', 'ZA')},      // 祖鲁语: 南非第一大母语 (约24%人口). [1, 2] 在夸祖鲁-纳塔尔省和豪登省（经济中心）有绝对优势.
  {'name': 'isiXhosa', 'code': const Locale('xh', 'ZA')},     // 科萨语: 第二大母语 (约16%人口). [1, 2] 在东开普省和西开普省有大量使用者.
  {'name': 'Afrikaans', 'code': const Locale('af', 'ZA')},    // 南非荷兰语: 第三大母语 (约11%人口). [1, 2] 在西开普省和北开普省占主导，跨种族使用，购买力强.

  // -- 新增：根据 .arb 文件补充 --
  {'name': 'አማርኛ', 'code': const Locale('am')},            // 阿姆哈拉语 (对应 app_am.arb)
  {'name': 'Eesti', 'code': const Locale('et')},             // 爱沙尼亚语 (对应 app_et.arb)
  {'name': 'ខ្មែរ', 'code': const Locale('km', 'KH')},        // 高棉语 (对应 app_km.arb)
  {'name': 'Slovenčina', 'code': const Locale('sk', 'SK')},   // 斯洛伐克语 (对应 app_sk.arb)
  {'name': 'Oʻzbekcha', 'code': const Locale('uz')},   
  // --- 第二优先级：深入关键区域市场 ---
  {'name': 'Basa Jawa', 'code': const Locale('jv', 'ID')},     // 爪哇语: 印度尼西亚最大的民族语言，母语使用者超过8000万，比印尼语还多。能让你更贴近印尼本地用户。
  {'name': 'Yorùbá', 'code': const Locale('yo', 'NG')},         // 约鲁巴语: 尼日利亚（非洲人口第一大国）三大主要语言之一，使用者超过5000万。
  {'name': 'Magyar', 'code': const Locale('hu', 'HU')},         // 匈牙利语: 匈牙利的官方语言，是欧盟内一个重要的、拥有独特文化的市场。     // 乌兹别克语

];
