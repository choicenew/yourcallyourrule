// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get themeSettingsExpansionTitle =>
      'Erweiterte Erscheinungsbild- und Farb-Engine-Einstellungen';

  @override
  String get selectThemeModeTitle => 'Themenmodus auswählen';

  @override
  String get themeAuto => 'Systemstandard';

  @override
  String get themeLight => 'Helles Theme';

  @override
  String get themeDark => 'Dunkles Theme';

  @override
  String get dynamicColorTitle =>
      'Android 12+ Dynamisches Hintergrundbild-Farbschema (Material You)';

  @override
  String get dynamicColorSubtitle =>
      'Extrahiert automatisch Farben aus dem Hintergrundbild als Hauptthema';

  @override
  String get flexSchemePresetTitle => 'FlexScheme-Voreinstellungen';

  @override
  String get selectFlexSchemeDialogTitle => 'Farbschema auswählen';

  @override
  String get pickCustomThemeColorTitle =>
      'Benutzerdefinierte Themefarbe wählen';

  @override
  String get oledTrueBlackTitle => 'OLED True Black Modus';

  @override
  String get oledTrueBlackSubtitle =>
      'Verwendet rein schwarze Hintergründe (#000000) im Dunkelmodus zum Stromsparen';

  @override
  String get highContrastTitle => 'Hoher Kontrast aktivieren';

  @override
  String get highContrastSubtitle =>
      'Erhöht den Kontrast von Text und Rändern für bessere Lesbarkeit';

  @override
  String get primarySwapTitle => 'Primär- und Sekundärfarben tauschen';

  @override
  String get primarySwapSubtitle =>
      'Tauscht die Gewichtung von Primär- und Sekundärfarben in der Benutzeroberfläche';

  @override
  String get glassmorphismSectionTitle => 'Glaseffekt (Glassmorphism)';

  @override
  String get glassBlurTitle => 'Glas-Unschärferadius (Blur Radius)';

  @override
  String get glassOpacityTitle => 'Glas-Deckkraft (Glass Opacity)';

  @override
  String get appDisplayLanguageTitle => 'Sprache der Benutzeroberfläche';

  @override
  String get selectAppLanguageTitle => 'App-Sprache auswählen';

  @override
  String get searchLanguageHint =>
      'Sprachname oder Code suchen (z. B. de, en, zh)...';

  @override
  String get designTokensPreviewTitle =>
      'Vorschau der Design-Token-Farbpalette';

  @override
  String get modeCustomSeed => 'Benutzerdefinierte Seed-Farbe';

  @override
  String get modeDynamicWallpaper =>
      'Automatisch aus dynamischem Hintergrundbild extrahieren';

  @override
  String get modeFlexSchemePreset => 'FlexScheme-Farbvoreinstellung';

  @override
  String get closeButton => 'Schließen';
}
