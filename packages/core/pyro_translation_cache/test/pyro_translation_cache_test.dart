import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:pyro_translation_cache/pyro_translation_cache.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late Directory tempDir;
  late PyroTranslationCacheEngine engine;

  setUp(() async {
    tempDir = await Directory.systemTemp.createTemp('pyro_cache_test_');
    engine = PyroTranslationCacheEngine.createCustom(
      maxL1Entries: 5,
      maxL2Entries: 10,
      maxConcurrentTasks: 2,
    );
    await engine.initialize(overrideDiskDir: tempDir);
  });

  tearDown(() async {
    await engine.clear();
    if (tempDir.existsSync()) {
      await tempDir.delete(recursive: true);
    }
  });

  test('L1 & L2 Dual-Tier Caching test', () async {
    engine.put('Hello World', '你好，世界', targetLang: 'zh');

    // L1 命中测试
    final l1Hit = engine.getMemoryCached('Hello World', targetLang: 'zh');
    expect(l1Hit, equals('你好，世界'));

    // L2 异步击中测试
    final l2Hit = await engine.get('Hello World', targetLang: 'zh');
    expect(l2Hit, equals('你好，世界'));
  });

  test('LRU Memory Eviction test', () async {
    for (var i = 0; i < 6; i++) {
      engine.put('Key $i', 'Val $i', targetLang: 'zh');
    }

    // 容量为 5，Key 0 应被 L1 淘汰
    final key0L1 = engine.getMemoryCached('Key 0', targetLang: 'zh');
    expect(key0L1, isNull);

    // Key 5 应在 L1
    final key5L1 = engine.getMemoryCached('Key 5', targetLang: 'zh');
    expect(key5L1, equals('Val 5'));
  });

  test('getOrFetch with PreTranslationScheduler test', () async {
    var fetchCount = 0;

    Future<String> mockFetcher(
      String text, {
      required String targetLang,
      required String sourceLang,
    }) async {
      fetchCount++;
      await Future.delayed(const Duration(milliseconds: 50));
      return 'Translated: $text';
    }

    final res1 = await engine.getOrFetch(
      'Flutter Architecture',
      mockFetcher,
      targetLang: 'zh',
    );

    expect(res1, equals('Translated: Flutter Architecture'));
    expect(fetchCount, equals(1));

    // 第二次请求应命中双级缓存，不触发 fetcher
    final res2 = await engine.getOrFetch(
      'Flutter Architecture',
      mockFetcher,
      targetLang: 'zh',
    );

    expect(res2, equals('Translated: Flutter Architecture'));
    expect(fetchCount, equals(1));
  });

  test('Stats telemetry verification', () async {
    engine.put('Apple', '苹果', targetLang: 'zh');
    await engine.get('Apple', targetLang: 'zh'); // hit
    await engine.get('Banana', targetLang: 'zh'); // miss

    final stats = engine.stats();
    expect(stats.totalHits, equals(1));
    expect(stats.totalMisses, equals(1));
    expect(stats.hitRatePercentage, equals('50.00'));
  });
}
