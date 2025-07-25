import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:yourcallyourrule/core/base/base_entity.dart';
import 'package:yourcallyourrule/core/value_objects/phone_number.dart';
import 'package:yourcallyourrule/core/value_objects/rule_action.dart';
import 'package:yourcallyourrule/features/common/widgets/public_select_label.dart';
import 'package:yourcallyourrule/features/labels/utils/label_text_utils.dart';

import 'package:yourcallyourrule/features/rules/utils/rule_action_display_utils.dart';
import 'package:yourcallyourrule/features/rules/widgets/rule_action_selector.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 通用规则详情页面
/// 用于显示规则详情，并提供编辑和删除功能
/// [T] 是规则实体类型
/// [S] 是规则服务类型
class RuleDetailPage<T extends BaseEntity, S> extends ConsumerStatefulWidget {
  final String ruleId;
  final String title;
  final Color themeColor;
  
  /// 获取规则函数
  final Future<T?> Function(S service, String ruleId) getRule;
  
  /// 更新规则函数
  final Future<void> Function(S service, T rule) updateRule;
  
  /// 删除规则函数
  final Future<void> Function(S service, String ruleId) deleteRule;
  
  /// 获取规则动作函数
  final RuleAction Function(T rule) getRuleAction;
  
  /// 设置规则动作函数
  final T Function(T rule, RuleAction action) setRuleAction;
  
  /// 从Ref获取服务的函数，用于Riverpod迁移
  final S Function(WidgetRef ref)? getServiceFromRef;

  const RuleDetailPage({
    super.key,
    required this.ruleId,
    required this.title,
    this.themeColor = const Color(0xFFF5A623),
    required this.getRule,
    required this.updateRule,
    required this.deleteRule,
    required this.getRuleAction,
    required this.setRuleAction,
    this.getServiceFromRef,
  });

  @override
  ConsumerState<RuleDetailPage<T, S>> createState() => _RuleDetailPageState<T, S>();
}

class _RuleDetailPageState<T extends BaseEntity, S> extends ConsumerState<RuleDetailPage<T, S>> {
  T? _rule;
  bool _isLoading = true;
  bool _isEditing = false;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  String? _selectedLabelId;
  RuleAction? _selectedAction;

  @override
  void initState() {
    super.initState();
    _loadRule();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _loadRule() async {
    setState(() {
      _isLoading = true;
    });

    // 使用Riverpod获取服务实例
    // 如果提供了getServiceFromRef函数，则使用它从ref获取服务
    // 这样可以确保在迁移过程中的兼容性
    final service = widget.getServiceFromRef != null 
        ? widget.getServiceFromRef!(ref) 
        : throw Exception('getServiceFromRef must be provided when using Riverpod');
    try {
      final rule = await widget.getRule(service, widget.ruleId);
      setState(() {
        _rule = rule;
        _isLoading = false;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(AppLocalizations.of(context)!.ruleLoadFailed(e.toString())),
          backgroundColor: Colors.red,
        ));
      }
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _startEditing() {
    if (_rule == null) return;

    // 获取规则的动态属性
    final dynamic dynamicRule = _rule;
    String name = '';
    String phoneNumber = '';
    String labelId = '';

    // 尝试获取属性值
    if (dynamicRule is Map) {
      name = dynamicRule['name'] ?? '';
      phoneNumber = dynamicRule['phoneNumber']?.toString() ?? '';
      labelId = dynamicRule['labelId'] ?? '';
    } else {
      name = dynamicRule.name ?? '';
      phoneNumber = dynamicRule.phoneNumber?.toString() ?? '';
      labelId = dynamicRule.labelId ?? '';
    }

    // 设置控制器值
    _nameController.text = name;
    _phoneController.text = phoneNumber;
    _selectedLabelId = labelId;
    _selectedAction = widget.getRuleAction(_rule!);

    setState(() {
      _isEditing = true;
    });
  }

  void _cancelEditing() {
    setState(() {
      _isEditing = false;
    });
  }

  Future<void> _saveRule() async {
    if (_rule == null) return;

    // 验证输入
    if (_nameController.text.isEmpty || _phoneController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(AppLocalizations.of(context)!.ruleNameRequired),
        backgroundColor: Colors.red,
      ));
      return;
    }

    try {
      // 获取规则的动态属性
      dynamic updatedRule = _rule;
      
      // 更新规则属性
      if (updatedRule is Map) {
        updatedRule['name'] = _nameController.text;
        updatedRule['phoneNumber'] = PhoneNumber.fromString(_phoneController.text);
        updatedRule['labelId'] = _selectedLabelId ?? '';
      } else {
        // 使用反射或其他方式更新属性
        updatedRule.name = _nameController.text;
        updatedRule.phoneNumber = PhoneNumber.fromString(_phoneController.text);
        updatedRule.labelId = _selectedLabelId ?? '';
      }

      // 更新规则动作
      if (_selectedAction != null) {
        updatedRule = widget.setRuleAction(updatedRule, _selectedAction!);
      }

      // 保存规则
      // 使用Riverpod获取服务实例
      final service = widget.getServiceFromRef != null 
        ? widget.getServiceFromRef!(ref) 
        : throw Exception('getServiceFromRef must be provided when using Riverpod');
      await widget.updateRule(service, updatedRule);

      setState(() {
        _rule = updatedRule;
        _isEditing = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(AppLocalizations.of(context)!.ruleUpdateSuccess),
          backgroundColor: Colors.green,
        ));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(AppLocalizations.of(context)!.ruleUpdateFailed(e.toString())),
          backgroundColor: Colors.red,
        ));
      }
    }
  }

  Future<void> _deleteRule() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.confirmDelete),
        content: Text(AppLocalizations.of(context)!.confirmDeleteRuleMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(AppLocalizations.of(context)!.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(AppLocalizations.of(context)!.deleteButton, style: const TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      // 使用Riverpod获取服务实例
      final service = widget.getServiceFromRef != null 
        ? widget.getServiceFromRef!(ref) 
        : throw Exception('getServiceFromRef must be provided when using Riverpod');
      try {
        await widget.deleteRule(service, widget.ruleId);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(AppLocalizations.of(context)!.ruleDeleteSuccess),
            backgroundColor: Colors.green,
          ));
          context.pop(); // 返回上一页
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(AppLocalizations.of(context)!.ruleDeleteFailed(e.toString())),
            backgroundColor: Colors.red,
          ));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: widget.themeColor,
        actions: [
          if (!_isEditing && _rule != null)
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: _startEditing,
              tooltip: AppLocalizations.of(context)!.editRule,
            ),
          if (!_isEditing && _rule != null)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: _deleteRule,
              tooltip: AppLocalizations.of(context)!.deleteRule,
            ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _rule == null
              ? Center(child: Text(AppLocalizations.of(context)!.ruleNotExist))
              : _isEditing
                  ? _buildEditForm()
                  : _buildRuleDetails(),
      bottomNavigationBar: _isEditing
          ? BottomAppBar(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: _cancelEditing,
                        child: Text(AppLocalizations.of(context)!.cancel),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _saveRule,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: widget.themeColor,
                        ),
                        child: Text(AppLocalizations.of(context)!.save),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : null,
    );
  }

  Widget _buildRuleDetails() {
    // 获取规则的动态属性
    final dynamic dynamicRule = _rule;
    String name = '';
    String phoneNumber = '';
    String labelId = '';

    // 尝试获取属性值
    if (dynamicRule is Map) {
      name = dynamicRule['name'] ?? '';
      phoneNumber = dynamicRule['phoneNumber']?.toString() ?? '';
      labelId = dynamicRule['labelId'] ?? '';
    } else {
      name = dynamicRule.name ?? '';
      phoneNumber = dynamicRule.phoneNumber?.toString() ?? '';
      labelId = dynamicRule.labelId ?? '';
    }

    // 获取规则动作
    final action = widget.getRuleAction(_rule!);
    final actionType = action.type;
    final actionName = RuleActionDisplayUtils.getActionTypeName(actionType);
    final actionColor = RuleActionDisplayUtils.getActionTypeColor(actionType);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.info, color: Colors.blue),
                      const SizedBox(width: 8),
                      Text(
                    AppLocalizations.of(context)!.basicInfo,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                    ],
                  ),
                  const Divider(),
                  const SizedBox(height: 8),
                  _buildInfoRow(AppLocalizations.of(context)!.ruleName, name),
                  _buildInfoRow(AppLocalizations.of(context)!.phoneNumber, phoneNumber),
                  FutureBuilder<String?>(
                    future: labelId.isNotEmpty
                        ? LabelTextUtils.getLabelTextById(context, ref, labelId)
                        : Future.value(AppLocalizations.of(context)!.none),
                    builder: (context, snapshot) {
                      return _buildInfoRow(
                        AppLocalizations.of(context)!.label,
                        snapshot.data ?? (snapshot.connectionState == ConnectionState.waiting ? AppLocalizations.of(context)!.loading : AppLocalizations.of(context)!.none),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.rule, color: actionColor),
                      const SizedBox(width: 8),
                      Text(
                        AppLocalizations.of(context)!.ruleAction,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const Divider(),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: actionColor.withValues(alpha:0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(RuleActionDisplayUtils.getActionTypeIcon(actionType), color: actionColor),
                        const SizedBox(width: 8),
                        Text(
                          actionName,
                          style: TextStyle(color: actionColor, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    RuleActionDisplayUtils.getActionTypeDescription(actionType),
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }

  Widget _buildEditForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context)!.ruleName,
              hintText: AppLocalizations.of(context)!.ruleNameHint,
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _phoneController,
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context)!.phoneNumber,
              hintText: AppLocalizations.of(context)!.phoneNumberHint,
              border: const OutlineInputBorder(),
            ),
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 16),
          Text(AppLocalizations.of(context)!.label, style: const TextStyle(fontSize: 16)),
          PublicSelectLabel(
            initialLabelId: _selectedLabelId,
            onLabelIdChanged: (labelId) {
              setState(() {
                _selectedLabelId = labelId;
              });
            },
            themeColor: widget.themeColor,
          ),
          const SizedBox(height: 16),
          Text(AppLocalizations.of(context)!.ruleAction, style: const TextStyle(fontSize: 16)),
          RuleActionSelector(
            initialAction: _selectedAction ?? const RuleAction(type: RuleActionType.block),
            onActionChanged: (action) {
              setState(() {
                _selectedAction = action;
              });
            },
          ),
        ],
      ),
    );
  }
}