import 'package:pyro_phone_call_interception_policy_protocol/pyro_phone_call_interception_policy_protocol.dart';
import 'package:yourcallyourrule/features/common/value_objects/rule_action.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 规则动作映射服务，负责将 RuleAction 映射到具体的拦截动作
class RuleActionMapper {
  static const String configInterceptActionKey = 'config_interceptAction';

  static const List<InterceptAction> availableActions = [
    InterceptAction.endCall,
    InterceptAction.answerThenHangup,
    InterceptAction.silenceNoAnswer,
  ];

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
          return availableActions.firstWhere(
            (e) => e.actionName == interceptActionName,
            orElse: () => InterceptAction.endCall,
          );
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
        RuleActionType.block, {
      configInterceptActionKey: interceptAction.actionName,
    });
  }

  static List<InterceptAction> getAvailableInterceptActions() {
    return availableActions;
  }

  static String getInterceptActionDisplayName(
    InterceptAction interceptAction, [
    AppLocalizations? l10n,
  ]) {
    if (interceptAction == InterceptAction.endCall) {
      return l10n?.endCallImmediately ?? 'End Call Immediately';
    } else if (interceptAction == InterceptAction.answerThenHangup) {
      return l10n?.answerThenHangup ?? 'Answer Then Hangup';
    } else if (interceptAction == InterceptAction.silenceNoAnswer) {
      return l10n?.silenceAndNoAnswer ?? 'Silence And No Answer';
    }
    return l10n?.endCallImmediately ?? 'End Call Immediately';
  }
}
