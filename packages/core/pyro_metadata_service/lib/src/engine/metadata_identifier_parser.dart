/// 负责从文件名或原始标题中提取结构化信息
class MetadataIdentifierParser {
  /// 尝试从文件名解析出标题、作者和年份
  /// 示例: "[刘慈欣] 三体 (2008).epub" -> {title: "三体", author: "刘慈欣", year: "2008"}
  static Map<String, String> parseFilename(String filename) {
    final result = <String, String>{};

    // 移除扩展名
    final cleanName = filename.contains('.')
        ? filename.substring(0, filename.lastIndexOf('.'))
        : filename;

    // 1. 尝试匹配 [Author] Title (Year) 模式
    final pattern1 = RegExp(r'^\[(.+)\]\s*(.+)\s*\((19|20\d{2})\)$');
    final match1 = pattern1.firstMatch(cleanName);
    if (match1 != null) {
      result['author'] = match1.group(1)!;
      result['title'] = match1.group(2)!;
      result['year'] = match1.group(3)!;
      return result;
    }

    // 2. 尝试匹配 Title - Author 模式
    if (cleanName.contains(' - ')) {
      final parts = cleanName.split(' - ');
      result['title'] = parts[0].trim();
      result['author'] = parts[1].trim();
      return result;
    }

    result['title'] = cleanName.trim();
    return result;
  }
}
