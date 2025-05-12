import 'package:yourcallyourrule/core/value_objects/rule_action.dart';

/// 规则动作映射服务
/// 负责将RuleAction映射到具体的拦截动作
class RuleActionMapper {
  /// 将RuleAction映射为拦截动作字符串
  /// 
  /// 如果RuleAction是block类型，则根据其参数返回具体的拦截动作
  /// 如果没有指定参数或不是block类型，则返回null，表示使用全局默认设置
  static String? mapToInterceptAction(RuleAction action) {
    // 如果不是block类型，返回null表示不拦截
    if (action.type != RuleActionType.block) {
      return null;
    }
    
    // 如果没有参数，返回null表示使用全局默认设置
    if (action.parameters == null || !action.parameters!.containsKey('interceptAction')) {
      return null;
    }
    
    // 从参数中获取拦截动作
    final interceptAction = action.parameters!['interceptAction'] as String?;
    
    // 验证拦截动作是否有效
    if (interceptAction == null || 
        !['endCall', 'answerThenHangup', 'silenceNoAnswer'].contains(interceptAction)) {
      return null;
    }
    
    return interceptAction;
  }
  
  /// 创建带有拦截动作参数的Block规则动作
  static RuleAction createBlockWithInterceptAction(String interceptAction) {
    // 验证拦截动作是否有效
    if (!['endCall', 'answerThenHangup', 'silenceNoAnswer'].contains(interceptAction)) {
      throw ArgumentError('无效的拦截动作: $interceptAction');
    }
    
    return RuleAction.withParams(
      RuleActionType.block, 
      {'interceptAction': interceptAction}
    );
  }
  
  /// 获取所有可用的拦截动作
  static List<String> getAvailableInterceptActions() {
    return ['endCall', 'answerThenHangup', 'silenceNoAnswer'];
  }
  
  /// 获取拦截动作的显示名称
  static String getInterceptActionDisplayName(String interceptAction) {
    switch (interceptAction) {
      case 'endCall':
        return '立即结束通话';
      case 'answerThenHangup':
        return '接听后挂断';
      case 'silenceNoAnswer':
        return '静音不接听';
      default:
        return '未知动作';
    }
  }
}