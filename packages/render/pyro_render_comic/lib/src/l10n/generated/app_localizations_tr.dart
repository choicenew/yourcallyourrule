// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get read => 'Okumaya Başla';

  @override
  String get shelf => 'Kitaplığa Ekle';

  @override
  String get shelfIn => 'Kitaplıkta';

  @override
  String get ocr => 'Metin Çıkarılıyor...';

  @override
  String get ocrExtracting => 'Metin Çıkarılıyor...';

  @override
  String get translate => 'Çeviri Seçenekleri';

  @override
  String get comicTranslateAi => 'Yapay Zeka Çevirisi';

  @override
  String get comicTranslateEngine => 'Motor Çevirisi';

  @override
  String get page => 'Sayfa';

  @override
  String get pageOf => '/';

  @override
  String get stripMode => 'Sürekli Şerit';

  @override
  String get pageMode => 'Tek Sayfa';

  @override
  String get description => 'Açıklama';

  @override
  String get shareComic => 'Çizgi Romanı Paylaş: ';
}
