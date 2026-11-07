// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get themeSettingsExpansionTitle => 'Theme & Appearance Settings';

  @override
  String get selectThemeModeTitle => 'Select Theme Mode';

  @override
  String get themeAuto => 'System Default';

  @override
  String get themeLight => 'Light Theme';

  @override
  String get themeDark => 'Dark Theme';

  @override
  String get dynamicColorTitle => 'Android 12+ Dynamic Color';

  @override
  String get dynamicColorSubtitle =>
      'Generate Material 3 palette from system wallpaper';

  @override
  String get flexSchemePresetTitle => 'FlexScheme Palette Preset';

  @override
  String get selectFlexSchemeDialogTitle => 'Select FlexScheme Preset';

  @override
  String get pickCustomThemeColorTitle => 'Pick Custom Theme Color';

  @override
  String get oledTrueBlackTitle => 'OLED True Black Mode';

  @override
  String get oledTrueBlackSubtitle =>
      'Save battery & pure pitch-black (#000000)';

  @override
  String get highContrastTitle => 'Accessibility High Contrast';

  @override
  String get highContrastSubtitle =>
      'Enhance surface contrast ratio and card borders';

  @override
  String get primarySwapTitle => 'Primary & Secondary Swap';

  @override
  String get primarySwapSubtitle => 'Swap Primary and Secondary visual weight';

  @override
  String get glassmorphismSectionTitle => 'Liquid Glassmorphism Controls';

  @override
  String get glassBlurTitle => 'Glass Blur (BackdropFilter)';

  @override
  String get glassOpacityTitle => 'Glass Opacity';

  @override
  String get appDisplayLanguageTitle => 'App Display Language';

  @override
  String get selectAppLanguageTitle => 'Select App Language';

  @override
  String get searchLanguageHint => 'Search language or code...';

  @override
  String get designTokensPreviewTitle => 'PyroTheme Design Tokens';

  @override
  String get modeCustomSeed => 'Custom Seed Color';

  @override
  String get modeDynamicWallpaper => 'Wallpaper Dynamic Color';

  @override
  String get modeFlexSchemePreset => 'FlexScheme Presets';

  @override
  String get closeButton => 'Close';
}
