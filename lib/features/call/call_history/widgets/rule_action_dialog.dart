import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:yourcallyourrule/core/entities/call/call_log.dart';
import 'package:yourcallyourrule/core/entities/list/list_entry.dart';
import 'package:yourcallyourrule/features/rules/providers/allowed_blocked_service_provider.dart';
import 'package:yourcallyourrule/core/provider/providers/rule_management_service_provider.dart';


import 'package:yourcallyourrule/core/value_objects/phone_number.dart';
import 'package:yourcallyourrule/core/value_objects/rule_action.dart';
import 'package:yourcallyourrule/features/rules/utils/rule_action_display_utils.dart';
import 'package:yourcallyourrule/features/rules/widgets/rule_action_selector.dart';
import 'package:yourcallyourrule/features/common/widgets/public_select_label.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 规则操作对话框组件 - 重构版本
/// 支持编辑name、action和label，并在添加规则时弹出对话框让用户选择服务
class RuleActionDialog extends ConsumerStatefulWidget {
  final CallLog log;

  const RuleActionDialog({super.key, required this.log});

  @override
  ConsumerState<RuleActionDialog> createState() => _RuleActionDialogState();
}

class _RuleActionDialogState extends ConsumerState<RuleActionDialog> {
  // 状态变量
  late TextEditingController _nameController;
  RuleAction _selectedAction = RuleAction.block;
  String? _selectedLabelId;
  bool _isAllowedBlockedService = true; // 默认使用AllowedBlockedService

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.log.name ?? widget.log.phoneNumber);
    _selectedLabelId = widget.log.labelIds?.isNotEmpty == true ? widget.log.labelIds!.first : null;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      // 1. 保持对话框可滚动，这是应对小屏幕的最终保障
      scrollable: true, 
      title: Text(AppLocalizations.of(context)!.addToRules),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 名称编辑
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context)!.name,
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 8),
          
          // 服务选择
          Text(
            AppLocalizations.of(context)!.selectTargetService,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          DropdownButtonFormField<bool>(
            value: _isAllowedBlockedService,
            items: [
              DropdownMenuItem(
                value: true,
                child: Text(AppLocalizations.of(context)!.allowedBlockedRule),
              ),
              DropdownMenuItem(
                value: false,
                child: Text(AppLocalizations.of(context)!.phoneRule),
              ),
            ],
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  _isAllowedBlockedService = value;
                });
              }
            },
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            ),
          ),
          
          const SizedBox(height: 8),
          
          // 动作选择器
          Text(
            AppLocalizations.of(context)!.selectAction,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          RuleActionSelector(
            initialAction: _selectedAction,
            onActionChanged: (action) {
              setState(() {
                _selectedAction = action;
              });
            },
          ),
          
          const SizedBox(height: 8),
          
          // --- 这是关键修改 ---
          // 2. 移除固定的 SizedBox(height: 220)
          // 3. 使用 Flexible 包裹 PublicSelectLabel，让其在可用空间内自由布局
          Flexible(
            child: PublicSelectLabel(
              initialLabelId: _selectedLabelId,
              phoneNumber: widget.log.phoneNumber,
              onLabelIdChanged: (labelId) {
                setState(() {
                  _selectedLabelId = labelId;
                });
              },
              themeColor: const Color(0xFFF5A623),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(AppLocalizations.of(context)!.cancelButton),
        ),
        ElevatedButton(
          onPressed: _saveRule,
          child: Text(AppLocalizations.of(context)!.save),
        ),
      ],
    );
  }

  // 保存规则
  Future<void> _saveRule() async {
    try {
      final name = _nameController.text.trim();
      if (name.isEmpty) {
        _showErrorSnackBar(AppLocalizations.of(context)!.nameCannotBeEmpty);
        return;
      }

      final entry = ListEntry(
        id: widget.log.id,
        phoneNumber: PhoneNumber(widget.log.phoneNumber),
        labelId: _selectedLabelId ?? '',
        name: name,
      );
      
      if (_isAllowedBlockedService) {
        await _addToAllowedBlockedRule(entry, _selectedAction);
      } else {
        await _addToPhoneRule(entry, _selectedAction);
      }
      
      if (mounted) {
        Navigator.pop(context);
      }
    } catch (e) {
      _showErrorSnackBar('${AppLocalizations.of(context)?.addRuleFailed}: $e');
    }
  }
  
  // 显示成功提示 (新方法)
  void _showSuccessSnackBar(String serviceName, RuleAction action) {
    if (!mounted) return;

    // 使用 RuleActionDisplayUtils 获取动态的名称和颜色
    final actionName = RuleActionDisplayUtils.getActionTypeName(context, action.type);
    final actionColor = RuleActionDisplayUtils.getActionTypeColor(action.type);

    // 构造更通用和准确的提示信息
    final message = "${AppLocalizations.of(context)!.addToRules} $serviceName: $actionName";

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: actionColor,
    ));
  }
  
  // 显示错误提示
  void _showErrorSnackBar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  // 添加到允许/阻止规则 (已修改)
  Future<void> _addToAllowedBlockedRule(ListEntry entry, RuleAction action) async {
    try {
      final service = ref.read(allowedBlockedServiceProvider);
      await service.addAllowedBlockedRule(entry, action);
      
      // 调用新的、统一的成功提示方法
      final serviceName = AppLocalizations.of(context)!.allowedBlockedRule;
      _showSuccessSnackBar(serviceName, action);

    } catch (e) {
      rethrow; // 向上抛出异常，由_saveRule统一处理
    }
  }

  // 添加到phonerule名单 (已修改)
  Future<void> _addToPhoneRule(ListEntry entry, RuleAction action) async {
    try {
      final service = ref.read(ruleManagementServiceProvider);
      await service.addPhoneRule(entry, action);
      
      // 调用新的、统一的成功提示方法
      final serviceName = AppLocalizations.of(context)!.phoneRule;
      _showSuccessSnackBar(serviceName, action);

    } catch (e) {
      rethrow; // 向上抛出异常，由_saveRule统一处理
    }
  }
}