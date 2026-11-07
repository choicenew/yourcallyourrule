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
  String get share => 'Chia sẻ';

  @override
  String get push => 'Đẩy / Lưu';

  @override
  String get cite => 'Xuất trích dẫn';

  @override
  String get ocr => 'Đang trích xuất...';

  @override
  String get ocrExtracting => 'Đang trích xuất...';

  @override
  String get translate => 'Tùy chọn dịch';

  @override
  String get paperTranslateAi => 'Dịch học thuật AI';

  @override
  String get paperTranslateEngine => 'Dịch chuẩn';

  @override
  String get abstractTitle => 'Tóm tắt';

  @override
  String get authorsTitle => 'Tác giả';

  @override
  String get citationCopied => 'Đã sao chép trích dẫn BibTeX vào khay nhớ tạm';

  @override
  String get exportBibtex => 'BibTeX';

  @override
  String get keywords => 'Từ khóa';

  @override
  String get noAbstract => 'Không có tóm tắt.';

  @override
  String get readFullPaper => 'Đọc toàn văn bài báo';

  @override
  String get sharePaper => 'Chia sẻ bài báo: ';

  @override
  String get doiLabel => 'DOI: ';

  @override
  String get exploreMore => 'Khám phá thêm';

  @override
  String get recentlyRead => 'Đã đọc gần đây';

  @override
  String get academicTrending => 'Xu hướng học thuật';

  @override
  String get paperPreviewTitle => 'Paper Preview';

  @override
  String get close => 'Đóng';
}
