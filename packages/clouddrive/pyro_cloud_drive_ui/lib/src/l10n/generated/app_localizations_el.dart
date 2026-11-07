// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Modern Greek (`el`).
class AppLocalizationsEl extends AppLocalizations {
  AppLocalizationsEl([String locale = 'el']) : super(locale);

  @override
  String get cloudSettingsTitle => 'Ρυθμίσεις cloud και συγχρονισμού';

  @override
  String get encryptionTitle => 'Κρυπτογράφηση άκρου σε άκρο (E2EE)';

  @override
  String get encryptionSubtitle =>
      'Κρυπτογράφηση όλων των αντιγράφων ασφαλείας με AES-256 πριν από τη μεταφόρτωση';

  @override
  String get encryptionEnabled => 'Ενεργό (AES-256)';

  @override
  String get encryptionDisabled => 'Ανενεργό';

  @override
  String get configuredDrives => 'Диαμορφωμένοι δίσκοι cloud';

  @override
  String get noDrivesRegistered => 'Дεν υπάρχουν συνδεδεμένοι δίσκοι cloud';

  @override
  String get cancel => 'Ακύρωση';

  @override
  String get save => 'Αποθήκευση';

  @override
  String get saveAndEnable => 'Аποθήκευση και ενεργοποίηση';

  @override
  String get setPasswordTitle => 'Оρισμός κύριου κωδικού πρόσβασης E2EE';

  @override
  String get setPasswordDescription =>
      'Та αντίγραφα ασφαλείας σας θα κρυπτογραφηθούν με AES-256 πριν από τη μεταφόρτωση.';

  @override
  String get masterPasswordLabel => 'Кύριος κωδικός πρόσβασης';

  @override
  String get passwordEmptyError =>
      'О κωδικός πρόσβασης δεν μπορεί να είναι κενός';

  @override
  String get syncNow => 'Συγχρονισμός τώρα';

  @override
  String get settings => 'Рυθμίσεις';

  @override
  String get connected => 'Συνδεδεμένος';

  @override
  String get disconnected => 'Αποσυνδεδεμένος';

  @override
  String lastSynced(String time) {
    return 'Тελευταίος συγχρονισμός: $time';
  }
}
