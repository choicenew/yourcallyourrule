// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Norwegian Bokmål (`nb`).
class AppLocalizationsNb extends AppLocalizations {
  AppLocalizationsNb([String locale = 'nb']) : super(locale);

  @override
  String get sheetTitle => 'Lås opp VIP-privilegier';

  @override
  String get sheetSubtitle =>
      'Ubegrenset Edge AI-oversettelse · Helt ren og annonsefri · Skysynkronisering i høy oppløsning';

  @override
  String get buyButtonText => 'Kjøp nå';

  @override
  String get watchAdButtonText => 'Se annonse for 1 dag VIP';

  @override
  String get restoreButtonText => 'Gjenopprett kjøp';
}
