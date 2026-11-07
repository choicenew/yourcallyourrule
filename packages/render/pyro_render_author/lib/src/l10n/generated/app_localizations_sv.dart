// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Swedish (`sv`).
class AppLocalizationsSv extends AppLocalizations {
  AppLocalizationsSv([String locale = 'sv']) : super(locale);

  @override
  String get follow => 'Följ';

  @override
  String get following => 'Följer';

  @override
  String get unfollow => 'Sluta följ';

  @override
  String get followedMessage => 'Följer författare';

  @override
  String get unfollowedMessage => 'Slutade följa författare';

  @override
  String get like => 'Gillade';

  @override
  String get liked => 'Gillade';

  @override
  String get likeAdded => 'Lades till i gillade författare';

  @override
  String get likeRemoved => 'Togs bort från gillade författare';

  @override
  String get share => 'Dela';

  @override
  String get homepage => 'Hemsida';

  @override
  String get works => 'Verk';

  @override
  String get followers => 'Följare';

  @override
  String get translate => 'Översättningsalternativ';
}
