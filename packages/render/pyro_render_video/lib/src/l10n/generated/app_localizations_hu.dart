// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hungarian (`hu`).
class AppLocalizationsHu extends AppLocalizations {
  AppLocalizationsHu([String locale = 'hu']) : super(locale);

  @override
  String get play => 'Videó lejátszása';

  @override
  String get download => 'Letöltés';

  @override
  String get downloading => 'Letöltés...';

  @override
  String get like => 'Kedvelve';

  @override
  String get liked => 'Kedvelve';

  @override
  String get pause => 'Szünet';

  @override
  String get replay => 'Újrajátszás';

  @override
  String get speed => 'Sebesség';

  @override
  String get quality => 'Minőség';

  @override
  String get share => 'Megosztás';

  @override
  String get description => 'Leírás';

  @override
  String get shareVideo => 'Videó megosztása: ';
}
