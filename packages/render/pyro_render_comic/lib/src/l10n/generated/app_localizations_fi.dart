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
  String get ocr => 'Puretaan tekstiä...';

  @override
  String get ocrExtracting => 'Puretaan tekstiä...';

  @override
  String get translate => 'Käännösvaihtoehdot';

  @override
  String get comicTranslateAi => 'Tekoälykäännös';

  @override
  String get comicTranslateEngine => 'Moottorikäännös';

  @override
  String get page => 'Sivu';

  @override
  String get pageOf => '/';

  @override
  String get stripMode => 'Jatkuva kaistale';

  @override
  String get pageMode => 'Yksi sivu';

  @override
  String get description => 'Kuvaus';

  @override
  String get shareComic => 'Jaa sarjakuva: ';
}
