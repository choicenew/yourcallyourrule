import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yourcallyourrule/core/base/base_entity.dart';
import 'package:yourcallyourrule/core/value_objects/rule_action.dart';
import 'package:yourcallyourrule/features/common/services/import_export_service_component.dart';
import 'package:yourcallyourrule/features/common/widgets/rule_management_widget.dart';
import 'package:yourcallyourrule/features/rules/utils/rule_action_display_utils.dart';

/// 通用规则管理页面组件
/// 用于处理各种类型的规则管理页面，包括黑白名单、允许/阻止规则、正则规则等
/// [T] 是规则实体类型
/// [S] 是规则服务类型
class GenericRulePage<T extends BaseEntity, S> extends StatefulWidget {
  /// 页面标题
  final String title;
  
  /// 主题颜色
  final Color themeColor;
  
  /// 空状态文本
  final String emptyText;
  
  /// 空状态图标
  final IconData emptyIcon;
  
  /// 添加按钮文本
  final String addButtonText;
  
  /// 是否使用标签筛选
  final bool useLabelFilter;
  
  /// 是否使用动作筛选
  final bool useActionFilter;
  
  /// 获取规则动作的函数
  final RuleAction? Function(T rule)? getRuleAction;
  
  /// 规则卡片构建函数
  final Widget Function(T rule) buildRuleCard;
  
  /// 添加规则对话框函数
  final void Function(BuildContext context, S service, Function refreshCallback) showAddDialog;
  
  /// 获取所有规则函数
  final Future<List<T>> Function(S service) getAllRules;
  
  /// 切换规则状态函数
  final Future<void> Function(S service, String ruleId, bool isEnabled) toggleRule;
  
  /// 删除规则函数
  final Future<void> Function(S service, String ruleId) deleteRule;
  
  /// 导入导出组件
  final ImportExportServiceComponent? importExportComponent;
  
  /// 标签筛选对话框函数
  final void Function(BuildContext context, Function(String?) onLabelSelected)? showLabelFilterDialog;

  const GenericRulePage({
    super.key,
    required this.title,
    this.themeColor = const Color(0xFFF5A623),
    required this.emptyText,
    required this.emptyIcon,
    required this.addButtonText,
    this.useLabelFilter = false,
    this.useActionFilter = false,
    this.getRuleAction,
    required this.buildRuleCard,
    required this.showAddDialog,
    required this.getAllRules,
    required this.toggleRule,
    required this.deleteRule,
    this.importExportComponent,
    this.showLabelFilterDialog,
  });

  @override
  State<GenericRulePage<T, S>> createState() => _GenericRulePageState<T, S>();
}

class _GenericRulePageState<T extends BaseEntity, S> extends State<GenericRulePage<T, S>> {
  List<T> _rules = [];
  bool _isLoading = true;
  String? _selectedLabelId;
  RuleActionType? _selectedActionType;

  @override
  void initState() {
    super.initState();
    _loadRules();
  }

  Future<void> _loadRules() async {
    setState(() {
      _isLoading = true;
    });

    final service = Provider.of<S>(context, listen: false);
    try {
      final rules = await widget.getAllRules(service);
      setState(() {
        _rules = rules;
        _isLoading = false;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('加载规则失败: $e'),
          backgroundColor: Colors.red,
        ));
      }
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _toggleRule(String ruleId, bool isEnabled) async {
    final service = Provider.of<S>(context, listen: false);
    try {
      await widget.toggleRule(service, ruleId, isEnabled);
      await _loadRules();
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('规则${isEnabled ? "启用" : "禁用"}成功'),
          backgroundColor: Colors.green,
        ));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('操作失败: $e'),
          backgroundColor: Colors.red,
        ));
      }
    }
  }

  Future<void> _deleteRule(String ruleId) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('删除规则'),
        content: Text('确定要删除这条${widget.emptyText}吗？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('删除', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
    
    if (confirmed == true) {
      final service = Provider.of<S>(context, listen: false);
      try {
        await widget.deleteRule(service, ruleId);
        await _loadRules();
        
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('规则删除成功'),
            backgroundColor: Colors.green,
          ));
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('删除失败: $e'),
            backgroundColor: Colors.red,
          ));
        }
      }
    }
  }

  void _showLabelFilterDialog() {
    if (widget.showLabelFilterDialog != null) {
      widget.showLabelFilterDialog!(context, (labelId) {
        setState(() {
          _selectedLabelId = labelId;
        });
      });
    }
  }

  void _clearLabelFilter() {
    setState(() {
      _selectedLabelId = null;
    });
  }
  
  void _showActionFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('按动作类型筛选'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('全部'),
              leading: Radio<RuleActionType?>(
                value: null,
                groupValue: _selectedActionType,
                onChanged: (value) {
                  Navigator.pop(context);
                  setState(() {
                    _selectedActionType = value;
                  });
                },
              ),
            ),
            // 使用枚举值和工具类动态生成选项
            ...[
              RuleActionType.allow,
              RuleActionType.block,
              RuleActionType.silence,
              RuleActionType.none,
            ].map((type) => ListTile(
              title: Text(RuleActionDisplayUtils.getActionTypeName(type)),
              leading: Radio<RuleActionType?>(
                value: type,
                groupValue: _selectedActionType,
                onChanged: (value) {
                  Navigator.pop(context);
                  setState(() {
                    _selectedActionType = value;
                  });
                },
              ),
            )).toList(),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          if (_selectedActionType != null)
            TextButton(
              onPressed: () {
                setState(() {
                  _selectedActionType = null;
                });
                Navigator.pop(context);
              },
              child: const Text('清除筛选'),
            ),
        ],
      ),
    );
  }
  
  void _clearActionFilter() {
    setState(() {
      _selectedActionType = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final service = Provider.of<S>(context, listen: false);
    
    // 根据标签和动作类型筛选规则
    List<T> filteredRules = _rules;
    
    // 标签筛选
    if (_selectedLabelId != null && widget.useLabelFilter) {
      filteredRules = filteredRules.where((rule) {
        // 使用动态类型访问labelId属性
        // 所有规则类型都应该有labelId属性
        final dynamic dynamicRule = rule;
        if (dynamicRule is Map) {
          return dynamicRule['labelId'] == _selectedLabelId;
        } else if (dynamicRule != null && dynamicRule.labelId != null) {
          return dynamicRule.labelId == _selectedLabelId;
        }
        return false;
      }).toList();
    }
    
    // 动作类型筛选
    if (_selectedActionType != null && widget.useActionFilter && widget.getRuleAction != null) {
      filteredRules = filteredRules.where((rule) {
        final action = widget.getRuleAction!(rule);
        return action != null && action.type == _selectedActionType;
      }).toList();
    }
    
    return RuleManagementWidget<T>(
      rules: filteredRules,
      isLoading: _isLoading,
      onLoadRules: _loadRules,
      buildRuleCard: widget.buildRuleCard,
      onAddRule: () => widget.showAddDialog(context, service, _loadRules),
      onToggleRule: _toggleRule,
      onDeleteRule: _deleteRule,
      importExportComponent: widget.importExportComponent,
      title: widget.title,
      emptyIcon: widget.emptyIcon,
      emptyText: widget.emptyText,
      addButtonText: widget.addButtonText,
      themeColor: widget.themeColor,
      useLabelFilter: widget.useLabelFilter,
      selectedLabelId: _selectedLabelId,
      onShowLabelFilter: widget.useLabelFilter ? _showLabelFilterDialog : null,
      onClearLabelFilter: widget.useLabelFilter ? _clearLabelFilter : null,
      useActionFilter: widget.useActionFilter,
      selectedActionType: _selectedActionType,
      onShowActionFilter: widget.useActionFilter ? _showActionFilterDialog : null,
      onClearActionFilter: widget.useActionFilter ? _clearActionFilter : null,
    );
  }
}