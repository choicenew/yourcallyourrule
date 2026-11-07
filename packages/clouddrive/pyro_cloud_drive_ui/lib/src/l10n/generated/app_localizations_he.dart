// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hebrew (`he`).
class AppLocalizationsHe extends AppLocalizations {
  AppLocalizationsHe([String locale = 'he']) : super(locale);

  @override
  String get cloudSettingsTitle => 'הגדרות ענן וסנכרון';

  @override
  String get encryptionTitle => 'הצפנה מקצה לקצה (E2EE)';

  @override
  String get encryptionSubtitle =>
      'הצפנת כל הגיבויים באמצעות AES-256 לפני ההעלאה';

  @override
  String get encryptionEnabled => 'מופעל (AES-256)';

  @override
  String get encryptionDisabled => 'מושבת';

  @override
  String get configuredDrives => 'כונני ענן מוגדרים';

  @override
  String get noDrivesRegistered => 'אין כונני ענן מחוברים';

  @override
  String get cancel => 'ביטול';

  @override
  String get save => 'שמור';

  @override
  String get saveAndEnable => 'שמור והפעל';

  @override
  String get setPasswordTitle => 'הגדר סיסמת אב ל-E2EE';

  @override
  String get setPasswordDescription =>
      'הגיבויים שלך יוצפנו באמצעות AES-256 לפני ההעלאה.';

  @override
  String get masterPasswordLabel => 'סיסמת אב';

  @override
  String get passwordEmptyError => 'הסיסמה לא יכולה להיות ריקה';

  @override
  String get syncNow => 'סנכרן כעת';

  @override
  String get settings => 'הגדרות';

  @override
  String get connected => 'מחובר';

  @override
  String get disconnected => 'מנותק';

  @override
  String lastSynced(String time) {
    return 'סנכרון אחרון: $time';
  }
}
