// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Thai (`th`).
class AppLocalizationsTh extends AppLocalizations {
  AppLocalizationsTh([String locale = 'th']) : super(locale);

  @override
  String get read => 'เริ่มอ่าน';

  @override
  String get shelf => 'เพิ่มลงชั้นหนังสือ';

  @override
  String get shelfIn => 'ในชั้นหนังสือ';

  @override
  String get ocr => 'กำลังแยกข้อความ...';

  @override
  String get ocrExtracting => 'กำลังแยกข้อความ...';

  @override
  String get translate => 'ตัวเลือกการแปล';

  @override
  String get comicTranslateAi => 'แปล AI';

  @override
  String get comicTranslateEngine => 'แปลด้วยเครื่องมือ';

  @override
  String get page => 'หน้า';

  @override
  String get pageOf => 'จาก';

  @override
  String get stripMode => 'แถบต่อเนื่อง';

  @override
  String get pageMode => 'หน้าเดียว';

  @override
  String get description => 'คำอธิบาย';

  @override
  String get shareComic => 'แชร์การ์ตูน: ';
}
