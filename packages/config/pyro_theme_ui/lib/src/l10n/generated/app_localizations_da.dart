// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Danish (`da`).
class AppLocalizationsDa extends AppLocalizations {
  AppLocalizationsDa([String locale = 'da']) : super(locale);

  @override
  String get themeSettingsExpansionTitle =>
      'Avancerede udseende- og farvemotorindstillinger';

  @override
  String get selectThemeModeTitle => 'Vælg tematilstand';

  @override
  String get themeAuto => 'Systemstandard';

  @override
  String get themeLight => 'Lyst tema';

  @override
  String get themeDark => 'Mørkt tema';

  @override
  String get dynamicColorTitle =>
      'Android 12+ dynamisk baggrundsfarve (Material You)';

  @override
  String get dynamicColorSubtitle =>
      'Udtrak automatisk systembaggrundsfarven som applikationens hovedtema';

  @override
  String get flexSchemePresetTitle => 'FlexScheme forudindstillet farvetema';

  @override
  String get selectFlexSchemeDialogTitle => 'Vælg forudindstillet farvetema';

  @override
  String get pickCustomThemeColorTitle => 'Vælg tilpasset temafarve';

  @override
  String get oledTrueBlackTitle => 'OLED True Black-tilstand';

  @override
  String get oledTrueBlackSubtitle =>
      'Brug absolut kulsort baggrund (#000000) i mørk tilstand for at spare batteri';

  @override
  String get highContrastTitle => 'Visuel forbedring med høj kontrast';

  @override
  String get highContrastSubtitle =>
      'Forøg tekst- og kantkontrast for bedre tilgængelighed';

  @override
  String get primarySwapTitle => 'Ombytning af primær / sekundær farve';

  @override
  String get primarySwapSubtitle =>
      'Ombyt fyldvægten for primær- og sekundærfarve i brugerfladen';

  @override
  String get glassmorphismSectionTitle =>
      'Væskeformede frosteffekter af glas (Glassmorphism)';

  @override
  String get glassBlurTitle => 'Glas sløringsradius (Blur Radius)';

  @override
  String get glassOpacityTitle => 'Glasbeholderens opacitet (Glass Opacity)';

  @override
  String get appDisplayLanguageTitle => 'Applikationens visningssprog';

  @override
  String get selectAppLanguageTitle => 'Vælg appsprog';

  @override
  String get searchLanguageHint =>
      'Søg efter sprognavn eller kode (f.eks. da, en, zh)...';

  @override
  String get designTokensPreviewTitle =>
      'Forhåndsvisning af Design Tokens-palet';

  @override
  String get modeCustomSeed => 'Brugerdefineret frøfarve (Custom Seed)';

  @override
  String get modeDynamicWallpaper => 'Automatisk udtræk fra dynamisk baggrund';

  @override
  String get modeFlexSchemePreset => 'FlexScheme forudindstillede farver';

  @override
  String get closeButton => 'Luk';
}
