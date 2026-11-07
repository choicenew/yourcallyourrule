import 'dart:async';
import 'package:flutter/foundation.dart';

import '../models/translation_cache_entry.dart';

/// 预翻译任务优先级
enum PreTranslationPriority {
  high,   // 高优先级：例如当前屏幕视口内的卡片标题
  normal, // 中优先级：例如二级详情页摘要
  low,    // 低优先级：例如后台预加载或列表沉底项
}

typedef TranslationFetcher = Future<String> Function(
  String text, {
  required String targetLang,
  required String sourceLang,
});

class _TaskItem {
  final String text;
  final String targetLang;
  final String sourceLang;
  final PreTranslationPriority priority;
  final TranslationFetcher fetcher;
  final Completer<String> completer = Completer<String>();
  final DateTime queuedAt = DateTime.now();

  _TaskItem({
    required this.text,
    required this.targetLang,
    required this.sourceLang,
    required this.priority,
    required this.fetcher,
  });

  String get cacheKey => TranslationCacheEntry.buildCacheKey(
        text,
        targetLang: targetLang,
        sourceLang: sourceLang,
      );
}

/// 后台预翻译并发调度器
class PreTranslationScheduler {
  final int maxConcurrentTasks;
  final List<_TaskItem> _queue = [];
  final Map<String, _TaskItem> _inFlight = {};
  int _activeWorkerCount = 0;

  PreTranslationScheduler({this.maxConcurrentTasks = 3});

  /// 提交单个预翻译任务（含请求去重与合并 Completer）
  Future<String> schedule({
    required String text,
    required String targetLang,
    String sourceLang = 'auto',
    PreTranslationPriority priority = PreTranslationPriority.normal,
    required TranslationFetcher fetcher,
  }) {
    final cleanText = text.trim();
    if (cleanText.isEmpty) return Future.value(text);

    final key = TranslationCacheEntry.buildCacheKey(
      cleanText,
      targetLang: targetLang,
      sourceLang: sourceLang,
    );

    // 1. 如果已经在执行中，复用 Completer
    if (_inFlight.containsKey(key)) {
      return _inFlight[key]!.completer.future;
    }

    // 2. 如果已在等待队列中，尝试提升优先级或复用
    final existingInQueue = _queue.cast<_TaskItem?>().firstWhere(
          (item) => item?.cacheKey == key,
          orElse: () => null,
        );

    if (existingInQueue != null) {
      if (priority.index < existingInQueue.priority.index) {
        // 提升优先级（High 索引小）
        _queue.remove(existingInQueue);
        final itemWithHigherPriority = _TaskItem(
          text: cleanText,
          targetLang: targetLang,
          sourceLang: sourceLang,
          priority: priority,
          fetcher: fetcher,
        );
        _queue.add(itemWithHigherPriority);
        _sortQueue();
        return itemWithHigherPriority.completer.future;
      }
      return existingInQueue.completer.future;
    }

    // 3. 新建任务入队列
    final task = _TaskItem(
      text: cleanText,
      targetLang: targetLang,
      sourceLang: sourceLang,
      priority: priority,
      fetcher: fetcher,
    );

    _queue.add(task);
    _sortQueue();
    _processQueue();

    return task.completer.future;
  }

  /// 批量提交预翻译任务
  Future<List<String>> scheduleBatch({
    required List<String> texts,
    required String targetLang,
    String sourceLang = 'auto',
    PreTranslationPriority priority = PreTranslationPriority.low,
    required TranslationFetcher fetcher,
  }) async {
    final futures = texts.map((t) {
      return schedule(
        text: t,
        targetLang: targetLang,
        sourceLang: sourceLang,
        priority: priority,
        fetcher: fetcher,
      );
    }).toList();

    return Future.wait(futures);
  }

  void _sortQueue() {
    _queue.sort((a, b) {
      final prioComp = a.priority.index.compareTo(b.priority.index);
      if (prioComp != 0) return prioComp;
      return a.queuedAt.compareTo(b.queuedAt);
    });
  }

  void _processQueue() {
    while (_activeWorkerCount < maxConcurrentTasks && _queue.isNotEmpty) {
      final task = _queue.removeAt(0);
      _inFlight[task.cacheKey] = task;
      _activeWorkerCount++;

      _executeTask(task);
    }
  }

  Future<void> _executeTask(_TaskItem task) async {
    try {
      final res = await task.fetcher(
        task.text,
        targetLang: task.targetLang,
        sourceLang: task.sourceLang,
      );
      if (!task.completer.isCompleted) {
        task.completer.complete(res);
      }
    } catch (e, stack) {
      debugPrint('⚠️ [PreTranslationScheduler] 预翻译执行异常: $e\n$stack');
      if (!task.completer.isCompleted) {
        task.completer.completeError(e, stack);
      }
    } finally {
      _inFlight.remove(task.cacheKey);
      _activeWorkerCount--;
      _processQueue();
    }
  }

  int get pendingQueueSize => _queue.length;

  int get activeWorkerCount => _activeWorkerCount;
}
