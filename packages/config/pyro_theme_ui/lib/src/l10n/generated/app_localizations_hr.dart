// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Croatian (`hr`).
class AppLocalizationsHr extends AppLocalizations {
  AppLocalizationsHr([String locale = 'hr']) : super(locale);

  @override
  String get themeSettingsExpansionTitle =>
      'Napredne postavke izgleda i mehanizma boja';

  @override
  String get selectThemeModeTitle => 'Odaberi režim teme';

  @override
  String get themeAuto => 'Zadano sustavom';

  @override
  String get themeLight => 'Svijetla tema';

  @override
  String get themeDark => 'Tamna tema';

  @override
  String get dynamicColorTitle =>
      'Dinamička boja pozadine Android 12+ (Material You)';

  @override
  String get dynamicColorSubtitle =>
      'Automatski izdvojite boju sistemske pozadine kao glavni ton teme aplikacije';

  @override
  String get flexSchemePresetTitle => 'Zadana shema boja FlexScheme';

  @override
  String get selectFlexSchemeDialogTitle =>
      'Odaberite unaprijed postavljenu temu boja';

  @override
  String get pickCustomThemeColorTitle => 'Odaberi prilagođenu boju teme';

  @override
  String get oledTrueBlackTitle => 'OLED True Black način rada';

  @override
  String get oledTrueBlackSubtitle =>
      'Koristite apsolutno čistu crnu pozadinu (#000000) u tamnom načinu rada radi uštede baterije';

  @override
  String get highContrastTitle => 'Vizualno poboljšanje s visokim kontrastom';

  @override
  String get highContrastSubtitle =>
      'Povećajte kontrast teksta i rubova radi bolje pristupačnosti';

  @override
  String get primarySwapTitle => 'Zamjena primarne / sekundarne boje';

  @override
  String get primarySwapSubtitle =>
      'Promijenite težinu popunjavanja glavne i sekundarne boje u sučelju';

  @override
  String get glassmorphismSectionTitle =>
      'Efekti mutnog stakla (Glassmorphism)';

  @override
  String get glassBlurTitle => 'Polumjer zamućenja stakla (Blur Radius)';

  @override
  String get glassOpacityTitle =>
      'Prozirnost staklenog spremnika (Glass Opacity)';

  @override
  String get appDisplayLanguageTitle => 'Jezik prikaza aplikacije';

  @override
  String get selectAppLanguageTitle => 'Odaberi jezik aplikacije';

  @override
  String get searchLanguageHint =>
      'Pretražite naziv jezika ili kod (npr. hr, en, zh)...';

  @override
  String get designTokensPreviewTitle => 'Pregled palete Design Tokens';

  @override
  String get modeCustomSeed => 'Prilagođeno sjeme boja (Custom Seed)';

  @override
  String get modeDynamicWallpaper =>
      'Automatsko izvlačenje iz dinamičke pozadine';

  @override
  String get modeFlexSchemePreset => 'FlexScheme zadane boje';

  @override
  String get closeButton => 'Zatvori';
}
