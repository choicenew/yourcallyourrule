// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Gujarati (`gu`).
class AppLocalizationsGu extends AppLocalizations {
  AppLocalizationsGu([String locale = 'gu']) : super(locale);

  @override
  String get cloudSettingsTitle => 'ક્લાઉડ અને સિન્ક સેટિંગ્સ';

  @override
  String get encryptionTitle => 'એન્ડ-ટુ-એન્ડ એન્ક્રિપ્શન (E2EE)';

  @override
  String get encryptionSubtitle =>
      'અપલોડ કરતા પહેલા તમામ બેકઅપને AES-256 વડે એન્ક્રિપ્ટ કરો';

  @override
  String get encryptionEnabled => 'સક્ષમ (AES-256)';

  @override
  String get encryptionDisabled => 'અક્ષમ';

  @override
  String get configuredDrives => 'ગોઠવેલ ક્લાઉડ ડ્રાઇવ્સ';

  @override
  String get noDrivesRegistered => 'કોઈ ક્લાઉડ ડ્રાઇવ કનેક્ટ થયેલ નથી';

  @override
  String get cancel => 'રદ કરો';

  @override
  String get save => 'સાચવો';

  @override
  String get saveAndEnable => 'સાચવો અને સક્ષમ કરો';

  @override
  String get setPasswordTitle => 'E2EE માસ્ટર પાસવર્ડ સેટ કરો';

  @override
  String get setPasswordDescription =>
      'અપલોડ કરતા પહેલા તમારા બેકઅપ AES-256 સાથે એન્ક્રિપ્ટ કરવામાં આવશે.';

  @override
  String get masterPasswordLabel => 'માસ્ટર પાસવર્ડ';

  @override
  String get passwordEmptyError => 'પાસવર્ડ ખાલી હોઈ શકે નહીં';

  @override
  String get syncNow => 'હવે સિન્ક કરો';

  @override
  String get settings => 'સેટિંગ્સ';

  @override
  String get connected => 'કનેક્ટ થયેલ છે';

  @override
  String get disconnected => 'ડિસ્કનેક્ટ થયેલ છે';

  @override
  String lastSynced(String time) {
    return 'છેલ્લે સિન્ક થયું: $time';
  }
}
