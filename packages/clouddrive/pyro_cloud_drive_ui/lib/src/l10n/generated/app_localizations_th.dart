// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Thai (`th`).
class AppLocalizationsTh extends AppLocalizations {
  AppLocalizationsTh([String locale = 'th']) : super(locale);

  @override
  String get cloudSettingsTitle => 'การตั้งค่าคลาวด์และการซิงค์';

  @override
  String get encryptionTitle => 'การเข้ารหัสต้นทางถึงปลายทาง (E2EE)';

  @override
  String get encryptionSubtitle =>
      'เข้ารหัสข้อมูลสำรองทั้งหมดด้วย AES-256 ก่อนอัปโหลด';

  @override
  String get encryptionEnabled => 'เปิดใช้งาน (AES-256)';

  @override
  String get encryptionDisabled => 'ปิดใช้งาน';

  @override
  String get configuredDrives => 'ไดรฟ์คลาวด์ที่กำหนดค่าไว้';

  @override
  String get noDrivesRegistered => 'ไม่ได้เชื่อมต่อไดรฟ์คลาวด์';

  @override
  String get cancel => 'ยกเลิก';

  @override
  String get save => 'บันทึก';

  @override
  String get saveAndEnable => 'บันทึกและเปิดใช้งาน';

  @override
  String get setPasswordTitle => 'ตั้งรหัสผ่านหลัก E2EE';

  @override
  String get setPasswordDescription =>
      'ข้อมูลสำรองของคุณจะถูกเข้ารหัสด้วย AES-256 ก่อนอัปโหลด';

  @override
  String get masterPasswordLabel => 'รหัสผ่านหลัก';

  @override
  String get passwordEmptyError => 'รหัสผ่านต้องไม่ว่างเปล่า';

  @override
  String get syncNow => 'ซิงค์ทันที';

  @override
  String get settings => 'การตั้งค่า';

  @override
  String get connected => 'เชื่อมต่อแล้ว';

  @override
  String get disconnected => 'ตัดการเชื่อมต่อ';

  @override
  String lastSynced(String time) {
    return 'ซิงค์ล่าสุด: $time';
  }
}
