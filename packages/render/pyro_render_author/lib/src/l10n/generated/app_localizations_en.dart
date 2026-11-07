// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get follow => 'Follow';

  @override
  String get following => 'Following';

  @override
  String get unfollow => 'Unfollow';

  @override
  String get followedMessage => 'Followed author';

  @override
  String get unfollowedMessage => 'Unfollowed author';

  @override
  String get like => 'Liked';

  @override
  String get liked => 'Liked';

  @override
  String get likeAdded => 'Added to liked authors';

  @override
  String get likeRemoved => 'Removed from liked authors';

  @override
  String get share => 'Share';

  @override
  String get homepage => 'Homepage';

  @override
  String get works => 'Works';

  @override
  String get followers => 'Followers';

  @override
  String get translate => 'Translate';
}
