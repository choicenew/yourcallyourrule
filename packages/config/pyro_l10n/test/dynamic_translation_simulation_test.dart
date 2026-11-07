import 'package:flutter_test/flutter_test.dart';
import 'package:pyro_l10n/pyro_l10n.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('真实场景动态文本与黄历长词转译模拟测试 (Real-World Dynamic Localizer Simulation)', () {
    // 模拟小说/漫画数据源及标签 JSON 词典
    const String mockMangaDomainJson = '''
    {
      "连载中": "Ongoing",
      "已完结": "Completed",
      "热血": "Action",
      "奇幻": "Fantasy",
      "玄幻": "Eastern Fantasy",
      "穿越": "Transmigration",
      "系统": "System",
      "无敌": "Overpowered",
      "宜扫舍": "Clean House",
      "扫舍": "Sweep House",
      "宜": "Suitable",
      "忌": "Avoid",
      "章": "Chapter",
      "话": "Episode",
      "页": "Page",
      "卷": "Volume"
    }
    ''';

    late DynamicTextTranslator translator;

    setUp(() {
      translator = DynamicTextTranslator(
        localeCode: 'en',
        dict: const {},
      ).mergeJsonDomain(mockMangaDomainJson);
    });

    test('模拟测试 1：小说/漫画章节与进度动态表达转译 (Chapter/Progress Phrases)', () {
      final ch1 = PatternLocalizer.localizeStatusPhrase('第 1052 话', translator);
      expect(ch1, equals('Episode 1052'));

      final ch2 = PatternLocalizer.localizeStatusPhrase('共 350 页', translator);
      expect(ch2, equals('Total 350 Page'));

      final progressText = PatternLocalizer.localizeStatusPhrase('连载中 (更新至第 88 话)', translator);
      expect(progressText, contains('Ongoing'));
      expect(progressText, contains('Episode 88'));
    });

    test('模拟测试 2：多领域长词与复合标签贪婪长词匹配 (Greedy Longest-Match)', () {
      const rawTags = '【热血/奇幻/玄幻/穿越/系统/无敌】连载中，今日宜扫舍，宜出行';
      final translated = translator.translateDynamicText(rawTags);

      expect(translated, contains('Action'));
      expect(translated, contains('Fantasy'));
      expect(translated, contains('Eastern Fantasy'));
      expect(translated, contains('Transmigration'));
      expect(translated, contains('System'));
      expect(translated, contains('Overpowered'));
      expect(translated, contains('Ongoing'));
      expect(translated, contains('Clean House'));
      expect(translated, contains('Suitable'));

      // 验证“宜扫舍”优先匹配为“Clean House”，绝没有被短词“宜”切碎为“Suitable 扫舍”
      expect(translated, isNot(contains('Suitable 扫舍')));
      expect(translated, isNot(contains('Suitable Sweep House')));
    });

    test('模拟测试 3：原生中文 (zh_CN) 零开销快捷通道模拟 (Native Zero-Overhead Pass-Through)', () {
      final zhTranslator = DynamicTextTranslator(
        localeCode: 'zh_CN',
        dict: const {'连载中': 'Ongoing'},
      );

      const rawText = '连载中 (第 12 话)';
      final result = zhTranslator.translateDynamicText(rawText);

      // 原生中文直接输出原始文本，不触发任何正则与替换
      expect(result, equals(rawText));
    });

    test('模拟测试 4：高频 UI 列表渲染 10,000 次动态替换吞吐量性能测试 (Performance Budget < 300ms)', () {
      const sampleText = '【热血/奇幻/玄幻/穿越】连载中 (第 888 话)，今日宜扫舍，忌出行';

      final stopwatch = Stopwatch()..start();
      for (var i = 0; i < 10000; i++) {
        PatternLocalizer.localizeStatusPhrase(sampleText, translator);
      }
      stopwatch.stop();

      // 10,000 次复杂长词与句式替换必须在 300ms 内完成（单次调用低于 0.03ms），确保列表滑动 60fps 零卡顿
      expect(stopwatch.elapsedMilliseconds, lessThan(300));
    });
  });
}
