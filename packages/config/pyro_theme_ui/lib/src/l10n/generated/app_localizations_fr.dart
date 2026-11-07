// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get themeSettingsExpansionTitle =>
      'Paramètres d\'apparence avancés et moteur de couleur';

  @override
  String get selectThemeModeTitle => 'Sélectionner le mode de thème';

  @override
  String get themeAuto => 'Par défaut du système';

  @override
  String get themeLight => 'Thème clair';

  @override
  String get themeDark => 'Thème sombre';

  @override
  String get dynamicColorTitle =>
      'Couleurs dynamiques fond d\'écran (Android 12+)';

  @override
  String get dynamicColorSubtitle =>
      'Extraire automatiquement les couleurs du fond d\'écran comme thème principal';

  @override
  String get flexSchemePresetTitle => 'Thèmes prédéfinis FlexScheme';

  @override
  String get selectFlexSchemeDialogTitle => 'Sélectionner le thème de couleur';

  @override
  String get pickCustomThemeColorTitle =>
      'Choisir une couleur de thème personnalisée';

  @override
  String get oledTrueBlackTitle => 'Mode Noir Pur OLED';

  @override
  String get oledTrueBlackSubtitle =>
      'Utiliser un fond noir pur (#000000) en mode sombre pour économiser l\'énergie';

  @override
  String get highContrastTitle => 'Amélioration du contraste élevé';

  @override
  String get highContrastSubtitle =>
      'Augmenter le contraste du texte et des bordures pour une meilleure lisibilité';

  @override
  String get primarySwapTitle => 'Inverser les couleurs primaire et secondaire';

  @override
  String get primarySwapSubtitle =>
      'Échanger la priorité des couleurs primaire et secondaire dans l\'interface';

  @override
  String get glassmorphismSectionTitle => 'Effet verre dépoli (Glassmorphism)';

  @override
  String get glassBlurTitle => 'Rayon de flou du verre (Blur Radius)';

  @override
  String get glassOpacityTitle =>
      'Opacité du conteneur en verre (Glass Opacity)';

  @override
  String get appDisplayLanguageTitle => 'Langue d\'affichage de l\'application';

  @override
  String get selectAppLanguageTitle =>
      'Sélectionner la langue de l\'application';

  @override
  String get searchLanguageHint =>
      'Rechercher un nom ou un code de langue (ex. fr, en, zh)...';

  @override
  String get designTokensPreviewTitle =>
      'Aperçu de la palette de jetons de design';

  @override
  String get modeCustomSeed => 'Couleur Seed personnalisée';

  @override
  String get modeDynamicWallpaper =>
      'Extraction automatique du fond d\'écran dynamique';

  @override
  String get modeFlexSchemePreset => 'Préréglage de couleur FlexScheme';

  @override
  String get closeButton => 'Fermer';
}
