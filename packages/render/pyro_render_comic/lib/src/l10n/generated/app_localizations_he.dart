// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hebrew (`he`).
class AppLocalizationsHe extends AppLocalizations {
  AppLocalizationsHe([String locale = 'he']) : super(locale);

  @override
  String get read => 'התחל לקרוא';

  @override
  String get shelf => 'הוסף למדף';

  @override
  String get shelfIn => 'במדף';

  @override
  String get ocr => 'מחלץ טקסט...';

  @override
  String get ocrExtracting => 'מחלץ...';

  @override
  String get translate => 'אפשרויות תרגום';

  @override
  String get comicTranslateAi => 'תרגום AI';

  @override
  String get comicTranslateEngine => 'תרגום מנוע';

  @override
  String get page => 'עמוד';

  @override
  String get pageOf => 'מתוך';

  @override
  String get stripMode => 'רצועה רציפה';

  @override
  String get pageMode => 'עמוד בודד';

  @override
  String get description => 'תיאור';

  @override
  String get shareComic => 'שיתוף קומיקס: ';
}
