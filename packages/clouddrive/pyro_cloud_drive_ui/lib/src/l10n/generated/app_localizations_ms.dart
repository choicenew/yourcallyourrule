// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Malay (`ms`).
class AppLocalizationsMs extends AppLocalizations {
  AppLocalizationsMs([String locale = 'ms']) : super(locale);

  @override
  String get cloudSettingsTitle => 'Tetapan Awan & Pengeksynan';

  @override
  String get encryptionTitle => 'Penyulitan Hujung-ke-Hujung (E2EE)';

  @override
  String get encryptionSubtitle =>
      'Sulitkan semua sandaran dengan AES-256 sebelum dimuat naik';

  @override
  String get encryptionEnabled => 'Didayakan (AES-256)';

  @override
  String get encryptionDisabled => 'Dinyahayakan';

  @override
  String get configuredDrives => 'Pemandu Awan Dikonfigurasi';

  @override
  String get noDrivesRegistered => 'Tiada Pemandu Awan Disambungkan';

  @override
  String get cancel => 'Batal';

  @override
  String get save => 'Simpan';

  @override
  String get saveAndEnable => 'Simpan & Dayakan';

  @override
  String get setPasswordTitle => 'Tetapkan Kata Laluan Induk E2EE';

  @override
  String get setPasswordDescription =>
      'Sandaran anda akan disulitkan dengan AES-256 sebelum dimuat naik.';

  @override
  String get masterPasswordLabel => 'Kata Laluan Induk';

  @override
  String get passwordEmptyError => 'Kata laluan tidak boleh kosong';

  @override
  String get syncNow => 'Segerakkan Sekarang';

  @override
  String get settings => 'Tetapan';

  @override
  String get connected => 'Bersambung';

  @override
  String get disconnected => 'Terputus';

  @override
  String lastSynced(String time) {
    return 'Terakhir disegerakkan: $time';
  }
}
