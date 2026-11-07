import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pyro_l10n/pyro_l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  group('LocaleFallbackResolver Cascade Tests', () {
    final supported = const [
      Locale('en', 'US'),
      Locale('zh', 'CN'),
      Locale('zh', 'TW'),
      Locale('es'),
    ];

    test('Exact match returns matched locale', () {
      final res = LocaleFallbackResolver.resolveLocale(
        const Locale('zh', 'CN'),
        supported,
      );
      expect(res, equals(const Locale('zh', 'CN')));
    });

    test('Language only fallback works', () {
      final res = LocaleFallbackResolver.resolveLocale(
        const Locale('es', 'MX'),
        supported,
      );
      expect(res, equals(const Locale('es')));
    });

    test('Traditional Chinese fallback resolves to TW variant', () {
      final res = LocaleFallbackResolver.resolveLocale(
        const Locale('zh', 'HK'),
        supported,
      );
      expect(res, equals(const Locale('zh', 'TW')));
    });

    test('Unsupported locale falls back to default fallback', () {
      final res = LocaleFallbackResolver.resolveLocale(
        const Locale('ja', 'JP'),
        supported,
        defaultFallback: const Locale('en', 'US'),
      );
      expect(res, equals(const Locale('en', 'US')));
    });
  });

  group('DynamicTextTranslator Length-Descending Greedy Matching Tests', () {
    final enDict = {
      '宜': 'Suitable',
      '宜扫舍': 'Clean House',
      '扫舍': 'Sweep House',
      '连载中': 'Ongoing',
      '热血': 'Action',
      '漫画': 'Manga',
    };

    test('Longer term (宜扫舍) is replaced first without short term (宜) fragmentation', () {
      final translator = DynamicTextTranslator(
        localeCode: 'en',
        dict: enDict,
      );

      final result = translator.translateDynamicText('今日宜扫舍，宜出行');
      expect(result, contains('Clean House'));
      expect(result, contains('Suitable'));
      expect(result, isNot(contains('Suitable 扫舍')));
    });

    test('Native Chinese passes raw string directly without processing', () {
      final translator = DynamicTextTranslator(
        localeCode: 'zh_CN',
        dict: enDict,
      );

      final result = translator.translateDynamicText('今日宜扫舍');
      expect(result, equals('今日宜扫舍'));
    });

    test('PatternLocalizer transforms status phrases correctly', () {
      final translator = DynamicTextTranslator(
        localeCode: 'en',
        dict: {'章': 'Chapter', '页': 'Page'},
      );

      final chText = PatternLocalizer.localizeStatusPhrase('第 12 章', translator);
      expect(chText, equals('Chapter 12'));

      final totalText = PatternLocalizer.localizeStatusPhrase('共 50 页', translator);
      expect(totalText, equals('Total 50 Page'));
    });
  });

  group('Locale Formatting Extensions Tests', () {
    test('Standalone Locale currency formatting', () {
      const locale = Locale('en', 'US');
      final formatted = locale.formatCurrency(1234.56, symbol: '\$');
      expect(formatted, contains('1,234.56'));
    });

    test('Standalone Locale relative time formatting', () {
      const zhLocale = Locale('zh', 'CN');
      final now = DateTime.now();
      final fiveMinsAgo = now.subtract(const Duration(minutes: 5));

      final text = zhLocale.formatRelativeTime(fiveMinsAgo);
      expect(text, equals('5 分钟前'));
    });
  });

  group('Riverpod App & Regional Locale Notifiers', () {
    test('AppLocaleNotifier state change and global sync', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      expect(container.read(appLocaleProvider), isNull);

      container.read(appLocaleProvider.notifier).setLanguageCode('zh_CN');
      expect(container.read(appLocaleProvider), equals(const Locale('zh', 'CN')));
      expect(PyroL10nGlobal.currentLocale, equals(const Locale('zh', 'CN')));

      container.read(appLocaleProvider.notifier).setLocale(null);
      expect(container.read(appLocaleProvider), isNull);
    });

    test('RegionalLocaleNotifier state change', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      container.read(regionalLocaleProvider.notifier).setRegionalLocale(const Locale('de', 'DE'));
      expect(container.read(regionalLocaleProvider), equals(const Locale('de', 'DE')));
    });
  });
}
