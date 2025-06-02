import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yourcallyourrule/core/entities/rule/phone_rule.dart';
import 'package:yourcallyourrule/core/value_objects/phone_number.dart';
import 'package:yourcallyourrule/features/common/widgets/public_select_label.dart';
import 'package:yourcallyourrule/features/rules/services/rule_management_service.dart';
import 'package:yourcallyourrule/features/rules/widgets/rule_action_selector.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 电话规则编辑对话框
/// 用于编辑电话规则
class PhoneRuleEditDialog extends StatefulWidget {
  final PhoneRule rule;
  final Function? onRuleUpdated;
  final Color themeColor;

  const PhoneRuleEditDialog({
    super.key,
    required this.rule,
    this.onRuleUpdated,
    this.themeColor = const Color(0xFFF5A623),
  });

  @override
  State<PhoneRuleEditDialog> createState() => _PhoneRuleEditDialogState();

  /// 显示电话规则编辑对话框的静态方法
  static void show(BuildContext context, PhoneRule rule, {Function? onRuleUpdated, Color themeColor = const Color(0xFFF5A623)}) {
    showDialog(
      context: context,
      builder: (context) => PhoneRuleEditDialog(
        rule: rule,
        onRuleUpdated: onRuleUpdated,
        themeColor: themeColor,
      ),
    );
  }
}

class _PhoneRuleEditDialogState extends State<PhoneRuleEditDialog> {
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  String? _selectedLabelId;
  late var _selectedAction;
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.rule.name);
    _phoneController = TextEditingController(text: widget.rule.phoneNumber.toString());
    _selectedLabelId = widget.rule.labelId;
    _selectedAction = widget.rule.action;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _saveRule() async {
    // 验证输入
    if (_nameController.text.isEmpty || _phoneController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('规则名称和电话号码不能为空'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isProcessing = true;
    });

    try {
      // 更新规则
      final updatedRule = PhoneRule(
        id: widget.rule.id,
        name: _nameController.text,
        phoneNumber: PhoneNumber.fromString(_phoneController.text),
        labelId: _selectedLabelId ?? '',
        action: _selectedAction,
        isEnabled: widget.rule.isEnabled,
      );

      final ruleService = Provider.of<RuleManagementService>(context, listen: false);
      await ruleService.updatePhoneNumberRule(updatedRule);

      // 调用回调函数
      if (widget.onRuleUpdated != null) {
        widget.onRuleUpdated!();
      }

      // 关闭对话框
      if (mounted) {
        Navigator.pop(context);

        // 显示成功提示
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('规则更新成功'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      // 显示错误提示
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('更新规则失败: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isProcessing = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('编辑电话规则'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: '规则名称',
              hintText: AppLocalizations.of(context)?.ruleNameHint ?? '例如：家人、朋友等',
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _phoneController,
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context)?.phoneNumber ?? '电话号码',
              hintText: AppLocalizations.of(context)?.phoneNumberHint ?? '例如：10086、12345等',
            ),
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 16),
          // 标签选择器
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
          RuleActionSelector(
            initialAction: _selectedAction,
            onActionChanged: (action) {
              setState(() {
                _selectedAction = action;
              });
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: _isProcessing ? null : () => Navigator.pop(context),
          child: Text(AppLocalizations.of(context)?.cancel ?? '取消'),
        ),
        TextButton(
          onPressed: _isProcessing ? null : _saveRule,
          child: _isProcessing
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Text(AppLocalizations.of(context)?.save ?? '保存'),
        ),
      ],
    );
  }
}