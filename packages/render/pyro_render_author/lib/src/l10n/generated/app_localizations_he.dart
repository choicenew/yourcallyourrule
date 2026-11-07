// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hebrew (`he`).
class AppLocalizationsHe extends AppLocalizations {
  AppLocalizationsHe([String locale = 'he']) : super(locale);

  @override
  String get follow => 'עקוב';

  @override
  String get following => 'נעקב';

  @override
  String get unfollow => 'הפסק מעקב';

  @override
  String get followedMessage => 'המחבר נעקב';

  @override
  String get unfollowedMessage => 'הפסיק לעקוב אחרי המחבר';

  @override
  String get like => 'אהבתי';

  @override
  String get liked => 'אהבתי';

  @override
  String get likeAdded => 'נוסף למחברים האהובים';

  @override
  String get likeRemoved => 'הוסר מהמחברים האהובים';

  @override
  String get share => 'שיתוף';

  @override
  String get homepage => 'דף הבית';

  @override
  String get works => 'יצירות';

  @override
  String get followers => 'עוקבים';

  @override
  String get translate => 'אפשרויות תרגום';
}
