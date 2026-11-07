import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../models/translation_cache_entry.dart';

/// L2 磁盘持久化翻译缓存
class L2DiskCacheStore {
  final String dirName;
  final int maxDiskEntries;
  final Duration defaultTtl;

  Directory? _cacheDir;
  File? _storeFile;
  final Map<String, TranslationCacheEntry> _diskIndex = {};

  bool _isInitialized = false;
  Timer? _debounceFlushTimer;
  bool _isDirty = false;

  L2DiskCacheStore({
    this.dirName = 'pyro_translation_cache',
    this.maxDiskEntries = 10000,
    this.defaultTtl = const Duration(days: 30),
  });

  bool get isInitialized => _isInitialized;

  /// 初始化并预载磁盘缓存索引
  Future<void> initialize({Directory? overrideDir}) async {
    if (_isInitialized) return;

    try {
      if (overrideDir != null) {
        _cacheDir = overrideDir;
      } else {
        final appSupportDir = await getApplicationSupportDirectory();
        _cacheDir = Directory(p.join(appSupportDir.path, dirName));
      }

      if (!_cacheDir!.existsSync()) {
        await _cacheDir!.create(recursive: true);
      }

      _storeFile = File(p.join(_cacheDir!.path, 'translation_store.json'));
      await _loadFromDisk();
      _isInitialized = true;
    } catch (e, stack) {
      debugPrint('⚠️ [L2DiskCacheStore] 磁盘初始化或读取异常: $e\n$stack');
      _isInitialized = true; // 即使磁盘出错也保持降级可运行
    }
  }

  Future<void> _loadFromDisk() async {
    if (_storeFile == null || !_storeFile!.existsSync()) return;

    try {
      final content = await _storeFile!.readAsString();
      if (content.trim().isEmpty) return;

      final jsonMap = jsonDecode(content) as Map<String, dynamic>;
      final now = DateTime.now();

      _diskIndex.clear();
      jsonMap.forEach((key, val) {
        if (val is Map<String, dynamic>) {
          final entry = TranslationCacheEntry.fromJson(val);
          // 判定是否 TTL 过期，未超期的才载入内存索引
          if (!entry.isExpired(now)) {
            _diskIndex[key] = entry;
          }
        }
      });
    } catch (e) {
      debugPrint('⚠️ [L2DiskCacheStore] 解析磁盘缓存文件失败，复位重置: $e');
      _diskIndex.clear();
    }
  }

  /// 检索磁盘索引
  TranslationCacheEntry? get(String key) {
    final entry = _diskIndex[key];
    if (entry == null) return null;

    if (entry.isExpired()) {
      _diskIndex.remove(key);
      _markDirty();
      return null;
    }

    final updated = entry.incrementHitCount();
    _diskIndex[key] = updated;
    _markDirty();
    return updated;
  }

  /// 写入磁盘索引（防抖落盘）
  void put(String key, TranslationCacheEntry entry) {
    _diskIndex[key] = entry;
    _markDirty();
  }

  /// 批量写入
  void putAll(Map<String, TranslationCacheEntry> entries) {
    _diskIndex.addAll(entries);
    _markDirty();
  }

  /// 导出全部有效条目（用于预热 L1 内存）
  Map<String, TranslationCacheEntry> exportAll() {
    return Map.unmodifiable(_diskIndex);
  }

  void _markDirty() {
    _isDirty = true;
    _debounceFlushTimer?.cancel();
    _debounceFlushTimer = Timer(const Duration(seconds: 2), () {
      flushToDisk();
    });
  }

  /// 强制同步/异步刷盘与原子落盘
  Future<void> flushToDisk() async {
    if (!_isDirty || _storeFile == null) return;
    _isDirty = false;

    try {
      _pruneIfNeeded();

      final jsonMap = <String, dynamic>{};
      _diskIndex.forEach((k, v) {
        jsonMap[k] = v.toJson();
      });

      final jsonStr = jsonEncode(jsonMap);
      final tmpFile = File('${_storeFile!.path}.tmp');

      await tmpFile.writeAsString(jsonStr, flush: true);
      if (_storeFile!.existsSync()) {
        await _storeFile!.delete();
      }
      await tmpFile.rename(_storeFile!.path);
    } catch (e, stack) {
      debugPrint('❌ [L2DiskCacheStore] 刷新写盘异常: $e\n$stack');
    }
  }

  /// 剪裁超限条目与过期条目
  void _pruneIfNeeded() {
    final now = DateTime.now();

    // 1. 清理过期条目
    _diskIndex.removeWhere((_, entry) => entry.isExpired(now));

    // 2. 超限 LRU/HitCount 剪裁
    if (_diskIndex.length > maxDiskEntries) {
      final sortedEntries = _diskIndex.entries.toList()
        ..sort((a, b) => a.value.updatedAt.compareTo(b.value.updatedAt));

      final removeCount = _diskIndex.length - maxDiskEntries;
      for (var i = 0; i < removeCount; i++) {
        _diskIndex.remove(sortedEntries[i].key);
      }
    }
  }

  /// 清空磁盘缓存
  Future<void> clear() async {
    _diskIndex.clear();
    _isDirty = false;
    _debounceFlushTimer?.cancel();

    if (_storeFile != null && _storeFile!.existsSync()) {
      try {
        await _storeFile!.delete();
      } catch (_) {}
    }
  }

  int get size => _diskIndex.length;
}
