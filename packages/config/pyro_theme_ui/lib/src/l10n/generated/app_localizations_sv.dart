// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Swedish (`sv`).
class AppLocalizationsSv extends AppLocalizations {
  AppLocalizationsSv([String locale = 'sv']) : super(locale);

  @override
  String get themeSettingsExpansionTitle =>
      'Avancerade utseende- och färgmotorns inställningar';

  @override
  String get selectThemeModeTitle => 'Välj themeläge';

  @override
  String get themeAuto => 'Systemstandard';

  @override
  String get themeLight => 'Ljust tema';

  @override
  String get themeDark => 'Mörkt tema';

  @override
  String get dynamicColorTitle =>
      'Android 12+ dynamisk bakgrundsfärg (Material You)';

  @override
  String get dynamicColorSubtitle =>
      'Extrahera automatiskt systemets bakgrundsfärg som appens huvudtema';

  @override
  String get flexSchemePresetTitle => 'FlexScheme förinställd färgpalett';

  @override
  String get selectFlexSchemeDialogTitle => 'Välj förinställt färgtema';

  @override
  String get pickCustomThemeColorTitle => 'Välj anpassad temafärg';

  @override
  String get oledTrueBlackTitle => 'OLED True Black-läge';

  @override
  String get oledTrueBlackSubtitle =>
      'Använd absolut kolsvart bakgrund (#000000) i mörkt läge för att spara batteri';

  @override
  String get highContrastTitle => 'Visuell förbättring med hög kontrast';

  @override
  String get highContrastSubtitle =>
      'Öka text- och kantkontrasten för bättre tillgänglighet';

  @override
  String get primarySwapTitle => 'Primär / sekundär färgväxling';

  @override
  String get primarySwapSubtitle =>
      'Byt fyllnadsvikt för primär- och sekundärfärg i gränssnittet';

  @override
  String get glassmorphismSectionTitle =>
      'Effekter med flytande frostat glas (Glassmorphism)';

  @override
  String get glassBlurTitle => 'Glasets oskärpradie (Blur Radius)';

  @override
  String get glassOpacityTitle => 'Glasbehållarens opacitet (Glass Opacity)';

  @override
  String get appDisplayLanguageTitle => 'Appens visningsspråk';

  @override
  String get selectAppLanguageTitle => 'Välj app-språk';

  @override
  String get searchLanguageHint =>
      'Sök språknamn eller kod (t.ex. sv, en, zh)...';

  @override
  String get designTokensPreviewTitle =>
      'Förhandsgranskning av Design Tokens-palett';

  @override
  String get modeCustomSeed => 'Anpassad fröfärg (Custom Seed)';

  @override
  String get modeDynamicWallpaper => 'Automatiskt från dynamisk bakgrund';

  @override
  String get modeFlexSchemePreset => 'FlexScheme förinställda färger';

  @override
  String get closeButton => 'Stäng';
}
