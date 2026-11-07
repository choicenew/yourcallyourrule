// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Catalan Valencian (`ca`).
class AppLocalizationsCa extends AppLocalizations {
  AppLocalizationsCa([String locale = 'ca']) : super(locale);

  @override
  String get themeSettingsExpansionTitle =>
      'Configuració avançada d\'aparença i motor de color';

  @override
  String get selectThemeModeTitle => 'Seleccionar el mode de tema';

  @override
  String get themeAuto => 'Predeterminat del sistema';

  @override
  String get themeLight => 'Tema clar';

  @override
  String get themeDark => 'Tema fosc';

  @override
  String get dynamicColorTitle =>
      'Color dinàmic del fons de pantalla Android 12+ (Material You)';

  @override
  String get dynamicColorSubtitle =>
      'Extreu automàticament el color del fons de pantalla del sistema com a to principal del tema';

  @override
  String get flexSchemePresetTitle =>
      'Esquema de colors predeterminat FlexScheme';

  @override
  String get selectFlexSchemeDialogTitle =>
      'Selecciona el tema de color predeterminat';

  @override
  String get pickCustomThemeColorTitle => 'Tria un color de tema personalitzat';

  @override
  String get oledTrueBlackTitle => 'Mode OLED True Black';

  @override
  String get oledTrueBlackSubtitle =>
      'Utilitza un fons negre absolut (#000000) en mode fosc per estalviar bateria';

  @override
  String get highContrastTitle => 'Millora visual d\'alt contrast';

  @override
  String get highContrastSubtitle =>
      'Augmenta el contrast del text i les vores per a una millor accessibilitat';

  @override
  String get primarySwapTitle => 'Intercanvi de color primari / secundari';

  @override
  String get primarySwapSubtitle =>
      'Canvia el pes d\'ompliment del color principal i secundari a la interfície';

  @override
  String get glassmorphismSectionTitle =>
      'Efectes de vidre esmerilat líquid (Glassmorphism)';

  @override
  String get glassBlurTitle => 'Radi de difuminat del vidre (Blur Radius)';

  @override
  String get glassOpacityTitle =>
      'Opacitat del contenidor de vidre (Glass Opacity)';

  @override
  String get appDisplayLanguageTitle =>
      'Idioma de visualització de l\'aplicació';

  @override
  String get selectAppLanguageTitle => 'Seleccionar l\'idioma de l\'aplicació';

  @override
  String get searchLanguageHint =>
      'Cerca el nom de l\'idioma o el codi (p. ex. ca, en, zh)...';

  @override
  String get designTokensPreviewTitle =>
      'Vista prèvia de la paleta Design Tokens';

  @override
  String get modeCustomSeed => 'Llavors de color personalitzades (Custom Seed)';

  @override
  String get modeDynamicWallpaper =>
      'Extracció automàtica del fons de pantalla dinàmic';

  @override
  String get modeFlexSchemePreset => 'Colors predeterminats FlexScheme';

  @override
  String get closeButton => 'Tancar';
}
