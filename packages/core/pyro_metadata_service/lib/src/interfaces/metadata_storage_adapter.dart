import 'package:pyro_media_models/pyro_media_models.dart';

/// 元数据抓取与存储预设 Token 集合 (强类型 0 字符串魔数)
abstract final class ScrapeMetadataKey {
  static const String cover = 'cover';
  static const String description = 'description';
  static const String scrapeFailed = 'scrape_failed';
  static const String lastScrapeAttempt = 'last_scrape_attempt';
  static const String scrapeConfidence = 'scrape_confidence';
  static const String needsManualReview = 'needs_manual_review';
}

/// 抽象存储适配器 (大一统版本)
abstract class MetadataStorageAdapter {
  /// 获取待补全元数据的媒体条目
  Future<List<MediaEntity>> getItemsPendingEnrichment({int limit = 20});

  /// 更新媒体元数据
  Future<void> updateMetadata(String itemId, Map<String, dynamic> metadata);

  /// 标记失败
  Future<void> markAsFailed(String itemId);
}
