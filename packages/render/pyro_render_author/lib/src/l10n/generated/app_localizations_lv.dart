// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Latvian (`lv`).
class AppLocalizationsLv extends AppLocalizations {
  AppLocalizationsLv([String locale = 'lv']) : super(locale);

  @override
  String get follow => 'Sekot';

  @override
  String get following => 'Seko';

  @override
  String get unfollow => 'Pārtraukt sekošanu';

  @override
  String get followedMessage => 'Autors sākts sekot';

  @override
  String get unfollowedMessage => 'Autors vairs netiek sekots';

  @override
  String get like => 'Patīk';

  @override
  String get liked => 'Patīk';

  @override
  String get likeAdded => 'Pievienots iecienītajiem autoriem';

  @override
  String get likeRemoved => 'Noņemts no iecienītajiem autoriem';

  @override
  String get share => 'Kopīgot';

  @override
  String get homepage => 'Sākumlapa';

  @override
  String get works => 'Darbi';

  @override
  String get followers => 'Sekotāji';

  @override
  String get translate => 'Tulkošanas opcijas';
}
