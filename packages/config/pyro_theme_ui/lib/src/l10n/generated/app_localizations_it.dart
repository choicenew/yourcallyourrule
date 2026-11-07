// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get themeSettingsExpansionTitle =>
      'Impostazioni avanzate aspetto e motore colori';

  @override
  String get selectThemeModeTitle => 'Seleziona modalità tema';

  @override
  String get themeAuto => 'Predefinito di sistema';

  @override
  String get themeLight => 'Tema chiaro';

  @override
  String get themeDark => 'Tema scuro';

  @override
  String get dynamicColorTitle =>
      'Colore dinamico sfondo Android 12+ (Material You)';

  @override
  String get dynamicColorSubtitle =>
      'Estrai automaticamente il colore dello sfondo di sistema come tono principale del tema';

  @override
  String get flexSchemePresetTitle => 'Schema colori preimpostato FlexScheme';

  @override
  String get selectFlexSchemeDialogTitle =>
      'Seleziona tema colore preimpostato';

  @override
  String get pickCustomThemeColorTitle => 'Scegli colore tema personalizzato';

  @override
  String get oledTrueBlackTitle => 'Modalità OLED Nero Puro';

  @override
  String get oledTrueBlackSubtitle =>
      'Usa uno sfondo nero assoluto (#000000) in modalità scura per risparmiare batteria';

  @override
  String get highContrastTitle => 'Miglioramento visivo ad alto contrasto';

  @override
  String get highContrastSubtitle =>
      'Aumenta il contrasto del testo e dei bordi per una migliore accessibilità';

  @override
  String get primarySwapTitle => 'Scambio colore Primario / Secondario';

  @override
  String get primarySwapSubtitle =>
      'Scambia il peso di riempimento del colore principale e secondario nell\'interfaccia';

  @override
  String get glassmorphismSectionTitle =>
      'Effetti vetro smerigliato liquido (Glassmorphism)';

  @override
  String get glassBlurTitle => 'Raggio sfocatura vetro (Blur Radius)';

  @override
  String get glassOpacityTitle =>
      'Opacità contenitore in vetro (Glass Opacity)';

  @override
  String get appDisplayLanguageTitle => 'Lingua di visualizzazione dell\'app';

  @override
  String get selectAppLanguageTitle => 'Seleziona lingua dell\'app';

  @override
  String get searchLanguageHint =>
      'Cerca nome lingua o codice (es. it, en, zh)...';

  @override
  String get designTokensPreviewTitle => 'Anteprima tavolozza Design Tokens';

  @override
  String get modeCustomSeed => 'Seme colore personalizzato (Custom Seed)';

  @override
  String get modeDynamicWallpaper => 'Estrazione automatica da sfondo dinamico';

  @override
  String get modeFlexSchemePreset => 'Colori preimpostati FlexScheme';

  @override
  String get closeButton => 'Chiudi';
}
