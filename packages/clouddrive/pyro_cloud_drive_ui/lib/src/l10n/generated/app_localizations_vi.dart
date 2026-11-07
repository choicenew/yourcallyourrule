// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get cloudSettingsTitle => 'Cài đặt Đám mây & Đồng bộ';

  @override
  String get encryptionTitle => 'Mã hóa đầu cuối (E2EE)';

  @override
  String get encryptionSubtitle =>
      'Mã hóa tất cả bản sao lưu bằng AES-256 trước khi tải lên';

  @override
  String get encryptionEnabled => 'Đã bật (AES-256)';

  @override
  String get encryptionDisabled => 'Đã tắt';

  @override
  String get configuredDrives => 'Đĩa đám mây đã cấu hình';

  @override
  String get noDrivesRegistered => 'Không có đĩa đám mây nào được kết nối';

  @override
  String get cancel => 'Hủy';

  @override
  String get save => 'Lưu';

  @override
  String get saveAndEnable => 'Lưu & Bật';

  @override
  String get setPasswordTitle => 'Đặt mật khẩu chính E2EE';

  @override
  String get setPasswordDescription =>
      'Các bản sao lưu của bạn sẽ được mã hóa bằng AES-256 trước khi tải lên.';

  @override
  String get masterPasswordLabel => 'Mật khẩu chính';

  @override
  String get passwordEmptyError => 'Mật khẩu không được để trống';

  @override
  String get syncNow => 'Đồng bộ ngay';

  @override
  String get settings => 'Cài đặt';

  @override
  String get connected => 'Đã kết nối';

  @override
  String get disconnected => 'Đã ngắt kết nối';

  @override
  String lastSynced(String time) {
    return 'Đồng bộ lần cuối: $time';
  }
}
