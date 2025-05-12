import 'package:flutter/material.dart';
import 'package:yourcallyourrule/core/value_objects/rule_action.dart';
import 'package:yourcallyourrule/features/caller_id/services/rule_action_mapper.dart';

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
          title: const Text('规则动作'),
          subtitle: const Text('选择当规则匹配时要执行的动作'),
          trailing: DropdownButton<RuleActionType>(
            value: _currentAction.type,
            onChanged: _onActionTypeChanged,
            items: const [
              DropdownMenuItem(
                value: RuleActionType.allow,
                child: Text('允许'),
              ),
              DropdownMenuItem(
                value: RuleActionType.block,
                child: Text('阻止'),
              ),
            ],
          ),
        ),
        
        // 如果选择了阻止动作，显示拦截动作选择器
        if (_currentAction.type == RuleActionType.block)
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: ListTile(
              title: const Text('拦截动作'),
              subtitle: const Text('选择当阻止来电时要执行的具体动作'),
              trailing: DropdownButton<String>(
                value: _selectedInterceptAction,
                hint: const Text('使用全局设置'),
                onChanged: _onInterceptActionChanged,
                items: [
                  // 添加一个null选项，表示使用全局设置
                  const DropdownMenuItem<String>(
                    value: null,
                    child: Text('使用全局设置'),
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
    
    setState(() {
      if (type == RuleActionType.allow) {
        _currentAction = RuleAction.allow;
        _selectedInterceptAction = null;
      } else if (type == RuleActionType.block) {
        // 如果之前已经选择了拦截动作，保留它
        if (_selectedInterceptAction != null) {
          _currentAction = RuleAction.withParams(
            RuleActionType.block,
            {'interceptAction': _selectedInterceptAction},
          );
        } else {
          _currentAction = RuleAction.block;
        }
      }
    });
    
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