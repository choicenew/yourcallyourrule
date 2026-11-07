// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get demandSentToAi => 'Anfrage an AI-Assistenten gesendet';

  @override
  String get urlCopiedToClipboard => 'Seiten-URL in Zwischenablage kopiert';

  @override
  String get cannotOpenExternalUrl =>
      'URL kann nicht im externen Browser geöffnet werden';

  @override
  String get scanningWebTextNodes => 'Web-Textknoten werden gescannt...';

  @override
  String get noTranslatableWebNodesFound =>
      'Keine übersetzbaren Textknoten gefunden. Bitte warten Sie, bis die Seite vollständig geladen ist.';

  @override
  String get bilingualTranslationComplete =>
      'Zeilenweise zweisprachige Übersetzung abgeschlossen';

  @override
  String get failedToExtractWebText =>
      'Übersetzbare Inhalte konnten nicht aus der Webseite extrahiert werden';

  @override
  String get webDictionarySearchTitle => 'Web-Wortsuche & Wörterbuchsuche';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get search => 'Suchen';

  @override
  String get smartSelectionEnabled =>
      'Intelligentes Textauswahlblase & Aktionsleisten-Verknüpfung aktiviert';

  @override
  String get systemMenuRestored =>
      'Natives System-Langdruckmenü wiederhergestellt';

  @override
  String get copyLink => 'Link kopieren';

  @override
  String get openInSystemBrowser => 'Im Systembrowser öffnen';

  @override
  String get bilingualPageTranslation => 'Zweisprachige Seitenübersetzung';

  @override
  String get extractAndTranslateContent => 'Inhalte extrahieren & übersetzen';

  @override
  String get aiDeepAnalysisSummary => 'AI-Tiefenanalyse & Zusammenfassung';

  @override
  String get dictionaryLookup => 'Wörterbuch-Suche';

  @override
  String get shareWebPage => 'Webseite teilen';

  @override
  String get lookupWordAction => 'Nachschlagen';

  @override
  String get translateAction => 'Übersetzen';

  @override
  String get inputLookupHint =>
      'Geben Sie das englische Wort oder die Phrasen ein...';
}
