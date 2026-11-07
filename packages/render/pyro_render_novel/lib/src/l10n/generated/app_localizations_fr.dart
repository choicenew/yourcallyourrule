// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get read => 'Commencer la lecture';

  @override
  String get shelf => 'Ajouter à la bibliothèque';

  @override
  String get shelfIn => 'Dans la bibliothèque';

  @override
  String get translate => 'Options de traduction';

  @override
  String get novelTranslateAi => 'Traduction IA';

  @override
  String get novelTranslateEngine => 'Traduction moteur';

  @override
  String get chapter => 'Chapitre';

  @override
  String get catalog => 'Catalogue';

  @override
  String get previousChapter => 'Précédent';

  @override
  String get nextChapter => 'Suivant';

  @override
  String get fontSize => 'Taille de police';

  @override
  String get description => 'Description';

  @override
  String get shareBook => 'Partager le livre : ';

  @override
  String get firstChapterReached => 'Déjà à la première section';

  @override
  String get lastChapterReached => 'Déjà à la dernière section';

  @override
  String get localFileLoaded => 'Document local chargé avec succès';

  @override
  String get sectionLabel => 'Section';
}
