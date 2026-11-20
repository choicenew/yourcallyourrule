// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hungarian (`hu`).
class AppLocalizationsHu extends AppLocalizations {
  AppLocalizationsHu([String locale = 'hu']) : super(locale);

  @override
  String get sheetTitle => 'VIP exkluzív előnyök feloldása';

  @override
  String get sheetSubtitle =>
      'Korlátlan helyi AI fordítás · Teljesen hirdetésmentes · Kiváló minőségű felhő szinkronizálás';

  @override
  String get buyButtonText => 'Előfizetés most';

  @override
  String get watchAdButtonText => 'Hirdetés megtekintése 1 nap VIP-ért';

  @override
  String get restoreButtonText => 'Vásárlások visszaállítása';
}
