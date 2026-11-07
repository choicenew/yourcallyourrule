// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hungarian (`hu`).
class AppLocalizationsHu extends AppLocalizations {
  AppLocalizationsHu([String locale = 'hu']) : super(locale);

  @override
  String get follow => 'Követés';

  @override
  String get following => 'Követve';

  @override
  String get unfollow => 'Követés leállítása';

  @override
  String get followedMessage => 'Szerző követve';

  @override
  String get unfollowedMessage => 'Szerző követése leállítva';

  @override
  String get like => 'Kedvelve';

  @override
  String get liked => 'Kedvelve';

  @override
  String get likeAdded => 'Hozzáadva a kedvelt szerzőkhöz';

  @override
  String get likeRemoved => 'Eltávolítva a kedvelt szerzőktől';

  @override
  String get share => 'Megosztás';

  @override
  String get homepage => 'Kezdőlap';

  @override
  String get works => 'Művek';

  @override
  String get followers => 'Követők';

  @override
  String get translate => 'Fordítási opciók';
}
