import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';

import 'models/translation_cache_entry.dart';
import 'scheduler/pre_translation_scheduler.dart';
import 'store/l1_memory_cache.dart';
import 'store/l2_disk_cache_store.dart';

/// 翻译缓存统计数据结构 (强类型 0 字符串 Map 提取)
class TranslationCacheStats {
  final int l1MemoryEntries;
  final int l2DiskEntries;
  final String hitRatePercentage;
  final int totalHits;
  final int totalMisses;

  const TranslationCacheStats({
    required this.l1MemoryEntries,
    required this.l2DiskEntries,
    required this.hitRatePercentage,
    this.totalHits = 0,
    this.totalMisses = 0,
  });

  Map<String, dynamic> toMap() => {
        'l1MemoryEntries': l1MemoryEntries,
        'l2DiskEntries': l2DiskEntries,
        'hitRatePercentage': hitRatePercentage,
      };

  dynamic operator [](String key) => toMap()[key];
}

/// 全局大一统专职翻译双级缓存与预翻译引擎
class PyroTranslationCacheEngine {
  static PyroTranslationCacheEngine? _instance;

  final L1MemoryCache _l1Cache;
  final L2DiskCacheStore _l2Store;
  final PreTranslationScheduler _scheduler;

  int _hitCount = 0;
  int _missCount = 0;

  PyroTranslationCacheEngine._({
    int maxL1Entries = 2000,
    int maxL2Entries = 10000,
    int maxConcurrentPreTranslateTasks = 3,
  })  : _l1Cache = L1MemoryCache(maxCapacity: maxL1Entries),
        _l2Store = L2DiskCacheStore(maxDiskEntries: maxL2Entries),
        _scheduler = PreTranslationScheduler(
          maxConcurrentTasks: maxConcurrentPreTranslateTasks,
        );

  /// 单例访问
  static PyroTranslationCacheEngine get instance {
    _instance ??= PyroTranslationCacheEngine._();
    return _instance!;
  }

  /// 自定义创建工厂（用于独立单元测试或隔离场景）
  factory PyroTranslationCacheEngine.createCustom({
    int maxL1Entries = 2000,
    int maxL2Entries = 10000,
    int maxConcurrentTasks = 3,
  }) {
    return PyroTranslationCacheEngine._(
      maxL1Entries: maxL1Entries,
      maxL2Entries: maxL2Entries,
      maxConcurrentPreTranslateTasks: maxConcurrentTasks,
    );
  }

  /// 初始化磁盘 Store 并预热 L1 内存缓存
  Future<void> initialize({Directory? overrideDiskDir}) async {
    await _l2Store.initialize(overrideDir: overrideDiskDir);

    // 从磁盘导出全部有效记录预热至 L1 内存
    final diskEntries = _l2Store.exportAll();
    _l1Cache.putAll(diskEntries);
    debugPrint(
      '🚀 [PyroTranslationCacheEngine] 初始化完成，已将 ${diskEntries.length} 条磁盘缓存预热至 L1 内存。',
    );
  }

  /// 同步/微秒级从 L1 内存检索缓存
  String? getMemoryCached(
    String text, {
    required String targetLang,
    String sourceLang = 'auto',
  }) {
    final key = TranslationCacheEntry.buildCacheKey(
      text,
      targetLang: targetLang,
      sourceLang: sourceLang,
    );

    final entry = _l1Cache.get(key);
    if (entry != null) {
      _hitCount++;
      return entry.translatedText;
    }
    return null;
  }

  /// 检索双级缓存 (L1 内存 ➔ L2 磁盘)
  Future<String?> get(
    String text, {
    required String targetLang,
    String sourceLang = 'auto',
  }) async {
    final key = TranslationCacheEntry.buildCacheKey(
      text,
      targetLang: targetLang,
      sourceLang: sourceLang,
    );

    // 1. 优先查 L1 内存
    final l1Hit = _l1Cache.get(key);
    if (l1Hit != null) {
      _hitCount++;
      return l1Hit.translatedText;
    }

    // 2. 次查 L2 磁盘
    if (!_l2Store.isInitialized) {
      await initialize();
    }

    final l2Hit = _l2Store.get(key);
    if (l2Hit != null) {
      _hitCount++;
      // 反向充填预热 L1
      _l1Cache.put(key, l2Hit);
      return l2Hit.translatedText;
    }

    _missCount++;
    return null;
  }

  /// 写入双级缓存
  void put(
    String text,
    String translatedText, {
    required String targetLang,
    String sourceLang = 'auto',
    Duration? ttl,
  }) {
    final cleanText = text.trim();
    if (cleanText.isEmpty || translatedText.trim().isEmpty) return;

    final key = TranslationCacheEntry.buildCacheKey(
      cleanText,
      targetLang: targetLang,
      sourceLang: sourceLang,
    );

    final now = DateTime.now();
    final entry = TranslationCacheEntry(
      originalText: cleanText,
      translatedText: translatedText,
      sourceLang: sourceLang,
      targetLang: targetLang,
      createdAt: now,
      updatedAt: now,
      ttl: ttl,
    );

    _l1Cache.put(key, entry);
    _l2Store.put(key, entry);
  }

  /// 获取或异步拉取（带缓存拦截）
  Future<String> getOrFetch(
    String text,
    TranslationFetcher fetcher, {
    required String targetLang,
    String sourceLang = 'auto',
    PreTranslationPriority priority = PreTranslationPriority.high,
    Duration? ttl,
  }) async {
    final cleanText = text.trim();
    if (cleanText.isEmpty) return text;

    // 1. 查缓存
    final cached = await get(
      cleanText,
      targetLang: targetLang,
      sourceLang: sourceLang,
    );
    if (cached != null) {
      return cached;
    }

    // 2. 调度执行拉取
    final translated = await _scheduler.schedule(
      text: cleanText,
      targetLang: targetLang,
      sourceLang: sourceLang,
      priority: priority,
      fetcher: fetcher,
    );

    // 3. 写入双级缓存
    put(
      cleanText,
      translated,
      targetLang: targetLang,
      sourceLang: sourceLang,
      ttl: ttl,
    );

    return translated;
  }

  /// 静默非阻塞后台预翻译提交
  Future<List<String>> enqueuePreTranslate(
    List<String> texts,
    TranslationFetcher fetcher, {
    required String targetLang,
    String sourceLang = 'auto',
    PreTranslationPriority priority = PreTranslationPriority.low,
    Duration? ttl,
  }) async {
    final pendingTexts = <String>[];
    final results = <String>[];

    // 先剔除已经存在于缓存中的文本
    for (final t in texts) {
      final cached = getMemoryCached(
        t,
        targetLang: targetLang,
        sourceLang: sourceLang,
      );
      if (cached != null) {
        results.add(cached);
      } else {
        pendingTexts.add(t);
      }
    }

    if (pendingTexts.isEmpty) {
      return results;
    }

    final fetched = await _scheduler.scheduleBatch(
      texts: pendingTexts,
      targetLang: targetLang,
      sourceLang: sourceLang,
      priority: priority,
      fetcher: (text, {required targetLang, required sourceLang}) async {
        final res = await fetcher(
          text,
          targetLang: targetLang,
          sourceLang: sourceLang,
        );
        put(
          text,
          res,
          targetLang: targetLang,
          sourceLang: sourceLang,
          ttl: ttl,
        );
        return res;
      },
    );

    results.addAll(fetched);
    return results;
  }

  /// 刷盘
  Future<void> flush() async {
    await _l2Store.flushToDisk();
  }

  /// 清空双级缓存
  Future<void> clear() async {
    _l1Cache.clear();
    await _l2Store.clear();
    _hitCount = 0;
    _missCount = 0;
  }

  /// 遥测与统计数据 (强类型 0 字符串 Map 提取)
  TranslationCacheStats stats() {
    final totalRequests = _hitCount + _missCount;
    final hitRate = totalRequests > 0 ? (_hitCount / totalRequests) : 0.0;

    return TranslationCacheStats(
      l1MemoryEntries: _l1Cache.size,
      l2DiskEntries: _l2Store.size,
      hitRatePercentage: (hitRate * 100).toStringAsFixed(2),
      totalHits: _hitCount,
      totalMisses: _missCount,
    );
  }
}
