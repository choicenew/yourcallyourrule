// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get cloudSettingsTitle => 'Pengaturan Awan & Sinkronisasi';

  @override
  String get encryptionTitle => 'Enkripsi End-to-End (E2EE)';

  @override
  String get encryptionSubtitle =>
      'Enkripsi semua cadangan dengan AES-256 sebelum diunggah';

  @override
  String get encryptionEnabled => 'Diaktifkan (AES-256)';

  @override
  String get encryptionDisabled => 'Dinonaktifkan';

  @override
  String get configuredDrives => 'Drive Awan Dikonfigurasi';

  @override
  String get noDrivesRegistered => 'Tidak Ada Drive Awan Terhubung';

  @override
  String get cancel => 'Batal';

  @override
  String get save => 'Simpan';

  @override
  String get saveAndEnable => 'Simpan & Aktifkan';

  @override
  String get setPasswordTitle => 'Atur Kata Sandi Utama E2EE';

  @override
  String get setPasswordDescription =>
      'Cadangan Anda akan dienkripsi dengan AES-256 sebelum diunggah.';

  @override
  String get masterPasswordLabel => 'Kata Sandi Utama';

  @override
  String get passwordEmptyError => 'Kata sandi tidak boleh kosong';

  @override
  String get syncNow => 'Sinkronkan Sekarang';

  @override
  String get settings => 'Pengaturan';

  @override
  String get connected => 'Terhubung';

  @override
  String get disconnected => 'Terputus';

  @override
  String lastSynced(String time) {
    return 'Terakhir disinkronkan: $time';
  }
}
