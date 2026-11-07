// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get read => 'Mulai Membaca';

  @override
  String get shelf => 'Tambahkan ke Rak';

  @override
  String get shelfIn => 'Di Rak';

  @override
  String get ocr => 'Mengekstrak...';

  @override
  String get ocrExtracting => 'Mengekstrak...';

  @override
  String get translate => 'Opsi Terjemahan';

  @override
  String get comicTranslateAi => 'Terjemahan AI';

  @override
  String get comicTranslateEngine => 'Terjemahan Mesin';

  @override
  String get page => 'Halaman';

  @override
  String get pageOf => 'dari';

  @override
  String get stripMode => 'Jalur Berkelanjutan';

  @override
  String get pageMode => 'Halaman Tunggal';

  @override
  String get description => 'Deskripsi';

  @override
  String get shareComic => 'Bagikan Komik: ';
}
