// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Estonian (`et`).
class AppLocalizationsEt extends AppLocalizations {
  AppLocalizationsEt([String locale = 'et']) : super(locale);

  @override
  String get sheetTitle => 'Ava VIP-privileegid';

  @override
  String get sheetSubtitle =>
      'Piiramatu serva AI tõlge · Täielikult puhas ja reklaamita · Pilvesünkroonimine';

  @override
  String get buyButtonText => 'Telli kohe';

  @override
  String get watchAdButtonText => 'Vaata reklaami 1 päeva VIP saamiseks';

  @override
  String get restoreButtonText => 'Taasta ostud';
}
