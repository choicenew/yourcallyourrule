// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get sheetTitle => 'فتح امتيازات VIP';

  @override
  String get sheetSubtitle =>
      'ترجمة غير محدودة بالذكاء الاصطناعي على الجهاز · تجربة خالية من الإعلانات تماماً · مزامنة سحابية متميزة';

  @override
  String get buyButtonText => 'اشترك الآن';

  @override
  String get watchAdButtonText => 'مشاهدة إعلان مقابل يوم واحد VIP';

  @override
  String get restoreButtonText => 'استعادة المشتريات';
}
