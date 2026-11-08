// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get supabaseSyncTitle => 'Supabase Cloud Database Sync';

  @override
  String get projectUrlLabel => 'Supabase Project URL';

  @override
  String get projectUrlHint => 'https://xyz.supabase.co';

  @override
  String get anonKeyLabel => 'Anon / API Key';

  @override
  String get anonKeyHint => 'eyJhbGciOiJIUzI1NiIsIn...';

  @override
  String get connectionStringLabel => 'Postgres Connection String';

  @override
  String get saveConfigButton => 'Save Configuration';

  @override
  String get testConnectionButton => 'Test Connectivity';

  @override
  String get connectionSuccess => 'Supabase connection is healthy';

  @override
  String get connectionFailed => 'Failed to connect to Supabase database';
}
