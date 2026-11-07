// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get read => 'Bắt đầu đọc';

  @override
  String get shelf => 'Thêm vào kệ sách';

  @override
  String get shelfIn => 'Đã có trên kệ';

  @override
  String get ocr => 'Đang trích xuất...';

  @override
  String get ocrExtracting => 'Đang trích xuất...';

  @override
  String get translate => 'Tùy chọn dịch';

  @override
  String get comicTranslateAi => 'Dịch AI';

  @override
  String get comicTranslateEngine => 'Dịch công cụ';

  @override
  String get page => 'Trang';

  @override
  String get pageOf => 'của';

  @override
  String get stripMode => 'Dải liên tục';

  @override
  String get pageMode => 'Trang đơn';

  @override
  String get description => 'Mô tả';

  @override
  String get shareComic => 'Chia sẻ truyện: ';
}
