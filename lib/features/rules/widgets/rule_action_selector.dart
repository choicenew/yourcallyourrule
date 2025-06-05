import 'package:flutter/material.dart';
import 'package:yourcallyourrule/core/value_objects/rule_action.dart';
import 'package:yourcallyourrule/features/caller_id/services/rule_action_mapper.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 规则动作选择器
/// 用于在创建或编辑规则时选择规则动作和拦截动作
class RuleActionSelector extends StatefulWidget {
  /// 当前选择的规则动作
  final RuleAction initialAction;
  
  /// 当规则动作改变时的回调
  final ValueChanged<RuleAction> onActionChanged;
  
  const RuleActionSelector({
    super.key,
    required this.initialAction,
    required this.onActionChanged,
  });

  @override
  State<RuleActionSelector> createState() => _RuleActionSelectorState();
}

class _RuleActionSelectorState extends State<RuleActionSelector> {
  late RuleAction _currentAction;
  String? _selectedInterceptAction;
  
  @override
  void initState() {
    super.initState();
    _currentAction = widget.initialAction;
    
    // 如果是block类型，尝试从参数中获取拦截动作
    if (_currentAction.type == RuleActionType.block && 
        _currentAction.parameters != null &&
        _currentAction.parameters!.containsKey('interceptAction')) {
      _selectedInterceptAction = _currentAction.parameters!['interceptAction'] as String?;
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 规则动作选择
        ListTile(
          title: Text(AppLocalizations.of(context)!.ruleAction),
          subtitle: Text(AppLocalizations.of(context)!.selectActionWhenRuleMatches),
          trailing: DropdownButton<RuleActionType>(
            value: _currentAction.type,
            onChanged: _onActionTypeChanged,
            items: [
              DropdownMenuItem(
                value: RuleActionType.allow,
                child: Text(AppLocalizations.of(context)!.allow),
              ),
              DropdownMenuItem(
                value: RuleActionType.block,
                child: Text(AppLocalizations.of(context)!.block),
              ),
              DropdownMenuItem(
                value: RuleActionType.silence,
                child: Text(AppLocalizations.of(context)!.silence),
              ),
              DropdownMenuItem(
                value: RuleActionType.none,
                child: Text(AppLocalizations.of(context)!.noAction),
              ),
            ],
          ),
        ),
        
        // 如果选择了阻止动作，显示拦截动作选择器
        if (_currentAction.type == RuleActionType.block)
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: ListTile(
              title: Text(AppLocalizations.of(context)!.interceptAction),
              subtitle: Text(AppLocalizations.of(context)!.selectActionWhenBlockingCalls),
              trailing: DropdownButton<String>(
                value: _selectedInterceptAction,
                hint: Text(AppLocalizations.of(context)!.useGlobalSettings),
                onChanged: _onInterceptActionChanged,
                items: [
                  // 添加一个null选项，表示使用全局设置
                  DropdownMenuItem<String>(
                    value: null,
                    child: Text(AppLocalizations.of(context)!.useGlobalSettings),
                  ),
                  // 添加所有可用的拦截动作
                  ...RuleActionMapper.getAvailableInterceptActions().map((action) {
                    return DropdownMenuItem<String>(
                      value: action,
                      child: Text(RuleActionMapper.getInterceptActionDisplayName(action)),
                    );
                  }),
                ],
              ),
            ),
          ),
      ],
    );
  }
  
  /// 当规则动作类型改变时的处理
  void _onActionTypeChanged(RuleActionType? type) {
    if (type == null) return;
    
    // 根据选择的动作类型创建新的动作对象
    RuleAction newAction;
    switch (type) {
      case RuleActionType.block:
        // 如果选择了阻止动作，保留之前的拦截动作参数
        if (_selectedInterceptAction != null) {
          newAction = RuleAction.withParams(
            type, 
            {'interceptAction': _selectedInterceptAction!}
          );
        } else {
          newAction = RuleAction(type: type);
        }
        break;
      case RuleActionType.silence:
        // 如果选择了静音动作，使用预定义的silence常量
        newAction = RuleAction.silence;
        break;
      case RuleActionType.none:
        // 如果选择了无动作，使用预定义的none常量
        newAction = RuleAction.none;
        break;
      case RuleActionType.allow:
        // 如果选择了允许动作，使用预定义的allow常量
        newAction = RuleAction.allow;
        break;
      default:
        // 其他动作类型使用默认构造函数
        newAction = RuleAction(type: type);
    }
    
    setState(() {
      _currentAction = newAction;
      // 只有在选择block类型时才显示拦截动作选择器
      if (type != RuleActionType.block) {
        _selectedInterceptAction = null;
      }
    });
    
    // 通知父组件动作已更改
    widget.onActionChanged(_currentAction);
  }

  
  /// 当拦截动作改变时的处理
  void _onInterceptActionChanged(String? action) {
    setState(() {
      _selectedInterceptAction = action;
      
      // 更新当前动作
      if (action == null) {
        _currentAction = RuleAction.block;
      } else {
        _currentAction = RuleAction.withParams(
          RuleActionType.block,
          {'interceptAction': action},
        );
      }
    });
    
    widget.onActionChanged(_currentAction);
  }
  }