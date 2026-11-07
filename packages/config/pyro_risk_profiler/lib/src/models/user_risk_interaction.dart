/// 用户交互意图定义
enum RiskInteractionIntent {
  viewDetail,
  inspect, // 放大/细看 (强意图)
  openAuthor,
  save,
  setWallpaper,
  share,
  collect,
  like,
  other,
}

/// 用户交互打分输入模型 (纯 Dart，不依赖特定 App 的 Entity)
class UserRiskInteraction {
  final String? interactionId;
  final String? contentId;
  final String? providerId;
  final List<String> tags;
  final RiskInteractionIntent intent;
  final int viewDurationMillis;
  final bool isDownloaded;
  final bool isFollowedAuthor;
  final DateTime timestamp;
  final Map<String, dynamic> extras;

  UserRiskInteraction({
    this.interactionId,
    this.contentId,
    this.providerId,
    this.tags = const [],
    this.intent = RiskInteractionIntent.viewDetail,
    this.viewDurationMillis = 0,
    this.isDownloaded = false,
    this.isFollowedAuthor = false,
    DateTime? timestamp,
    this.extras = const {},
  }) : timestamp = timestamp ?? DateTime.now();
}
