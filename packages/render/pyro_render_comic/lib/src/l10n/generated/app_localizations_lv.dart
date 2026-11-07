// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Latvian (`lv`).
class AppLocalizationsLv extends AppLocalizations {
  AppLocalizationsLv([String locale = 'lv']) : super(locale);

  @override
  String get read => 'Sākt lasīt';

  @override
  String get shelf => 'Pievienot plauktam';

  @override
  String get shelfIn => 'Plauktā';

  @override
  String get ocr => 'Izgūst tekstu...';

  @override
  String get ocrExtracting => 'Izgūst...';

  @override
  String get translate => 'Tulkošanas opcijas';

  @override
  String get comicTranslateAi => 'AI tulkošana';

  @override
  String get comicTranslateEngine => 'Dzinēja tulkošana';

  @override
  String get page => 'Lapa';

  @override
  String get pageOf => 'no';

  @override
  String get stripMode => 'Nepārtraukta josla';

  @override
  String get pageMode => 'Viena lapa';

  @override
  String get description => 'Apraksts';

  @override
  String get shareComic => 'Kopīgot komiksu: ';
}
