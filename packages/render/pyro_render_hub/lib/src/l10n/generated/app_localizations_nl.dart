// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Dutch Flemish (`nl`).
class AppLocalizationsNl extends AppLocalizations {
  AppLocalizationsNl([String locale = 'nl']) : super(locale);

  @override
  String get demandSentToAi => 'Verzoek verzonden naar AI-assistent';

  @override
  String get urlCopiedToClipboard => 'Pagina-URL gekopieerd naar klembord';

  @override
  String get cannotOpenExternalUrl => 'Kan URL niet openen in externe browser';

  @override
  String get scanningWebTextNodes => 'Webtekstknooppunten scannen...';

  @override
  String get noTranslatableWebNodesFound =>
      'Geen vertaalbare tekstknooppunten gevonden. Wacht tot de pagina volledig is geladen.';

  @override
  String get bilingualTranslationComplete =>
      'Tweetalige vertaling in tekst voltooid';

  @override
  String get failedToExtractWebText =>
      'Ophalen van vertaalbare inhoud van webpagina mislukt';

  @override
  String get webDictionarySearchTitle =>
      'Woorden opzoeken en woordenboek zoeken op het web';

  @override
  String get cancel => 'Annuleren';

  @override
  String get search => 'Zoeken';

  @override
  String get smartSelectionEnabled =>
      'Slimme tekstselectie en actiebalkkoppeling ingeschakeld';

  @override
  String get systemMenuRestored => 'Systeem eigen langdrukmenu hersteld';

  @override
  String get copyLink => 'Link kopiëren';

  @override
  String get openInSystemBrowser => 'Openen in systeembroswer';

  @override
  String get bilingualPageTranslation => 'Tweetalige paginavertaling';

  @override
  String get extractAndTranslateContent => 'Inhoud uitpakken en vertalen';

  @override
  String get aiDeepAnalysisSummary => 'AI-diepgaande analyse en samenvatting';

  @override
  String get dictionaryLookup => 'Woordenboek opzoeken';

  @override
  String get shareWebPage => 'Webpagina delen';

  @override
  String get lookupWordAction => 'Opzoeken';

  @override
  String get translateAction => 'Vertalen';

  @override
  String get inputLookupHint =>
      'Voer een Engels woord of zin in om op te zoeken...';
}
