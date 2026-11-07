// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Lithuanian (`lt`).
class AppLocalizationsLt extends AppLocalizations {
  AppLocalizationsLt([String locale = 'lt']) : super(locale);

  @override
  String get read => 'Pradėti skaityti';

  @override
  String get shelf => 'Pridėti į lentyną';

  @override
  String get shelfIn => 'Lentynoje';

  @override
  String get ocr => 'Ištraukiamas tekstas...';

  @override
  String get ocrExtracting => 'Ištraukiama...';

  @override
  String get translate => 'Vertimo parinktys';

  @override
  String get comicTranslateAi => 'AI vertimas';

  @override
  String get comicTranslateEngine => 'Variklio vertimas';

  @override
  String get page => 'Puslapis';

  @override
  String get pageOf => 'iš';

  @override
  String get stripMode => 'Nepertraukiama juosta';

  @override
  String get pageMode => 'Vieno puslapio';

  @override
  String get description => 'Aprašymas';

  @override
  String get shareComic => 'Bendrinti komiksą: ';
}
