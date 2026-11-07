// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Serbian (`sr`).
class AppLocalizationsSr extends AppLocalizations {
  AppLocalizationsSr([String locale = 'sr']) : super(locale);

  @override
  String get themeSettingsExpansionTitle =>
      'Напредна подешавања изгледа и мотора боја';

  @override
  String get selectThemeModeTitle => 'Izaberi režim teme';

  @override
  String get themeAuto => 'Podrazumevano sistemu';

  @override
  String get themeLight => 'Svetla tema';

  @override
  String get themeDark => 'Tamna tema';

  @override
  String get dynamicColorTitle =>
      'Динамичка боја позадине Android 12+ (Material You)';

  @override
  String get dynamicColorSubtitle =>
      'Аутоматски извуците боју системске позадине као главни тон теме апликације';

  @override
  String get flexSchemePresetTitle => 'Предефинисана шема боја FlexScheme';

  @override
  String get selectFlexSchemeDialogTitle => 'Изаберите предефинисану тему боја';

  @override
  String get pickCustomThemeColorTitle => 'Izaberi prilagođenu boju teme';

  @override
  String get oledTrueBlackTitle => 'OLED режим праве црне';

  @override
  String get oledTrueBlackSubtitle =>
      'Користите апсолутно чисту црну позадину (#000000) у тамном режиму ради уштеде батерије';

  @override
  String get highContrastTitle => 'Визуелно побољшање висог контраста';

  @override
  String get highContrastSubtitle =>
      'Повећајте контраст текста и ивица ради боље приступачности';

  @override
  String get primarySwapTitle => 'Замена примарне / секундарне боје';

  @override
  String get primarySwapSubtitle =>
      'Промените тежину попуњавања главне и секундарне боје у интерфејсу';

  @override
  String get glassmorphismSectionTitle =>
      'Ефекти гламурозног стакла (Glassmorphism)';

  @override
  String get glassBlurTitle => 'Полупречник замућења стакла (Blur Radius)';

  @override
  String get glassOpacityTitle =>
      'Провидност стакленог контејнера (Glass Opacity)';

  @override
  String get appDisplayLanguageTitle => 'Језик приказа апликације';

  @override
  String get selectAppLanguageTitle => 'Izaberi jezik aplikacije';

  @override
  String get searchLanguageHint =>
      'Претражите назив језика или код (нпр. sr, en, zh)...';

  @override
  String get designTokensPreviewTitle => 'Преглед палете Design Tokens';

  @override
  String get modeCustomSeed => 'Прилагођено семе боје (Custom Seed)';

  @override
  String get modeDynamicWallpaper =>
      'Аутоматско извлачење из динамичке позадине';

  @override
  String get modeFlexSchemePreset => 'FlexScheme предефинисане боје';

  @override
  String get closeButton => 'Zatvori';
}
