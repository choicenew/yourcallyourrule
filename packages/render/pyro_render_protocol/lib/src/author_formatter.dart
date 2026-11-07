import 'dart:convert';

/// 作者信息序列化清理与解析增强工具 (Author Formatter V2 - 大一统版)
/// 彻底解决插件返回 Raw Map/List 时页面泄露 [{id:...}] 等序列化明文的缺陷。
/// 原生支持 UNIVERSAL_MEDIA_SPEC.md 规定的 creators 矩阵。
abstract class AuthorFormatter {
  /// 深度抽取并清洗作者名称。支持 creators 矩阵、Map 和 List。
  static String formatAuthorName(
    dynamic rawAuthor, {
    String defaultName = 'Artist',
  }) {
    if (rawAuthor == null) return defaultName;

    // 0. 如果是 JSON 格式字符串，尝试转换后递归解析
    if (rawAuthor is String) {
      final str = rawAuthor.trim();
      if (str.startsWith('{') || str.startsWith('[')) {
        try {
          final decoded = jsonDecode(str);
          return formatAuthorName(decoded, defaultName: defaultName);
        } catch (_) {}
      }
    }

    // 1. 优先处理大一统规范的 creators 矩阵 (Map<String, String>)
    if (rawAuthor is Map) {
      final roles = [
        'author',
        'singer',
        'artist',
        'director',
        'painter',
        'uploader',
        'publisher',
      ];
      for (final role in roles) {
        if (rawAuthor.containsKey(role)) {
          final name = rawAuthor[role]?.toString().trim();
          if (name != null && name.isNotEmpty) return name;
        }
      }

      final name =
          rawAuthor['name'] ??
          rawAuthor['display_name'] ??
          rawAuthor['author'] ??
          rawAuthor['authors'];
      if (name != null && name.toString().trim().isNotEmpty) {
        final clean = name.toString().trim();
        if (!clean.startsWith('{') && !clean.startsWith('[')) {
          return clean;
        }
      }
    }

    // 2. 处理 List 结构 (多作者情况)
    if (rawAuthor is List) {
      if (rawAuthor.isEmpty) return defaultName;
      final names = <String>[];
      for (final item in rawAuthor) {
        final s = formatAuthorName(item, defaultName: '');
        if (s.isNotEmpty) names.add(s);
      }
      if (names.isNotEmpty) return names.join(', ');
      return defaultName;
    }

    // 3. 纯字符串降级处理
    final str = rawAuthor.toString().trim();
    if (str.isEmpty || str.startsWith('{') || str.startsWith('[')) {
      return defaultName;
    }
    return str;
  }

  /// 提取作者 Avatar 路径
  static String formatAuthorAvatar(dynamic rawAuthor) {
    if (rawAuthor is String) {
      final str = rawAuthor.trim();
      if (str.startsWith('{') || str.startsWith('[')) {
        try {
          final decoded = jsonDecode(str);
          return formatAuthorAvatar(decoded);
        } catch (_) {}
      }
    }
    if (rawAuthor is Map) {
      return (rawAuthor['avatar'] ??
              rawAuthor['avatar_url'] ??
              rawAuthor['icon'] ??
              '')
          .toString();
    }
    if (rawAuthor is List && rawAuthor.isNotEmpty) {
      return formatAuthorAvatar(rawAuthor.first);
    }
    return '';
  }

  /// 提取用于跳转作者主页的全量 Map 参数
  static Map<String, dynamic> formatAuthorParams(dynamic rawAuthor) {
    final name = formatAuthorName(rawAuthor, defaultName: 'Unknown Author');
    final avatar = formatAuthorAvatar(rawAuthor);

    if (rawAuthor is String) {
      final str = rawAuthor.trim();
      if (str.startsWith('{') || str.startsWith('[')) {
        try {
          final decoded = jsonDecode(str);
          return formatAuthorParams(decoded);
        } catch (_) {}
      }
    }

    if (rawAuthor is Map) {
      final map = rawAuthor.map((k, v) => MapEntry(k.toString(), v));
      map['name'] = name;
      map['avatar'] = avatar;
      return map;
    }

    if (rawAuthor is List && rawAuthor.isNotEmpty) {
      return formatAuthorParams(rawAuthor.first);
    }

    return {'id': name, 'name': name, 'avatar': avatar};
  }
}
