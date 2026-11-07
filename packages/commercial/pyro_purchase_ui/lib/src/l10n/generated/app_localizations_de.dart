// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get sheetTitle => 'VIP-Privilegien freischalten';

  @override
  String get sheetSubtitle =>
      'Unbegrenzte LLM-Übersetzung · Völlig werbefrei · Hochpräzise Cloud-Synchronisierung';

  @override
  String get buyButtonText => 'Jetzt aktivieren';

  @override
  String get watchAdButtonText => 'Werbung für 1 Tag VIP ansehen';

  @override
  String get restoreButtonText => 'Käufe wiederherstellen';
}
