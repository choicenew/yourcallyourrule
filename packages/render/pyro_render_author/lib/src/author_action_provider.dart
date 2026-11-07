import 'package:material_ui/material_ui.dart';
import 'l10n/generated/app_localizations.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_action_hub/pyro_action_hub.dart';
import 'package:pyro_action_protocol/pyro_action_protocol.dart';
import 'package:pyro_media_models/pyro_media_models.dart';

import 'author_intents.dart';

part 'author_action_provider.g.dart';

@Riverpod(keepAlive: true)
class AuthorActions extends _$AuthorActions implements ActionProvider {
  final Map<String, bool> _followStates = {};
  final Map<String, bool> _likeStates = {};

  @override
  List<UserAction> build(String contentId) {
    final isFollowing = _followStates[contentId] ?? false;
    final isLiked = _likeStates[contentId] ?? false;

    return [
      UserAction(
        id: ActionId.follow,
        icon:
            isFollowing
                ? Icons.person_remove_rounded
                : Icons.person_add_rounded,
        label: isFollowing ? 'Following' : 'Follow',
        isActive: isFollowing,
        intent: AuthorFollowIntent(contentId),
        order: 1,
      ),
      UserAction(
        id: ActionId.like,
        icon: isLiked ? Icons.favorite_rounded : Icons.favorite_border_rounded,
        label: isLiked ? 'Liked' : 'Like',
        isActive: isLiked,
        intent: AuthorLikeIntent(contentId),
        order: 2,
      ),
      UserAction(
        id: ActionId.share,
        icon: Icons.share_rounded,
        label: 'Share',
        intent: AuthorShareIntent(contentId),
        order: 3,
      ),
      UserAction(
        id: ActionId.translate,
        icon: Icons.translate_rounded,
        label: 'Translate',
        intent: AuthorTranslateIntent(contentId),
        order: 4,
      ),
    ];
  }

  @override
  Stream<List<UserAction>> watchActions(String contentId, {MediaEntity? entity}) {
    return Stream.value(build(contentId));
  }

  @override
  void handleIntent(UserIntent intent) {
    final contentId = intent.contentId;

    if (intent is AuthorFollowIntent || intent is GenericFollowIntent) {
      final newState = !(_followStates[contentId] ?? false);
      _followStates[contentId] = newState;
      ref.invalidateSelf();
      emitActionEffect(
        ToastEffect((context) => AppLocalizations.of(context)?.followedMessage ?? 'Followed'),
      );
    } else if (intent is AuthorLikeIntent) {
      final newState = !(_likeStates[contentId] ?? false);
      _likeStates[contentId] = newState;
      ref.invalidateSelf();
      emitActionEffect(
        ToastEffect((context) => AppLocalizations.of(context)?.like ?? 'Like'),
      );
    } else if (intent is AuthorShareIntent) {
      emitActionEffect(ToastEffect((context) => AppLocalizations.of(context)?.share ?? 'Share'));
    } else if (intent is AuthorTranslateIntent) {
      emitActionEffect(ToastEffect((context) => AppLocalizations.of(context)?.translate ?? 'Translate'));
    }
  }
}
