// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Malayalam (`ml`).
class AppLocalizationsMl extends AppLocalizations {
  AppLocalizationsMl([String locale = 'ml']) : super(locale);

  @override
  String get cloudSettingsTitle => 'ക്ലൗഡ് & സിങ്ക് ക്രമീകരണങ്ങൾ';

  @override
  String get encryptionTitle => 'എൻഡ്-ടു-എൻഡ് എൻക്രിപ്ഷൻ (E2EE)';

  @override
  String get encryptionSubtitle =>
      'അപ്‌ലോഡ് ചെയ്യുന്നതിന് മുമ്പ് എല്ലാ ബാക്കപ്പുകളും AES-256 ഉപയോഗിച്ച് എൻക്രിപ്റ്റ് ചെയ്യുക';

  @override
  String get encryptionEnabled => 'സജീവമാക്കി (AES-256)';

  @override
  String get encryptionDisabled => 'പ്രവർത്തനരഹിതമാക്കി';

  @override
  String get configuredDrives => 'കോൺഫിഗർ ചെയ്ത ക്ലൗഡ് ഡ്രൈവുകൾ';

  @override
  String get noDrivesRegistered =>
      'ക്ലൗഡ് ഡ്രൈവുകൾ ഒന്നും ബന്ധിപ്പിച്ചിട്ടില്ല';

  @override
  String get cancel => 'റദ്ദാക്കുക';

  @override
  String get save => 'സംരക്ഷിക്കുക';

  @override
  String get saveAndEnable => 'സംരക്ഷിക്കുക & പ്രവർത്തനക്ഷമമാക്കുക';

  @override
  String get setPasswordTitle => 'E2EE മാസ്റ്റർ പാസ്‌വേഡ് സജ്ജീകരിക്കുക';

  @override
  String get setPasswordDescription =>
      'അപ്‌ലോഡ് ചെയ്യുന്നതിന് മുമ്പ് നിങ്ങളുടെ ബാക്കപ്പുകൾ AES-256 ഉപയോഗിച്ച് എൻക്രിപ്റ്റ് ചെയ്യും.';

  @override
  String get masterPasswordLabel => 'മാസ്റ്റർ പാസ്‌വേഡ്';

  @override
  String get passwordEmptyError => 'പാസ്‌വേഡ് ശൂന്യമായിരിക്കാൻ പാടില്ല';

  @override
  String get syncNow => 'ഇപ്പോൾ സിങ്ക് ചെയ്യുക';

  @override
  String get settings => 'ക്രമീകരണങ്ങൾ';

  @override
  String get connected => 'ബന്ധിപ്പിച്ചു';

  @override
  String get disconnected => 'വിച്ഛേദിക്കപ്പെട്ടു';

  @override
  String lastSynced(String time) {
    return 'അവസാനമായി സിങ്ക് ചെയ്തത്: $time';
  }
}
