// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get follow => 'Segui';

  @override
  String get following => 'Seguiti';

  @override
  String get unfollow => 'Smetti di seguire';

  @override
  String get followedMessage => 'Autore seguito';

  @override
  String get unfollowedMessage => 'Non segui più l\'autore';

  @override
  String get like => 'Mi piace';

  @override
  String get liked => 'Liked';

  @override
  String get likeAdded => 'Aggiunto agli autori preferiti';

  @override
  String get likeRemoved => 'Rimosso dagli autori preferiti';

  @override
  String get share => 'Condividi';

  @override
  String get homepage => 'Pagina iniziale';

  @override
  String get works => 'Opere';

  @override
  String get followers => 'Follower';

  @override
  String get translate => 'Opzioni di traduzione';
}
