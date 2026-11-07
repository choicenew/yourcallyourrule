import 'package:material_ui/material_ui.dart';
import 'package:intl/intl.dart';
import 'app_locale_provider.dart';

/// 全局多语言格式化与动态长文本转译扩展糖 (Locale-Aware Formatting & Dynamic Extensions)
extension PyroLocaleFormattingX on BuildContext {
  /// 获取当前系统的格式化 Locale tag (如 'zh_CN', 'en_US')
  String get _localeTag {
    final locale = Localizations.localeOf(this);
    return locale.countryCode != null && locale.countryCode!.isNotEmpty
        ? '${locale.languageCode}_${locale.countryCode}'
        : locale.languageCode;
  }

  /// 动态长文本/术语转译 (长词优先替换，零切碎)
  String translateDynamicText(String rawText) {
    return PyroL10nGlobal.translateDynamicText(rawText);
  }

  /// 格式化货币 (如 1234.56 -> $1,234.56 或 ¥1,234.56)
  String formatCurrency(
    double amount, {
    String? symbol,
    String? customLocale,
    int decimalDigits = 2,
  }) {
    final formatter = NumberFormat.currency(
      locale: customLocale ?? _localeTag,
      symbol: symbol,
      decimalDigits: decimalDigits,
    );
    return formatter.format(amount);
  }

  /// 格式化普通数字 (如 1234567 -> 1,234,567)
  String formatNumber(
    num value, {
    String? customLocale,
  }) {
    final formatter = NumberFormat.decimalPattern(customLocale ?? _localeTag);
    return formatter.format(value);
  }

  /// 格式化相对时间 (如 "刚刚", "5分钟前", "3小时前", "2天前" 或 "Just now", "5 mins ago", "3 hrs ago")
  String formatRelativeTime(
    DateTime dateTime, {
    String? customLocale,
  }) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);
    final locale = customLocale ?? _localeTag;
    final isZh = locale.startsWith('zh');

    if (difference.inSeconds < 45) {
      return isZh ? '刚刚' : 'Just now';
    } else if (difference.inMinutes < 60) {
      final mins = difference.inMinutes;
      return isZh ? '$mins 分钟前' : '$mins mins ago';
    } else if (difference.inHours < 24) {
      final hrs = difference.inHours;
      return isZh ? '$hrs 小时前' : '$hrs hrs ago';
    } else if (difference.inDays < 30) {
      final days = difference.inDays;
      return isZh ? '$days 天前' : '$days days ago';
    } else {
      final formatter = DateFormat.yMMMd(locale);
      return formatter.format(dateTime);
    }
  }

  /// 格式化日期时间
  String formatDate(
    DateTime dateTime, {
    String pattern = 'yyyy-MM-dd HH:mm',
    String? customLocale,
  }) {
    final formatter = DateFormat(pattern, customLocale ?? _localeTag);
    return formatter.format(dateTime);
  }
}

/// 纯 Locale 扩展糖 (无需 BuildContext)
extension PyroStandaloneLocaleFormattingX on Locale {
  String get localeTag {
    return countryCode != null && countryCode!.isNotEmpty
        ? '${languageCode}_$countryCode'
        : languageCode;
  }

  String formatCurrency(
    double amount, {
    String? symbol,
    int decimalDigits = 2,
  }) {
    final formatter = NumberFormat.currency(
      locale: localeTag,
      symbol: symbol,
      decimalDigits: decimalDigits,
    );
    return formatter.format(amount);
  }

  String formatRelativeTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);
    final isZh = languageCode == 'zh';

    if (difference.inSeconds < 45) {
      return isZh ? '刚刚' : 'Just now';
    } else if (difference.inMinutes < 60) {
      final mins = difference.inMinutes;
      return isZh ? '$mins 分钟前' : '$mins mins ago';
    } else if (difference.inHours < 24) {
      final hrs = difference.inHours;
      return isZh ? '$hrs 小时前' : '$hrs hrs ago';
    } else if (difference.inDays < 30) {
      final days = difference.inDays;
      return isZh ? '$days 天前' : '$days days ago';
    } else {
      final formatter = DateFormat.yMMMd(localeTag);
      return formatter.format(dateTime);
    }
  }
}
