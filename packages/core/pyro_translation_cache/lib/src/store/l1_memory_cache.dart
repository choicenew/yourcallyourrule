import 'dart:collection';

import '../models/translation_cache_entry.dart';

/// L1 内存级 LRU 翻译缓存
class L1MemoryCache {
  final int maxCapacity;
  final LinkedHashMap<String, TranslationCacheEntry> _map =
      LinkedHashMap<String, TranslationCacheEntry>();

  L1MemoryCache({this.maxCapacity = 2000});

  /// 检索缓存。如果击中，将键移动到 LinkedHashMap 末端 (Most Recently Used)
  TranslationCacheEntry? get(String key) {
    if (!_map.containsKey(key)) return null;

    final entry = _map.remove(key)!;
    if (entry.isExpired()) {
      return null;
    }

    final updated = entry.incrementHitCount();
    _map[key] = updated;
    return updated;
  }

  /// 写入缓存。若容量满，自动淘汰最旧的键 (Least Recently Used)
  void put(String key, TranslationCacheEntry entry) {
    if (_map.containsKey(key)) {
      _map.remove(key);
    } else if (_map.length >= maxCapacity) {
      final oldestKey = _map.keys.first;
      _map.remove(oldestKey);
    }
    _map[key] = entry;
  }

  /// 批量注入/预热
  void putAll(Map<String, TranslationCacheEntry> entries) {
    entries.forEach(put);
  }

  bool containsKey(String key) => _map.containsKey(key);

  TranslationCacheEntry? remove(String key) => _map.remove(key);

  void clear() => _map.clear();

  int get size => _map.length;

  List<TranslationCacheEntry> get values => _map.values.toList();
}
