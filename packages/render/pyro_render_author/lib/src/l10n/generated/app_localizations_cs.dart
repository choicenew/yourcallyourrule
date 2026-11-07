// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Czech (`cs`).
class AppLocalizationsCs extends AppLocalizations {
  AppLocalizationsCs([String locale = 'cs']) : super(locale);

  @override
  String get follow => 'Sledovat';

  @override
  String get following => 'Sleduji';

  @override
  String get unfollow => 'Zrušit sledování';

  @override
  String get followedMessage => 'Sleduje autora';

  @override
  String get unfollowedMessage => 'Zrušeno sledování autora';

  @override
  String get like => 'Líbí se';

  @override
  String get liked => 'Líbí se';

  @override
  String get likeAdded => 'Přidáno do oblíbených autorů';

  @override
  String get likeRemoved => 'Odebráno z oblíbených autorů';

  @override
  String get share => 'Sdílet';

  @override
  String get homepage => 'Domovská stránka';

  @override
  String get works => 'Díla';

  @override
  String get followers => 'Sledující';

  @override
  String get translate => 'Možnosti překladu';
}
