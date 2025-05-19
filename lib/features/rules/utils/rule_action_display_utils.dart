import 'package:flutter/material.dart';
import 'package:yourcallyourrule/core/value_objects/rule_action.dart';

/// 规则动作显示工具类
/// 提供获取动作类型名称和颜色的通用方法
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
}