// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Thai (`th`).
class AppLocalizationsTh extends AppLocalizations {
  AppLocalizationsTh([String locale = 'th']) : super(locale);

  @override
  String get syncSettingsTitle => 'Cloud Synchronization Settings';

  @override
  String get syncStatusIdle => 'All data synchronized';

  @override
  String get syncStatusSyncing => 'Synchronizing database...';

  @override
  String get syncNowLabel => 'Sync Now';
}
