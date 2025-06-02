import 'package:flutter/material.dart';
import 'package:yourcallyourrule/core/value_objects/rule_action.dart';

/// 规则动作显示工具类
/// 提供获取动作类型名称、颜色、图标和描述的通用方法
class RuleActionDisplayUtils {
  /// 获取动作类型名称
  static String getActionTypeName(RuleActionType type) {
    switch (type) {
      case RuleActionType.allow:
        return '允许';
      case RuleActionType.block:
        return '阻止';
      case RuleActionType.silence:
        return '静音';
      case RuleActionType.none:
        return '无动作';
      case RuleActionType.redirect:
        return '重定向';
      case RuleActionType.label:
        return '标记';
      case RuleActionType.notify:
        return '通知';
      case RuleActionType.log:
        return '记录';
      case RuleActionType.custom:
        return '自定义';
      default:
        return '未知';
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
      default:
        return Colors.grey;
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
      default:
        return Icons.help_outline;
    }
  }

  /// 获取动作类型描述
  static String getActionTypeDescription(RuleActionType type) {
    switch (type) {
      case RuleActionType.allow:
        return '来电将被允许通过，即使号码在黑名单中';
      case RuleActionType.block:
        return '来电将被拦截，会显示在通话记录中';
      case RuleActionType.silence:
        return '来电将被静音，但会显示在通话记录中';
      case RuleActionType.none:
        return '不对来电执行任何特殊操作';
      case RuleActionType.redirect:
        return '将来电重定向到指定号码';
      case RuleActionType.label:
        return '为来电添加标签，便于识别';
      case RuleActionType.notify:
        return '收到来电时发送通知';
      case RuleActionType.log:
        return '记录来电信息，但不执行其他操作';
      case RuleActionType.custom:
        return '执行自定义操作';
      default:
        return '未知动作类型';
    }
  }
}