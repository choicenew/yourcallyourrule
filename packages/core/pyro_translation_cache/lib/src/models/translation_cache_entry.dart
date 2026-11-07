import 'package:flutter/foundation.dart';

/// 翻译缓存实体模型
@immutable
class TranslationCacheEntry {
  final String originalText;
  final String translatedText;
  final String sourceLang;
  final String targetLang;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int hitCount;
  final Duration? ttl;

  const TranslationCacheEntry({
    required this.originalText,
    required this.translatedText,
    this.sourceLang = 'auto',
    required this.targetLang,
    required this.createdAt,
    required this.updatedAt,
    this.hitCount = 1,
    this.ttl,
  });

  /// 缓存唯一键生成策略：`sourceLang->targetLang:lower(trimmedText)`
  static String buildCacheKey(
    String text, {
    required String targetLang,
    String sourceLang = 'auto',
  }) {
    final cleanText = text.trim().toLowerCase();
    final cleanSource = sourceLang.trim().toLowerCase();
    final cleanTarget = targetLang.trim().toLowerCase();
    return '$cleanSource->$cleanTarget:$cleanText';
  }

  /// 判定当前缓存项是否已超时失效
  bool isExpired([DateTime? now]) {
    if (ttl == null) return false;
    final ref = now ?? DateTime.now();
    return ref.difference(updatedAt) > ttl!;
  }

  /// 增加命中次数并更新时间戳
  TranslationCacheEntry incrementHitCount() {
    final now = DateTime.now();
    return TranslationCacheEntry(
      originalText: originalText,
      translatedText: translatedText,
      sourceLang: sourceLang,
      targetLang: targetLang,
      createdAt: createdAt,
      updatedAt: now,
      hitCount: hitCount + 1,
      ttl: ttl,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'originalText': originalText,
      'translatedText': translatedText,
      'sourceLang': sourceLang,
      'targetLang': targetLang,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'hitCount': hitCount,
      'ttlMs': ttl?.inMilliseconds,
    };
  }

  factory TranslationCacheEntry.fromJson(Map<String, dynamic> json) {
    return TranslationCacheEntry(
      originalText: json['originalText'] as String? ?? '',
      translatedText: json['translatedText'] as String? ?? '',
      sourceLang: json['sourceLang'] as String? ?? 'auto',
      targetLang: json['targetLang'] as String? ?? 'en',
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : DateTime.now(),
      hitCount: (json['hitCount'] as num?)?.toInt() ?? 1,
      ttl: json['ttlMs'] != null
          ? Duration(milliseconds: (json['ttlMs'] as num).toInt())
          : null,
    );
  }
}
