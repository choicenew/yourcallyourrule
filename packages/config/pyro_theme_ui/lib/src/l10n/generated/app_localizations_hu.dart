// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hungarian (`hu`).
class AppLocalizationsHu extends AppLocalizations {
  AppLocalizationsHu([String locale = 'hu']) : super(locale);

  @override
  String get themeSettingsExpansionTitle =>
      'Speciális megjelenés és színmotor beállítások';

  @override
  String get selectThemeModeTitle => 'Téma mód kiválasztása';

  @override
  String get themeAuto => 'Rendszer alapértelmezett';

  @override
  String get themeLight => 'Világos téma';

  @override
  String get themeDark => 'Sötét téma';

  @override
  String get dynamicColorTitle =>
      'Android 12+ dinamikus háttérkép színe (Material You)';

  @override
  String get dynamicColorSubtitle =>
      'A rendszer háttérképének színének automatikus kinyerése az alkalmazás téma fő tónusaként';

  @override
  String get flexSchemePresetTitle => 'FlexScheme előre beállított színséma';

  @override
  String get selectFlexSchemeDialogTitle =>
      'Válasszon előre beállított színtémát';

  @override
  String get pickCustomThemeColorTitle => 'Egyéni témaszín kiválasztása';

  @override
  String get oledTrueBlackTitle => 'OLED True Black mód';

  @override
  String get oledTrueBlackSubtitle =>
      'Használjon teljesen tiszta fekete háttérképet (#000000) sötét módban az akkumulátor kímélése érdekében';

  @override
  String get highContrastTitle => 'Nagy kontrasztú vizuális javítás';

  @override
  String get highContrastSubtitle =>
      'Növelje a szöveg és a keret kontrasztját a jobb akadálymentesség érdekében';

  @override
  String get primarySwapTitle => 'Elsődleges / másodlagos színcsere';

  @override
  String get primarySwapSubtitle =>
      'Cserélje fel a fő és másodlagos szín kitöltési súlyát a felhasználói felületen';

  @override
  String get glassmorphismSectionTitle =>
      'Folyékony matt üveg hatások (Glassmorphism)';

  @override
  String get glassBlurTitle => 'Üveg elmosódási sugár (Blur Radius)';

  @override
  String get glassOpacityTitle => 'Üveg tároló átlátszósága (Glass Opacity)';

  @override
  String get appDisplayLanguageTitle => 'Alkalmazás megjelenítési nyelve';

  @override
  String get selectAppLanguageTitle => 'Alkalmazás nyelvének kiválasztása';

  @override
  String get searchLanguageHint =>
      'Keresés nyelvnév vagy kód alapján (pl. hu, en, zh)...';

  @override
  String get designTokensPreviewTitle => 'Design Tokens színpaletta előnézete';

  @override
  String get modeCustomSeed => 'Egyéni Seed színmag (Custom Seed)';

  @override
  String get modeDynamicWallpaper =>
      'Automatikus kinyerés dinamikus háttérképből';

  @override
  String get modeFlexSchemePreset => 'FlexScheme előre beállított színek';

  @override
  String get closeButton => 'Bezárás';
}
