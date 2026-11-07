// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get cloudSettingsTitle => 'Bulut ve Senkronizasyon Ayarları';

  @override
  String get encryptionTitle => 'Uçtan Uca Şifreleme (E2EE)';

  @override
  String get encryptionSubtitle =>
      'Yüklemeden önce tüm yedeklemeleri AES-256 ile şifrele';

  @override
  String get encryptionEnabled => 'Etkin (AES-256)';

  @override
  String get encryptionDisabled => 'Devre Dışı';

  @override
  String get configuredDrives => 'Yapılandırılmış Bulut Sürücüleri';

  @override
  String get noDrivesRegistered => 'Bağlı Bulut Sürücüsü Yok';

  @override
  String get cancel => 'İptal';

  @override
  String get save => 'Kaydet';

  @override
  String get saveAndEnable => 'Kaydet ve Etkinleştir';

  @override
  String get setPasswordTitle => 'E2EE Ana Şifresini Belirle';

  @override
  String get setPasswordDescription =>
      'Yedeklemeleriniz yüklemeden önce AES-256 ile şifrelenecektir.';

  @override
  String get masterPasswordLabel => 'Ana Şifre';

  @override
  String get passwordEmptyError => 'Şifre boş olamaz';

  @override
  String get syncNow => 'Şimdi Senkronize Et';

  @override
  String get settings => 'Ayarlar';

  @override
  String get connected => 'Bağlandı';

  @override
  String get disconnected => 'Bağlantı Kesildi';

  @override
  String lastSynced(String time) {
    return 'Son senkronizasyon: $time';
  }
}
