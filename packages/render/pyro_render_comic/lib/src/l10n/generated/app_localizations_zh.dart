// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get read => '开始阅读';

  @override
  String get shelf => '加入书架';

  @override
  String get shelfIn => '已在书架';

  @override
  String get ocr => '提取台词/文字';

  @override
  String get ocrExtracting => '正在提取台词/文字...';

  @override
  String get translate => '翻译选项';

  @override
  String get comicTranslateAi => 'AI 气泡擦除重排';

  @override
  String get comicTranslateEngine => '标准引擎抹译';

  @override
  String get page => '第';

  @override
  String get pageOf => '页 / 共';

  @override
  String get stripMode => '连续卷轴模式';

  @override
  String get pageMode => '单页阅读模式';

  @override
  String get description => '作品简介';

  @override
  String get shareComic => '分享漫画: ';
}

/// The translations for Chinese, as used in China (`zh_CN`).
class AppLocalizationsZhCn extends AppLocalizationsZh {
  AppLocalizationsZhCn() : super('zh_CN');

  @override
  String get read => '开始阅读';

  @override
  String get shelf => '加入书架';

  @override
  String get shelfIn => '已在书架';

  @override
  String get ocr => '提取台词/文字';

  @override
  String get ocrExtracting => '正在提取台词/文字...';

  @override
  String get translate => '翻译选项';

  @override
  String get comicTranslateAi => 'AI 气泡擦除重排';

  @override
  String get comicTranslateEngine => '标准引擎抹译';

  @override
  String get page => '第';

  @override
  String get pageOf => '页 / 共';

  @override
  String get stripMode => '连续卷轴模式';

  @override
  String get pageMode => '单页阅读模式';

  @override
  String get description => '作品简介';

  @override
  String get shareComic => '分享漫画: ';
}

/// The translations for Chinese, as used in Hong Kong (`zh_HK`).
class AppLocalizationsZhHk extends AppLocalizationsZh {
  AppLocalizationsZhHk() : super('zh_HK');

  @override
  String get read => '開始閱讀';

  @override
  String get shelf => '加入書架';

  @override
  String get shelfIn => '已在書架';

  @override
  String get ocr => '提取文字';

  @override
  String get ocrExtracting => '提取中...';

  @override
  String get translate => '翻譯選項';

  @override
  String get comicTranslateAi => 'AI 翻譯';

  @override
  String get comicTranslateEngine => '引擎翻譯';

  @override
  String get page => '頁面';

  @override
  String get pageOf => '/';

  @override
  String get stripMode => '連續條漫';

  @override
  String get pageMode => '單頁模式';

  @override
  String get description => '描述';

  @override
  String get shareComic => '分享漫畫：';
}

/// The translations for Chinese, as used in Taiwan (`zh_TW`).
class AppLocalizationsZhTw extends AppLocalizationsZh {
  AppLocalizationsZhTw() : super('zh_TW');

  @override
  String get read => '開始閱讀';

  @override
  String get shelf => '加入書架';

  @override
  String get shelfIn => '已在書架';

  @override
  String get ocr => '擷取文字';

  @override
  String get ocrExtracting => '擷取中...';

  @override
  String get translate => '翻譯選項';

  @override
  String get comicTranslateAi => 'AI 翻譯';

  @override
  String get comicTranslateEngine => '引擎翻譯';

  @override
  String get page => '頁面';

  @override
  String get pageOf => '/';

  @override
  String get stripMode => '連續條漫';

  @override
  String get pageMode => '單頁模式';

  @override
  String get description => '描述';

  @override
  String get shareComic => '分享漫畫：';
}
