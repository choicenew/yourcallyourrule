// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get play => '播放';

  @override
  String get download => '下载中';

  @override
  String get downloading => '正在下载...';

  @override
  String get like => '收藏';

  @override
  String get liked => '已点赞/已收藏';

  @override
  String get pause => '暂停';

  @override
  String get replay => '重播';

  @override
  String get speed => '倍速';

  @override
  String get quality => '画质';

  @override
  String get share => '分享';

  @override
  String get description => '作品简介';

  @override
  String get shareVideo => '分享视频: ';
}

/// The translations for Chinese, as used in China (`zh_CN`).
class AppLocalizationsZhCn extends AppLocalizationsZh {
  AppLocalizationsZhCn() : super('zh_CN');

  @override
  String get play => '播放';

  @override
  String get download => '下载中';

  @override
  String get downloading => '正在下载...';

  @override
  String get like => '收藏';

  @override
  String get liked => '已点赞/已收藏';

  @override
  String get pause => '暂停';

  @override
  String get replay => '重播';

  @override
  String get speed => '倍速';

  @override
  String get quality => '画质';

  @override
  String get share => '分享';

  @override
  String get description => '作品简介';

  @override
  String get shareVideo => '分享视频: ';
}

/// The translations for Chinese, as used in Hong Kong (`zh_HK`).
class AppLocalizationsZhHk extends AppLocalizationsZh {
  AppLocalizationsZhHk() : super('zh_HK');

  @override
  String get play => '播放';

  @override
  String get download => '下載中';

  @override
  String get downloading => '下載中...';

  @override
  String get like => '收藏';

  @override
  String get liked => '已點讚';

  @override
  String get pause => '暫停';

  @override
  String get replay => '重播';

  @override
  String get speed => '速度';

  @override
  String get quality => '畫質';

  @override
  String get share => '分享';

  @override
  String get description => '描述';

  @override
  String get shareVideo => '分享視頻：';
}

/// The translations for Chinese, as used in Taiwan (`zh_TW`).
class AppLocalizationsZhTw extends AppLocalizationsZh {
  AppLocalizationsZhTw() : super('zh_TW');

  @override
  String get play => '播放';

  @override
  String get download => '下載中';

  @override
  String get downloading => '下載中...';

  @override
  String get like => '收藏';

  @override
  String get liked => '已按讚';

  @override
  String get pause => '暫停';

  @override
  String get replay => '重播';

  @override
  String get speed => '速度';

  @override
  String get quality => '畫質';

  @override
  String get share => '分享';

  @override
  String get description => '描述';

  @override
  String get shareVideo => '分享影片：';
}
