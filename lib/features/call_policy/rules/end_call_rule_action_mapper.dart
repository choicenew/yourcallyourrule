import 'package:yourcallyourrule/features/common/router/app_router.dart';
import 'package:yourcallyourrule/features/common/value_objects/rule_action.dart';
import 'package:yourcallyourrule/features/call_policy/evaluators/intercept_action.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 规则动作映射服务，负责将 RuleAction 映射到具体的拦截动作
class RuleActionMapper {
  static const String configInterceptActionKey = 'config_interceptAction';

  static InterceptAction? mapToInterceptAction(RuleAction action) {
    switch (action.type) {
      case RuleActionType.block:
        if (action.parameters == null ||
            !action.parameters!.containsKey(configInterceptActionKey)) {
          return null;
        }

        final interceptActionName =
            action.parameters![configInterceptActionKey] as String?;

        if (interceptActionName == null) {
          return null;
        }

        try {
          return InterceptAction.values.byName(interceptActionName);
        } catch (e) {
          return null;
        }

      case RuleActionType.silence:
        return InterceptAction.silenceNoAnswer;

      default:
        return null;
    }
  }

  static RuleAction createBlockWithInterceptAction(
      InterceptAction interceptAction) {
    return RuleAction.withParams(
        RuleActionType.block, {configInterceptActionKey: interceptAction.name});
  }

  static List<InterceptAction> getAvailableInterceptActions() {
    return InterceptAction.values;
  }

  static String getInterceptActionDisplayName(InterceptAction interceptAction) {
    final context = AppRouter.navigatorKey.currentContext;
    final l10n = context != null ? AppLocalizations.of(context) : null;
    switch (interceptAction) {
      case InterceptAction.endCall:
        return l10n?.endCallImmediately ?? 'End Call Immediately';
      case InterceptAction.answerThenHangup:
        return l10n?.answerThenHangup ?? 'Answer Then Hangup';
      case InterceptAction.silenceNoAnswer:
        return l10n?.silenceAndNoAnswer ?? 'Silence And No Answer';
    }
  }
}
