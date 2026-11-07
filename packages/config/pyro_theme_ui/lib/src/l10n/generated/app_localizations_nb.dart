// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Norwegian Bokmål (`nb`).
class AppLocalizationsNb extends AppLocalizations {
  AppLocalizationsNb([String locale = 'nb']) : super(locale);

  @override
  String get themeSettingsExpansionTitle =>
      'Avanserte utseende- og fargemotorinnstillinger';

  @override
  String get selectThemeModeTitle => 'Velg temamodus';

  @override
  String get themeAuto => 'Systemstandard';

  @override
  String get themeLight => 'Lys tema';

  @override
  String get themeDark => 'Mørk tema';

  @override
  String get dynamicColorTitle =>
      'Android 12+ Dynamiske bakgrunnsfarger (Material You)';

  @override
  String get dynamicColorSubtitle =>
      'Hent automatisk ut farger fra bakgrunnsbildet som hovedtema';

  @override
  String get flexSchemePresetTitle =>
      'FlexScheme forhåndsinnstilte fargetemaer';

  @override
  String get selectFlexSchemeDialogTitle => 'Velg fargetema';

  @override
  String get pickCustomThemeColorTitle => 'Velg tilpasset temafarge';

  @override
  String get oledTrueBlackTitle => 'OLED True Black Modus';

  @override
  String get oledTrueBlackSubtitle =>
      'Bruk helt svart bakgrunn (#000000) i mørk modus for å spare strøm';

  @override
  String get highContrastTitle => 'Høy kontrastforbedring';

  @override
  String get highContrastSubtitle =>
      'Øk kontrasten på tekst og kanter for bedre lesbarhet';

  @override
  String get primarySwapTitle => 'Bytt primær- og sekundærfarger';

  @override
  String get primarySwapSubtitle =>
      'Bytt vektlegging av primær- og sekundærfarger i grensesnittet';

  @override
  String get glassmorphismSectionTitle => 'Glasseffekt (Glassmorphism)';

  @override
  String get glassBlurTitle => 'Glassuskarphetsradius (Blur Radius)';

  @override
  String get glassOpacityTitle => 'Glassbeholderens opasitet (Glass Opacity)';

  @override
  String get appDisplayLanguageTitle => 'Appens visningsspråk';

  @override
  String get selectAppLanguageTitle => 'Velg app-språk';

  @override
  String get searchLanguageHint =>
      'Søk etter språknavn eller kode (f.eks. nb, en, zh)...';

  @override
  String get designTokensPreviewTitle =>
      'Forhåndsvisning av designtoken-fargepalett';

  @override
  String get modeCustomSeed => 'Egendefinert Seed-farge';

  @override
  String get modeDynamicWallpaper =>
      'Automatisk uthenting fra dynamisk bakgrunn';

  @override
  String get modeFlexSchemePreset => 'FlexScheme forhåndsinnstilt farge';

  @override
  String get closeButton => 'Lukk';
}
