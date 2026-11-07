// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Finnish (`fi`).
class AppLocalizationsFi extends AppLocalizations {
  AppLocalizationsFi([String locale = 'fi']) : super(locale);

  @override
  String get read => 'Aloita lukeminen';

  @override
  String get shelf => 'Lisää hyllylle';

  @override
  String get shelfIn => 'Hyllyssä';

  @override
  String get translate => 'Käännösvaihtoehdot';

  @override
  String get novelTranslateAi => 'Tekoälykäännös';

  @override
  String get novelTranslateEngine => 'Moottorikäännös';

  @override
  String get chapter => 'Luku';

  @override
  String get catalog => 'Sisällysluettelo';

  @override
  String get previousChapter => 'Edellinen';

  @override
  String get nextChapter => 'Seuraava';

  @override
  String get fontSize => 'Fonttikoko';

  @override
  String get description => 'Kuvaus';

  @override
  String get shareBook => 'Jaa kirja: ';

  @override
  String get firstChapterReached => 'Olet jo ensimmäisessä osassa';

  @override
  String get lastChapterReached => 'Olet jo viimeisessä osassa';

  @override
  String get localFileLoaded => 'Paikallinen asiakirja ladattu onnistuneesti';

  @override
  String get sectionLabel => 'Osio';
}
