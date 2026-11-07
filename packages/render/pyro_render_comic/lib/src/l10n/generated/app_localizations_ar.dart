// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get read => 'بدء القراءة';

  @override
  String get shelf => 'إضافة إلى الرف';

  @override
  String get shelfIn => 'على الرف';

  @override
  String get ocr => 'جاري الاستخراج...';

  @override
  String get ocrExtracting => 'جاري الاستخراج...';

  @override
  String get translate => 'خيارات الترجمة';

  @override
  String get comicTranslateAi => 'ترجمة الذكاء الاصطناعي';

  @override
  String get comicTranslateEngine => 'ترجمة المحرك';

  @override
  String get page => 'الصفحة';

  @override
  String get pageOf => 'من';

  @override
  String get stripMode => 'شريط مستمر';

  @override
  String get pageMode => 'صفحة واحدة';

  @override
  String get description => 'الوصف';

  @override
  String get shareComic => 'مشاركة القصص المصورة: ';
}
