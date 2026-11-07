// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Tamil (`ta`).
class AppLocalizationsTa extends AppLocalizations {
  AppLocalizationsTa([String locale = 'ta']) : super(locale);

  @override
  String get cloudSettingsTitle => 'மேகம் மற்றும் ஒத்திசைவு அமைப்புகள்';

  @override
  String get encryptionTitle => 'முனை முதல் முனை குறிமுறையாக்கம் (E2EE)';

  @override
  String get encryptionSubtitle =>
      'பதிவேற்றுவதற்கு முன் அனைத்து காப்புப்பிரதிகளையும் AES-256 மூலம் குறிமுறையாக்கு';

  @override
  String get encryptionEnabled => 'இயக்கப்பட்டது (AES-256)';

  @override
  String get encryptionDisabled => 'முடக்கப்பட்டது';

  @override
  String get configuredDrives => 'அமைக்கப்பட்ட மேக இயக்கிகள்';

  @override
  String get noDrivesRegistered => 'மேக இயக்கிகள் எதுவும் இணைக்கப்படவில்லை';

  @override
  String get cancel => 'ரத்துசெய்';

  @override
  String get save => 'சேமி';

  @override
  String get saveAndEnable => 'சேமி & இயக்கு';

  @override
  String get setPasswordTitle => 'E2EE முதன்மை கடவுச்சொல்லை அமை';

  @override
  String get setPasswordDescription =>
      'பதிவேற்றுவதற்கு முன் உங்கள் காப்புப்பிரதிகள் AES-256 மூலம் குறிமுறையாக்கப்படும்.';

  @override
  String get masterPasswordLabel => 'முதன்மை கடவுச்சொல்';

  @override
  String get passwordEmptyError => 'கடவுச்சொல் காலியாக இருக்கக்கூடாது';

  @override
  String get syncNow => 'இப்போது ஒத்திசை';

  @override
  String get settings => 'அமைப்புகள்';

  @override
  String get connected => 'இணைக்கப்பட்டது';

  @override
  String get disconnected => 'துண்டிக்கப்பட்டது';

  @override
  String lastSynced(String time) {
    return 'கடைசியாக ஒத்திசைக்கப்பட்டது: $time';
  }
}
