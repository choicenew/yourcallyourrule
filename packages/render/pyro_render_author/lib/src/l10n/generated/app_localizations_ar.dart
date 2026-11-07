// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get follow => 'متابعة';

  @override
  String get following => 'تتم المتابعة';

  @override
  String get unfollow => 'إلغاء المتابعة';

  @override
  String get followedMessage => 'تم متابعة المؤلف';

  @override
  String get unfollowedMessage => 'تم إلغاء متابعة المؤلف';

  @override
  String get like => 'معجب';

  @override
  String get liked => 'معجب';

  @override
  String get likeAdded => 'تم الإضافة إلى المؤلفين المعجب بهم';

  @override
  String get likeRemoved => 'تم الإزالة من المؤلفين المعجب بهم';

  @override
  String get share => 'مشاركة';

  @override
  String get homepage => 'الصفحة الرئيسية';

  @override
  String get works => 'الأعمال';

  @override
  String get followers => 'المتابعون';

  @override
  String get translate => 'خيارات الترجمة';
}
