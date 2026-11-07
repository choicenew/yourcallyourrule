// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get themeSettingsExpansionTitle =>
      'إعدادات المظهر المتقدمة ومحرك الألوان';

  @override
  String get selectThemeModeTitle => 'تحديد وضع السمة';

  @override
  String get themeAuto => 'افتراضي النظام';

  @override
  String get themeLight => 'السمة الفاتحة';

  @override
  String get themeDark => 'السمة الداكنة';

  @override
  String get dynamicColorTitle =>
      'استخراج ألوان خلفية الشاشة الديناميكية (Android 12+)';

  @override
  String get dynamicColorSubtitle =>
      'استخراج ألوان خلفية النظام تلقائيًا كمظهر رئيسي للتطبيق';

  @override
  String get flexSchemePresetTitle => 'مخطط الألوان المسبق FlexScheme';

  @override
  String get selectFlexSchemeDialogTitle => 'حدد مظهر الألوان المسبق';

  @override
  String get pickCustomThemeColorTitle => 'تحديد لون سمة مخصص';

  @override
  String get oledTrueBlackTitle => 'وضع السواد التام لـ OLED';

  @override
  String get oledTrueBlackSubtitle =>
      'استخدام خلفية سوداء نقية (#000000) في الوضع الداكن لتوفير الطاقة';

  @override
  String get highContrastTitle => 'تعزيز التباين العالي';

  @override
  String get highContrastSubtitle =>
      'زيادة التباين بين النصوص والحدود لتحسين إمكانية القراءة';

  @override
  String get primarySwapTitle => 'تبديل الألوان الرئيسية والثانوية';

  @override
  String get primarySwapSubtitle =>
      'تبديل وزني الألوان الأساسية والثانوية في الواجهة';

  @override
  String get glassmorphismSectionTitle =>
      'تأثير الزجاج الضبابي السائل (Glassmorphism)';

  @override
  String get glassBlurTitle => 'نصف قطر ضبابية الزجاج (Blur Radius)';

  @override
  String get glassOpacityTitle => 'شفافية حاوية الزجاج (Glass Opacity)';

  @override
  String get appDisplayLanguageTitle => 'لغة عرض واجهة التطبيق';

  @override
  String get selectAppLanguageTitle => 'تحديد لغة التطبيق';

  @override
  String get searchLanguageHint =>
      'ابحث عن اسم اللغة أو الرمز (مثل ar, en, zh)...';

  @override
  String get designTokensPreviewTitle => 'معاينة لوحة ألوان رموز التصميم';

  @override
  String get modeCustomSeed => 'بذرة ألوان مخصصة (Custom Seed)';

  @override
  String get modeDynamicWallpaper =>
      'استخراج تلقائي من خلفية الشاشة الديناميكية';

  @override
  String get modeFlexSchemePreset => 'ألوان FlexScheme المسبقة';

  @override
  String get closeButton => 'إغلاق';
}
