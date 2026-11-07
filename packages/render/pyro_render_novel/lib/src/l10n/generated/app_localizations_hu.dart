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
  String get translate => 'Fordítási opciók';

  @override
  String get novelTranslateAi => 'AI fordítás';

  @override
  String get novelTranslateEngine => 'Motor fordítás';

  @override
  String get chapter => 'Fejezet';

  @override
  String get catalog => 'Katalógus';

  @override
  String get previousChapter => 'Előző';

  @override
  String get nextChapter => 'Következő';

  @override
  String get fontSize => 'Betűméret';

  @override
  String get description => 'Leírás';

  @override
  String get shareBook => 'Könyv megosztása: ';

  @override
  String get firstChapterReached => 'Már az első szakaszban vagy';

  @override
  String get lastChapterReached => 'Már az utolsó szakaszban vagy';

  @override
  String get localFileLoaded => 'Helyi dokumentum sikeresen betöltve';

  @override
  String get sectionLabel => 'Szakasz';
}
