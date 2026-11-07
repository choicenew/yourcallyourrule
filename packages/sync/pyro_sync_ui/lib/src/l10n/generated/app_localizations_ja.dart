// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get syncSettingsTitle => 'Cloud Synchronization Settings';

  @override
  String get syncStatusIdle => 'All data synchronized';

  @override
  String get syncStatusSyncing => 'Synchronizing database...';

  @override
  String get syncNowLabel => 'Sync Now';

  @override
  String get mountedProvidersSectionTitle => 'Mounted Sync Providers';

  @override
  String get testConnectivity => 'Test Connectivity';

  @override
  String get connectionSuccess => 'Network connectivity passed!';

  @override
  String get connectionFailed =>
      'Connection failed, please check configuration';
}
