// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Finnish (`fi`).
class AppLocalizationsFi extends AppLocalizations {
  AppLocalizationsFi([String locale = 'fi']) : super(locale);

  @override
  String get themeSettingsExpansionTitle =>
      'Edistyneet ulkoasu- ja värihistoria-asetukset';

  @override
  String get selectThemeModeTitle => 'Valitse teematila';

  @override
  String get themeAuto => 'Järjestelmän oletus';

  @override
  String get themeLight => 'Vaalea teema';

  @override
  String get themeDark => 'Tumma teema';

  @override
  String get dynamicColorTitle =>
      'Android 12+ dynaaminen taustakuvan väri (Material You)';

  @override
  String get dynamicColorSubtitle =>
      'Poimi järjestelmän taustakuvan väri automaattisesti sovelluksen teeman pääväriksi';

  @override
  String get flexSchemePresetTitle => 'FlexScheme-esiasetettu väriteema';

  @override
  String get selectFlexSchemeDialogTitle => 'Valitse esiasetettu väriteema';

  @override
  String get pickCustomThemeColorTitle => 'Valitse mukautettu teemaväri';

  @override
  String get oledTrueBlackTitle => 'OLED True Black -tila';

  @override
  String get oledTrueBlackSubtitle =>
      'Käytä täysin mustaa taustaa (#000000) tummassa tilassa akun säästämiseksi';

  @override
  String get highContrastTitle => 'Korkean kontrastin visuaalinen parannus';

  @override
  String get highContrastSubtitle =>
      'Lisää tekstin ja reunojen kontrastia helppokäyttöisyyden parantamiseksi';

  @override
  String get primarySwapTitle => 'Ensisijaisen / toissijaisen värin vaihto';

  @override
  String get primarySwapSubtitle =>
      'Vaihda pää- ja sivuvärin täyttöpainoa käyttöliittymässä';

  @override
  String get glassmorphismSectionTitle =>
      'Nestemäiset huurrelasiefektit (Glassmorphism)';

  @override
  String get glassBlurTitle => 'Lasin sumennussäde (Blur Radius)';

  @override
  String get glassOpacityTitle => 'Lasikontin läpinäkyvyys (Glass Opacity)';

  @override
  String get appDisplayLanguageTitle => 'Sovelluksen näyttökieli';

  @override
  String get selectAppLanguageTitle => 'Valitse sovelluksen kieli';

  @override
  String get searchLanguageHint =>
      'Hae kielen nimellä tai koodilla (esim. fi, en, zh)...';

  @override
  String get designTokensPreviewTitle =>
      'Design Tokens -väripaletin esikatselu';

  @override
  String get modeCustomSeed => 'Mukautettu siemenväri (Custom Seed)';

  @override
  String get modeDynamicWallpaper =>
      'Automaattinen poiminta dynaamisesta taustakuvasta';

  @override
  String get modeFlexSchemePreset => 'FlexScheme-esiasetetut värit';

  @override
  String get closeButton => 'Sulje';
}
