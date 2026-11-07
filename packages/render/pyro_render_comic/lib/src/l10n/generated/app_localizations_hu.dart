// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hungarian (`hu`).
class AppLocalizationsHu extends AppLocalizations {
  AppLocalizationsHu([String locale = 'hu']) : super(locale);

  @override
  String get read => 'Olvasás kezdete';

  @override
  String get shelf => 'Hozzáadás a polchoz';

  @override
  String get shelfIn => 'Polcon';

  @override
  String get ocr => 'Kinyerés...';

  @override
  String get ocrExtracting => 'Kinyerés...';

  @override
  String get translate => 'Fordítási opciók';

  @override
  String get comicTranslateAi => 'AI fordítás';

  @override
  String get comicTranslateEngine => 'Motor fordítás';

  @override
  String get page => 'Oldal';

  @override
  String get pageOf => 'a(z)';

  @override
  String get stripMode => 'Folyamatos csík';

  @override
  String get pageMode => 'Egyes oldal';

  @override
  String get description => 'Leírás';

  @override
  String get shareComic => 'Képregény megosztása: ';
}
