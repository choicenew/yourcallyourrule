// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Ukrainian (`uk`).
class AppLocalizationsUk extends AppLocalizations {
  AppLocalizationsUk([String locale = 'uk']) : super(locale);

  @override
  String get themeSettingsExpansionTitle =>
      'Розширені налаштування зовнішнього вигляду та колірного двигуна';

  @override
  String get selectThemeModeTitle => 'Вибрати режим теми';

  @override
  String get themeAuto => 'Системна за замовчуванням';

  @override
  String get themeLight => 'Світла тема';

  @override
  String get themeDark => 'Темна тема';

  @override
  String get dynamicColorTitle => 'Динамічний колір Android 12+ (Material You)';

  @override
  String get dynamicColorSubtitle =>
      'Автоматичне вилучення кольору шпалер системи як основного кольору теми';

  @override
  String get flexSchemePresetTitle => 'Готова палітра FlexScheme';

  @override
  String get selectFlexSchemeDialogTitle => 'Виберіть готову колірну тему';

  @override
  String get pickCustomThemeColorTitle => 'Вибрати користувацький колір теми';

  @override
  String get oledTrueBlackTitle => 'Режим OLED True Black';

  @override
  String get oledTrueBlackSubtitle =>
      'Використовуйте абсолютно чорний фон (#000000) у темному режимі для економії заряду батареї';

  @override
  String get highContrastTitle => 'Підвищення візуального контрасту';

  @override
  String get highContrastSubtitle =>
      'Покращення доступності та читабельності тексту й меж';

  @override
  String get primarySwapTitle => 'Обмін основного / вторинного кольорів';

  @override
  String get primarySwapSubtitle =>
      'Зміна ваги заповнення основного та вторинного кольорів в UI';

  @override
  String get glassmorphismSectionTitle => 'Ефекти рідкого скла (Glassmorphism)';

  @override
  String get glassBlurTitle => 'Радіус розмиття скла (Blur Radius)';

  @override
  String get glassOpacityTitle =>
      'Прозорість скляного контейнера (Glass Opacity)';

  @override
  String get appDisplayLanguageTitle => 'Мова інтерфейсу додатку';

  @override
  String get selectAppLanguageTitle => 'Вибрати мову додатка';

  @override
  String get searchLanguageHint =>
      'Пошук назви мови або коду (напр. uk, en, zh)...';

  @override
  String get designTokensPreviewTitle =>
      'Попередній перегляд палітри Design Tokens';

  @override
  String get modeCustomSeed => 'Користувацький колір (Custom Seed)';

  @override
  String get modeDynamicWallpaper =>
      'Автоматичне вилучення з динамічних шпалер';

  @override
  String get modeFlexSchemePreset => 'Готові палітри FlexScheme';

  @override
  String get closeButton => 'Закрити';
}
