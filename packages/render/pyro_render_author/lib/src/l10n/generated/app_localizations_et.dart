// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Estonian (`et`).
class AppLocalizationsEt extends AppLocalizations {
  AppLocalizationsEt([String locale = 'et']) : super(locale);

  @override
  String get follow => 'Jälgi';

  @override
  String get following => 'Jälgitav';

  @override
  String get unfollow => 'Lõpeta jälgimine';

  @override
  String get followedMessage => 'Autor hakatud jälgima';

  @override
  String get unfollowedMessage => 'Autori jälgimine lõpetatud';

  @override
  String get like => 'Meeldib';

  @override
  String get liked => 'Meeldib';

  @override
  String get likeAdded => 'Lisatud meeldivate autorite hulka';

  @override
  String get likeRemoved => 'Eemaldatud meeldivate autorite hulgast';

  @override
  String get share => 'Jaga';

  @override
  String get homepage => 'Avaleht';

  @override
  String get works => 'Teosed';

  @override
  String get followers => 'Jälgijad';

  @override
  String get translate => 'Tõlkevalikud';
}
