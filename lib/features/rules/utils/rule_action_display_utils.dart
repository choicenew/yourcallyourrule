import 'package:flutter/material.dart';
import 'package:yourcallyourrule/core/value_objects/rule_action.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 规则动作显示工具类
/// 提供获取动作类型名称、颜色、图标和描述的通用方法
class RuleActionDisplayUtils {
  /// 获取动作类型名称
  static String getActionTypeName(BuildContext context, RuleActionType type) {
 
    switch (type) {
      case RuleActionType.allow:
        return AppLocalizations.of(context)!.allow;
      case RuleActionType.block:
        return AppLocalizations.of(context)!.block;
      case RuleActionType.silence:
        return AppLocalizations.of(context)!.silence;
      case RuleActionType.none:
        return AppLocalizations.of(context)!.noAction;
      case RuleActionType.redirect:
        return AppLocalizations.of(context)!.redirect;
      case RuleActionType.label:
        return AppLocalizations.of(context)!.label;
      case RuleActionType.notify:
        return AppLocalizations.of(context)!.notify;
      case RuleActionType.log:
        return AppLocalizations.of(context)!.log;
      case RuleActionType.custom:
        return AppLocalizations.of(context)!.custom;
    }
  }
  
  /// 获取动作类型颜色
  static Color getActionTypeColor(RuleActionType type) {
    switch (type) {
      case RuleActionType.allow:
        return Colors.green;
      case RuleActionType.block:
        return Colors.red;
      case RuleActionType.silence:
        return Colors.orange;
      case RuleActionType.none:
        return Colors.grey;
      case RuleActionType.redirect:
        return Colors.blue;
      case RuleActionType.label:
        return Colors.purple;
      case RuleActionType.notify:
        return Colors.teal;
      case RuleActionType.log:
        return Colors.brown;
      case RuleActionType.custom:
        return Colors.deepPurple;
    }
  }

  /// 获取动作类型图标
  static IconData getActionTypeIcon(RuleActionType type) {
    switch (type) {
      case RuleActionType.allow:
        return Icons.check_circle;
      case RuleActionType.block:
        return Icons.block;
      case RuleActionType.silence:
        return Icons.volume_off;
      case RuleActionType.none:
        return Icons.remove_circle_outline;
      case RuleActionType.redirect:
        return Icons.call_to_action;
      case RuleActionType.label:
        return Icons.label;
      case RuleActionType.notify:
        return Icons.notifications;
      case RuleActionType.log:
        return Icons.note;
      case RuleActionType.custom:
        return Icons.settings;
    }
  }

  /// 获取动作类型描述
  static String getActionTypeDescription(BuildContext context, RuleActionType type) {
 
    switch (type) {
      case RuleActionType.allow:
        return AppLocalizations.of(context)!.allowActionDescription;
      case RuleActionType.block:
        return AppLocalizations.of(context)!.blockActionDescription;
      case RuleActionType.silence:
        return AppLocalizations.of(context)!.silenceActionDescription;
      case RuleActionType.none:
        return AppLocalizations.of(context)!.noneActionDescription;
      case RuleActionType.redirect:
        return AppLocalizations.of(context)!.redirectActionDescription;
      case RuleActionType.label:
        return AppLocalizations.of(context)!.labelActionDescription;
      case RuleActionType.notify:
        return AppLocalizations.of(context)!.notifyActionDescription;
      case RuleActionType.log:
        return AppLocalizations.of(context)!.logActionDescription;
      case RuleActionType.custom:
        return AppLocalizations.of(context)!.customActionDescription;
    }
  }
}