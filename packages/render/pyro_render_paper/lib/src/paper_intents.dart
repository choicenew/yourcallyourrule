import 'package:pyro_action_protocol/pyro_action_protocol.dart';

export 'package:pyro_action_protocol/pyro_action_protocol.dart'
    show PaperOCRIntent, PaperPushIntent;

/// 阅读学术文献意图
class PaperReadIntent extends UserIntent {
  const PaperReadIntent(super.contentId);
}

/// 分享学术文献意图
class PaperShareIntent extends UserIntent {
  const PaperShareIntent(super.contentId);
}

/// 收藏意图
class PaperFavoriteIntent extends UserIntent {
  const PaperFavoriteIntent(super.contentId);
}

/// 引文导出意图 (BibTeX / RIS)
class PaperCitationExportIntent extends UserIntent {
  const PaperCitationExportIntent(super.contentId);
}

/// AI 智能翻译意图
class PaperTranslateAIIntent extends UserIntent {
  final String title;
  final String abstractText;
  final String keywords;
  final List<String> keywordsList;
  final String content;

  const PaperTranslateAIIntent(
    super.contentId, {
    this.title = '',
    this.abstractText = '',
    this.keywords = '',
    this.keywordsList = const [],
    this.content = '',
  });

  /// 强类型解析关键词列表，零宿主逻辑越权
  List<String> get parsedKeywords {
    if (keywordsList.isNotEmpty) return keywordsList;
    if (keywords.isEmpty) return const [];
    return keywords
        .split(RegExp(r'[,，;；\n]+'))
        .map((s) => s.trim())
        .where((s) => s.isNotEmpty)
        .toList();
  }
}

/// 引擎翻译意图
class PaperTranslateEngineIntent extends UserIntent {
  final String title;
  final String abstractText;
  final String keywords;
  final List<String> keywordsList;
  final String content;

  const PaperTranslateEngineIntent(
    super.contentId, {
    this.title = '',
    this.abstractText = '',
    this.keywords = '',
    this.keywordsList = const [],
    this.content = '',
  });
}
