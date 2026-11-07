/// 负责合并来自多个源的元数据。
class MetadataMerger {
  /// 将新抓取的 [scrapedData] 合并进现有的 [existingMetadata]。
  /// 优先级策略：如果字段已存在且 [overwrite] 为 false，则保留原值。
  static Map<String, dynamic> merge(
    Map<String, dynamic> existingMetadata,
    Map<String, dynamic> scrapedData, {
    bool overwrite = true,
  }) {
    final result = Map<String, dynamic>.from(existingMetadata);

    scrapedData.forEach((key, value) {
      if (value == null) return;
      
      // 如果是作者对象，尝试合并内部统计
      if (key == 'author' && value is Map && result['author'] is Map) {
         result['author'] = _mergeAuthor(
           Map<String, dynamic>.from(result['author']),
           Map<String, dynamic>.from(value),
         );
      } else {
        if (overwrite || result[key] == null) {
          result[key] = value;
        }
      }
    });

    return result;
  }

  static Map<String, dynamic> _mergeAuthor(
    Map<String, dynamic> existing,
    Map<String, dynamic> scraped,
  ) {
    final result = Map<String, dynamic>.from(existing);
    scraped.forEach((k, v) {
      if (v != null) {
        if (k == 'stats' && v is Map && result['stats'] is Map) {
           final existingStats = Map<String, dynamic>.from(result['stats']);
           final newStats = Map<String, dynamic>.from(v);
           newStats.forEach((sk, sv) => existingStats[sk] = sv);
           result['stats'] = existingStats;
        } else {
          result[k] = v;
        }
      }
    });
    return result;
  }
}
