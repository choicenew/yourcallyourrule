import 'dart:convert';

/// 学术论文翻译结果结构体 (全程结构化传输 DTO)
class PaperTranslationResult {
  final String? title;
  final String? abstractText;
  final List<String>? keywords;
  final String? content;

  const PaperTranslationResult({
    this.title,
    this.abstractText,
    this.keywords,
    this.content,
  });

  Map<String, dynamic> toJson() => {
    if (title != null) 'title': title,
    if (abstractText != null) 'abstractText': abstractText,
    if (keywords != null) 'keywords': keywords,
    if (content != null) 'content': content,
  };

  factory PaperTranslationResult.fromJson(Map<String, dynamic> json) {
    List<String>? cleanKeywords;
    if (json['keywords'] is List) {
      cleanKeywords = (json['keywords'] as List)
          .map((e) => PaperTranslationParser.sanitizeText(e.toString()))
          .where((s) => s.isNotEmpty && !s.startsWith('{') && !s.startsWith('['))
          .toList();
    }
    String? cleanTitle = json['title'] != null
        ? PaperTranslationParser.sanitizeText(json['title'].toString())
        : null;
    if (cleanTitle != null && (cleanTitle.isEmpty || cleanTitle.startsWith('{') || cleanTitle.startsWith('['))) {
      cleanTitle = null;
    }

    String? cleanAbstract = json['abstractText'] != null
        ? PaperTranslationParser.sanitizeText(json['abstractText'].toString())
        : null;
    if (cleanAbstract != null && (cleanAbstract.isEmpty || cleanAbstract.startsWith('{') || cleanAbstract.startsWith('['))) {
      cleanAbstract = null;
    }

    String? cleanContent = json['content'] != null
        ? PaperTranslationParser.sanitizeText(json['content'].toString())
        : null;
    if (cleanContent != null && (cleanContent.isEmpty || cleanContent.startsWith('{') || cleanContent.startsWith('['))) {
      cleanContent = null;
    }

    return PaperTranslationResult(
      title: cleanTitle,
      abstractText: cleanAbstract,
      keywords: cleanKeywords,
      content: cleanContent,
    );
  }
}

/// 学术论文翻译文本解析器
abstract class PaperTranslationParser {
  /// 强效清洗后台/网关泄露的 Raw JSON / Debug 垃圾文本
  static String sanitizeText(String input) {
    if (input.trim().isEmpty) return '';
    String text = input.trim();

    // 如果已经是规范纯文本，直接返回
    if (!text.startsWith('{') && !text.startsWith('[')) {
      return text.replaceAll(RegExp(r'^\{code:\s*\d+,\s*message:[^\}]*\}\s*'), '').trim();
    }

    // 处理 JSON 字符串
    try {
      final decoded = jsonDecode(text);
      if (decoded is Map<String, dynamic>) {
        // 1. 如果是标准的 PaperTranslationResult JSON 结构（包含 title 或 abstractText），不做剥离，保留给 parse 动态解析
        if (decoded.containsKey('abstractText') || decoded.containsKey('title')) {
          return text;
        }

        // 2. 检查常见 API 包裹字段: result, text, translatedText, data, translation, content
        if (decoded.containsKey('result')) {
          final res = decoded['result'];
          if (res is List && res.isNotEmpty) {
            final first = res.first;
            if (first is Map && first.containsKey('text')) {
              return sanitizeText(first['text'].toString());
            } else if (first is String) {
              return sanitizeText(first);
            }
          } else if (res is String) {
            return sanitizeText(res);
          } else if (res is Map && res.containsKey('text')) {
            return sanitizeText(res['text'].toString());
          }
        }
        if (decoded.containsKey('text')) {
          return sanitizeText(decoded['text'].toString());
        }
        if (decoded.containsKey('translatedText')) {
          return sanitizeText(decoded['translatedText'].toString());
        }
        if (decoded.containsKey('translation')) {
          return sanitizeText(decoded['translation'].toString());
        }
        if (decoded.containsKey('data')) {
          final data = decoded['data'];
          if (data is String) return sanitizeText(data);
          if (data is Map && data.containsKey('text')) {
            return sanitizeText(data['text'].toString());
          }
        }
      } else if (decoded is List && decoded.isNotEmpty) {
        return sanitizeText(decoded.first.toString());
      }
    } catch (_) {}

    // 若无法提取内部文本，强制移除 JSON 各种包装字符，绝对不把原生 JSON 返回给 UI 渲染
    final extracted = text.replaceAll(RegExp(r'[{}[\]"]'), '').trim();
    if (extracted.contains('code:') || extracted.contains('message:')) {
      return '';
    }
    return extracted;
  }

  static PaperTranslationResult parse(String raw) {
    if (raw.trim().isEmpty) return const PaperTranslationResult();

    final trimmed = raw.trim();

    // 1. 优先尝试原生结构化 JSON 反序列化
    if (trimmed.startsWith('{') && trimmed.endsWith('}')) {
      try {
        final decoded = jsonDecode(trimmed);
        if (decoded is Map<String, dynamic>) {
          if (decoded.containsKey('title') || decoded.containsKey('abstractText') || decoded.containsKey('keywords') || decoded.containsKey('content')) {
            return PaperTranslationResult.fromJson(decoded);
          }
        }
      } catch (_) {
        // 忽略非标准 JSON，降级至文本解析
      }
    }

    // 清洗平铺文本
    final cleanInput = sanitizeText(trimmed);
    if (cleanInput.isEmpty) return const PaperTranslationResult();

    // 2. 回退解析平铺文本
    final titleRegex = RegExp(
      r'(?:Title|标题)\s*[:：]\s*(.*?)(?=(?:Abstract|摘要|简介|Keywords|关键词|Content|正文)\s*[:：]|$)',
      dotAll: true,
      caseSensitive: false,
    );
    final absRegex = RegExp(
      r'(?:Abstract|摘要|简介)\s*[:：]\s*(.*?)(?=(?:Keywords|关键词|Content|正文)\s*[:：]|$)',
      dotAll: true,
      caseSensitive: false,
    );
    final kwRegex = RegExp(
      r'(?:Keywords|关键词)\s*[:：]\s*(.*?)(?=(?:Content|正文)\s*[:：]|$)',
      dotAll: true,
      caseSensitive: false,
    );
    final contentRegex = RegExp(
      r'(?:Content|正文)\s*[:：]\s*(.*)$',
      dotAll: true,
      caseSensitive: false,
    );

    final titleMatch = titleRegex.firstMatch(cleanInput);
    final absMatch = absRegex.firstMatch(cleanInput);
    final kwMatch = kwRegex.firstMatch(cleanInput);
    final contentMatch = contentRegex.firstMatch(cleanInput);

    String? parsedTitle;
    String? parsedAbstract;
    List<String>? parsedKeywords;
    String? parsedContent;

    if (titleMatch != null && titleMatch.group(1) != null) {
      final t = sanitizeText(titleMatch.group(1)!);
      if (t.isNotEmpty) parsedTitle = t;
    }
    if (absMatch != null && absMatch.group(1) != null) {
      final a = sanitizeText(absMatch.group(1)!);
      if (a.isNotEmpty) parsedAbstract = a;
    }
    if (kwMatch != null && kwMatch.group(1) != null) {
      final kwStr = sanitizeText(kwMatch.group(1)!);
      if (kwStr.isNotEmpty) {
        parsedKeywords =
            kwStr
                .split(RegExp(r'[,，、;；·・•|/\n\r\t]+'))
                .map((s) => sanitizeText(s))
                .where((s) => s.isNotEmpty)
                .toList();
      }
    }
    if (contentMatch != null && contentMatch.group(1) != null) {
      final c = sanitizeText(contentMatch.group(1)!);
      if (c.isNotEmpty) parsedContent = c;
    }

    // 若未匹配到任何规范标签，仅当 cleanInput 纯粹是合法非 JSON 文本时，才放入 abstractText
    if (parsedTitle == null &&
        parsedAbstract == null &&
        parsedKeywords == null &&
        parsedContent == null) {
      if (!cleanInput.startsWith('{') && !cleanInput.startsWith('[')) {
        parsedAbstract = cleanInput;
      }
    }

    return PaperTranslationResult(
      title: parsedTitle,
      abstractText: parsedAbstract,
      keywords: parsedKeywords,
      content: parsedContent,
    );
  }
}
