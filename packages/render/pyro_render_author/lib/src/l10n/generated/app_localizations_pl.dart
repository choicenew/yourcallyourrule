// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Polish (`pl`).
class AppLocalizationsPl extends AppLocalizations {
  AppLocalizationsPl([String locale = 'pl']) : super(locale);

  @override
  String get follow => 'Obserwuj';

  @override
  String get following => 'Obserwowani';

  @override
  String get unfollow => 'Przestań obserwować';

  @override
  String get followedMessage => 'Zaobserwowano autora';

  @override
  String get unfollowedMessage => 'Przestano obserwować autora';

  @override
  String get like => 'Polubione';

  @override
  String get liked => 'Polubione';

  @override
  String get likeAdded => 'Dodano do polubionych autorów';

  @override
  String get likeRemoved => 'Usunięto z polubionych autorów';

  @override
  String get share => 'Udostępnij';

  @override
  String get homepage => 'Strona główna';

  @override
  String get works => 'Prace';

  @override
  String get followers => 'Obserwujący';

  @override
  String get translate => 'Opcje tłumaczenia';
}
