// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get demandSentToAi => 'Demande envoyée à l\'assistant IA';

  @override
  String get urlCopiedToClipboard =>
      'URL de la page copiée dans le presse-papiers';

  @override
  String get cannotOpenExternalUrl =>
      'Impossible d\'ouvrir l\'URL dans le navigateur externe';

  @override
  String get scanningWebTextNodes => 'Analyse des nœuds de texte Web...';

  @override
  String get noTranslatableWebNodesFound =>
      'Aucun nœud de texte traduisible trouvé. Veuillez attendre le chargement complet de la page.';

  @override
  String get bilingualTranslationComplete =>
      'Traduction bilingue en ligne terminée';

  @override
  String get failedToExtractWebText =>
      'Échec de l\'extraction du contenu traduisible de la page Web';

  @override
  String get webDictionarySearchTitle =>
      'Recherche de mots Web et dictionnaire';

  @override
  String get cancel => 'Annuler';

  @override
  String get search => 'Rechercher';

  @override
  String get smartSelectionEnabled =>
      'Bulle de sélection de texte intelligente et liaison Toolbar activées';

  @override
  String get systemMenuRestored => 'Menu natif de pression longue restauré';

  @override
  String get copyLink => 'Copier le lien';

  @override
  String get openInSystemBrowser => 'Ouvrir dans le navigateur système';

  @override
  String get bilingualPageTranslation => 'Traduction bilingue de page Web';

  @override
  String get extractAndTranslateContent => 'Extraire et traduire le contenu';

  @override
  String get aiDeepAnalysisSummary => 'Analyse approfondie et résumé par l\'IA';

  @override
  String get dictionaryLookup => 'Recherche dans le dictionnaire';

  @override
  String get shareWebPage => 'Partager la page Web';

  @override
  String get lookupWordAction => 'Rechercher';

  @override
  String get translateAction => 'Traduire';

  @override
  String get inputLookupHint => 'Saisissez un mot ou une phrase en anglais...';
}
