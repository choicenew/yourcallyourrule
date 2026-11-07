import 'dart:convert';

/// 动态文本与词条降序转译引擎 (Dynamic Text & Length-Descending Translator)
/// 专为处理第三方 API、数据源、Hetu 脚本及动态数据产生的原生词条与长句而设计
class DynamicTextTranslator {
  final String localeCode;
  final Map<String, String> _dict;
  final Map<String, String>? _fallbackDict;
  final List<MapEntry<String, String>> _sortedEntries;

  DynamicTextTranslator({
    required this.localeCode,
    required Map<String, String> dict,
    Map<String, String>? fallbackDict,
  })  : _dict = Map.unmodifiable(dict),
        _fallbackDict = fallbackDict != null ? Map.unmodifiable(fallbackDict) : null,
        _sortedEntries = _buildSortedEntries(dict, fallbackDict);

  /// 构建按词条 Key 长度降序排列的条目列表（长词优先，彻底防止短词切碎长词）
  static List<MapEntry<String, String>> _buildSortedEntries(
    Map<String, String> dict,
    Map<String, String>? fallbackDict,
  ) {
    final combined = <String, String>{};
    if (fallbackDict != null) {
      combined.addAll(fallbackDict);
    }
    combined.addAll(dict);
    final list = combined.entries.toList();
    // 按词条 Key 字符长度从大到小降序排列 (Greedy Longest-Match)
    list.sort((a, b) => b.key.length.compareTo(a.key.length));
    return list;
  }

  /// O(1) 精确翻译单一术语/标签
  String translateTerm(String? term) {
    if (term == null || term.isEmpty) return term ?? '';
    if (isNativeChinese) return term;
    return _dict[term] ?? _fallbackDict?[term] ?? term;
  }

  /// 判断当前语言是否为原生中文（简体/默认中文直通，零 CPU/内存/正则开销）
  bool get isNativeChinese =>
      localeCode == 'zh' || localeCode == 'zh_CN' || localeCode.startsWith('zh_');

  /// 全量动态长文本转译（长词优先替换）
  String translateDynamicText(String rawText) {
    if (rawText.isEmpty || isNativeChinese) return rawText;

    var result = rawText;

    // 严密按中文/源词条长度降序依次替换，长词优先、零遗漏、零切碎
    for (final entry in _sortedEntries) {
      if (entry.key.isNotEmpty && result.contains(entry.key)) {
        result = result.replaceAll(entry.key, entry.value);
      }
    }

    return result.replaceAll(RegExp(r'\s+'), ' ').trim();
  }

  /// 从 JSON 字符串合并加载扩展领域词典
  DynamicTextTranslator mergeJsonDomain(String jsonStr) {
    try {
      final decoded = json.decode(jsonStr) as Map<String, dynamic>;
      final newDict = Map<String, String>.from(_dict);
      decoded.forEach((k, v) {
        if (v is String) newDict[k] = v;
      });
      return DynamicTextTranslator(
        localeCode: localeCode,
        dict: newDict,
        fallbackDict: _fallbackDict,
      );
    } catch (_) {
      return this;
    }
  }
}
