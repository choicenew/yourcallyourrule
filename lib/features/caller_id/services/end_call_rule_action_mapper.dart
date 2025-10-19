import 'package:flutter/material.dart';
import 'package:yourcallyourrule/core/router/app_router.dart';
import 'package:yourcallyourrule/core/value_objects/rule_action.dart';
import 'package:yourcallyourrule/features/caller_id/config/intercept_action.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 规则动作映射服务
/// 负责将RuleAction映射到具体的拦截动作
class RuleActionMapper {
  /// 将RuleAction映射为拦截动作
  ///
  /// 如果RuleAction是block类型，则根据其参数返回具体的拦截动作
  /// 如果是silence类型，则返回silenceNoAnswer
  /// 如果是none类型或其他类型，则返回null，表示使用全局默认设置
  static InterceptAction? mapToInterceptAction(RuleAction action) {
    // 根据动作类型处理
    switch (action.type) {
      case RuleActionType.block:
        // 如果没有参数，返回null表示使用全局默认设置
        if (action.parameters == null ||
            !action.parameters!.containsKey('config_interceptAction')) {
          return null;
        }

        // 从参数中获取拦截动作
        final interceptActionName =
            action.parameters!['config_interceptAction'] as String?;

        if (interceptActionName == null) {
          return null;
        }

        try {
          return InterceptAction.values.byName(interceptActionName);
        } catch (e) {
          return null;
        }

      case RuleActionType.silence:
        // silence类型直接返回silenceNoAnswer
        return InterceptAction.silenceNoAnswer;

      default:
        // 其他类型返回null
        return null;
    }
  }

  /// 创建带有拦截动作参数的Block规则动作
  static RuleAction createBlockWithInterceptAction(
      InterceptAction interceptAction) {
    return RuleAction.withParams(
        RuleActionType.block, {'config_interceptAction': interceptAction.name});
  }

  /// 获取所有可用的拦截动作
  static List<InterceptAction> getAvailableInterceptActions() {
    return InterceptAction.values;
  }

  /// 获取拦截动作的显示名称
  static String getInterceptActionDisplayName(InterceptAction interceptAction) {
    final context = AppRouter.navigatorKey.currentContext!;
    switch (interceptAction) {
      case InterceptAction.endCall:
        return AppLocalizations.of(context)!.endCallImmediately;
      case InterceptAction.answerThenHangup:
        return AppLocalizations.of(context)!.answerThenHangup;
      case InterceptAction.silenceNoAnswer:
        return AppLocalizations.of(context)!.silenceAndNoAnswer;
    }
  }
}