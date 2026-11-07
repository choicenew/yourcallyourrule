// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Romanian Moldavian Moldovan (`ro`).
class AppLocalizationsRo extends AppLocalizations {
  AppLocalizationsRo([String locale = 'ro']) : super(locale);

  @override
  String get themeSettingsExpansionTitle =>
      'Setări avansate de aspect și motor de culori';

  @override
  String get selectThemeModeTitle => 'Selectează modul temei';

  @override
  String get themeAuto => 'Implicit sistem';

  @override
  String get themeLight => 'Temă deschisă';

  @override
  String get themeDark => 'Temă întunecată';

  @override
  String get dynamicColorTitle =>
      'Culoare dinamică tapet Android 12+ (Material You)';

  @override
  String get dynamicColorSubtitle =>
      'Extrageți automat culoarea tapetului de sistem ca ton principal al temei aplicației';

  @override
  String get flexSchemePresetTitle => 'Schemă de culori predefinită FlexScheme';

  @override
  String get selectFlexSchemeDialogTitle =>
      'Selectați tema de culori predefinită';

  @override
  String get pickCustomThemeColorTitle => 'Alege culoarea temei personalizate';

  @override
  String get oledTrueBlackTitle => 'Mod OLED True Black';

  @override
  String get oledTrueBlackSubtitle =>
      'Utilizați un fundal negru absolut (#000000) în modul întunecat pentru a economisi bateria';

  @override
  String get highContrastTitle => 'Îmbunătățire vizuală cu contrast ridicat';

  @override
  String get highContrastSubtitle =>
      'Creșteți contrastul textului și al marginilor pentru o accesibilitate mai bună';

  @override
  String get primarySwapTitle => 'Schimb culori Primar / Secundar';

  @override
  String get primarySwapSubtitle =>
      'Schimbați ponderea de umplere a culorii principale și secundare în UI';

  @override
  String get glassmorphismSectionTitle => 'Efecte sticlă mată (Glassmorphism)';

  @override
  String get glassBlurTitle => 'Rază estompare sticlă (Blur Radius)';

  @override
  String get glassOpacityTitle => 'Opacitate recipient sticlă (Glass Opacity)';

  @override
  String get appDisplayLanguageTitle => 'Limba de afișare a aplicației';

  @override
  String get selectAppLanguageTitle => 'Selectează limba aplicației';

  @override
  String get searchLanguageHint =>
      'Căutați numele limbii sau codul (ex. ro, en, zh)...';

  @override
  String get designTokensPreviewTitle => 'Previzualizare paletă Design Tokens';

  @override
  String get modeCustomSeed => 'Sămânță de culoare personalizată (Custom Seed)';

  @override
  String get modeDynamicWallpaper => 'Extragere automată din tapet dinamic';

  @override
  String get modeFlexSchemePreset => 'Culori predefinite FlexScheme';

  @override
  String get closeButton => 'Închide';
}
