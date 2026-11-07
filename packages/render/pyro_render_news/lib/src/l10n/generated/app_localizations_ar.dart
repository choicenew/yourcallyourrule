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
  String get share => 'مشاركة';

  @override
  String get ocr => 'جاري الاستخراج...';

  @override
  String get ocrExtracting => 'جاري الاستخراج...';

  @override
  String get translate => 'خيارات الترجمة';

  @override
  String get newsTranslateAi => 'ترجمة الذكاء الاصطناعي';

  @override
  String get newsTranslateEngine => 'ترجمة المحرك';

  @override
  String get source => 'المصدر';

  @override
  String get publishTime => 'تاريخ النشر';

  @override
  String get copiedLink => 'تم نسخ رابط المقالة إلى الحافظة';

  @override
  String get description => 'الوصف';

  @override
  String get shareNews => 'مشاركة المقالة: ';
}
