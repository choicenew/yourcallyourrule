import 'package:pyro_action_protocol/pyro_action_protocol.dart';

/// 关注/取消关注作者意图
class AuthorFollowIntent extends UserIntent {
  const AuthorFollowIntent(String contentId) : super(contentId);
}

/// 喜欢/取消喜欢作者意图
class AuthorLikeIntent extends UserIntent {
  const AuthorLikeIntent(String contentId) : super(contentId);
}

/// 分享作者主页意图
class AuthorShareIntent extends UserIntent {
  const AuthorShareIntent(String contentId) : super(contentId);
}

/// 翻译作者简介意图
class AuthorTranslateIntent extends UserIntent {
  const AuthorTranslateIntent(String contentId) : super(contentId);
}
