// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Bulgarian (`bg`).
class AppLocalizationsBg extends AppLocalizations {
  AppLocalizationsBg([String locale = 'bg']) : super(locale);

  @override
  String get themeSettingsExpansionTitle =>
      'Разширени настройки за външен вид и цветен двигател';

  @override
  String get selectThemeModeTitle => 'Изберете режим на темата';

  @override
  String get themeAuto => 'Системен стандарт';

  @override
  String get themeLight => 'Светла тема';

  @override
  String get themeDark => 'Тъмна тема';

  @override
  String get dynamicColorTitle =>
      'Динамичен цвят на тапета Android 12+ (Material You)';

  @override
  String get dynamicColorSubtitle =>
      'Автоматично извличане на цвета на системния тапет като основен тон на темата';

  @override
  String get flexSchemePresetTitle =>
      'Предварително зададена цветова схема FlexScheme';

  @override
  String get selectFlexSchemeDialogTitle =>
      'Изберете предварително зададена цветова тема';

  @override
  String get pickCustomThemeColorTitle =>
      'Изберете персонализиран цвят за темата';

  @override
  String get oledTrueBlackTitle => 'Режим OLED True Black';

  @override
  String get oledTrueBlackSubtitle =>
      'Използвайте абсолютно чист черен фон (#000000) в тъмен режим за пестене на батерия';

  @override
  String get highContrastTitle => 'Визуално подобрение с висок контраст';

  @override
  String get highContrastSubtitle =>
      'Увеличете контраста на текста и рамките за по-добра достъпност';

  @override
  String get primarySwapTitle => 'Размяна на основен / вторичен цвят';

  @override
  String get primarySwapSubtitle =>
      'Разменете теглото на запълване на основния и втория цвят в потребителския интерфейс';

  @override
  String get glassmorphismSectionTitle =>
      'Ефекти на течно матово стъкло (Glassmorphism)';

  @override
  String get glassBlurTitle =>
      'Радиус на замъгляване на стъклото (Blur Radius)';

  @override
  String get glassOpacityTitle =>
      'Непрозрачност на стъкления контейнер (Glass Opacity)';

  @override
  String get appDisplayLanguageTitle => 'Език за показване на приложението';

  @override
  String get selectAppLanguageTitle => 'Изберете език на приложението';

  @override
  String get searchLanguageHint =>
      'Търсене на име на език или код (напр. bg, en, zh)...';

  @override
  String get designTokensPreviewTitle => 'Преглед на палитрата Design Tokens';

  @override
  String get modeCustomSeed => 'Персонализирано цветово семе (Custom Seed)';

  @override
  String get modeDynamicWallpaper => 'Автоматично извличане от динамичен тапет';

  @override
  String get modeFlexSchemePreset =>
      'Предварително зададени цветове FlexScheme';

  @override
  String get closeButton => 'Затвори';
}
