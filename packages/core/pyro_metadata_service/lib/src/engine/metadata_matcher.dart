/// 专门负责解决同名冲突的匹配器
class MetadataMatcher {
  /// 计算匹配得分 (0.0 ~ 1.0)
  static double calculateMatchScore({
    required String localTitle,
    List<String> localAuthors = const [],
    String? localYear,
    required String remoteTitle,
    List<String> remoteAuthors = const [],
    String? remoteYear,
    Map<String, String> localIds = const {},
    Map<String, String> remoteIds = const {},
  }) {
    // 0. 唯一 ID 匹配 (最高权重，如果 ISBN/DOI 对上了，直接满分)
    for (final key in localIds.keys) {
      if (remoteIds.containsKey(key) && localIds[key] == remoteIds[key]) {
        return 1.0;
      }
    }

    double score = 0.0;
    final cleanLocalTitle = _normalize(localTitle);
    final cleanRemoteTitle = _normalize(remoteTitle);

    // 1. 标题完全匹配 (权重 0.3)
    if (cleanLocalTitle == cleanRemoteTitle) {
      score += 0.3;
    } else if (cleanLocalTitle.contains(cleanRemoteTitle) ||
        cleanRemoteTitle.contains(cleanLocalTitle)) {
      score += 0.15; // 部分匹配
    }

    // 2. 作者匹配 (权重 0.5 - 解决同名冲突的关键)
    if (localAuthors.isNotEmpty && remoteAuthors.isNotEmpty) {
      int matchCount = 0;
      for (final la in localAuthors) {
        final cl = _normalize(la);
        for (final ra in remoteAuthors) {
          if (cl.contains(_normalize(ra)) || _normalize(ra).contains(cl)) {
            matchCount++;
            break;
          }
        }
      }
      if (matchCount > 0) {
        score += 0.5 * (matchCount / localAuthors.length);
      }
    }

    // 3. 年份匹配 (权重 0.2)
    if (localYear != null && remoteYear != null) {
      if (localYear == remoteYear) {
        score += 0.2;
      }
    }

    return score;
  }

  static String _normalize(String input) =>
      input.trim().toLowerCase().replaceAll(RegExp(r'\s+'), '');
}
