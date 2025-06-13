import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/entities/rule/phone_rule.dart';
import 'package:yourcallyourrule/core/value_objects/phone_number.dart';
import 'package:yourcallyourrule/features/common/widgets/public_select_label.dart';
import 'package:yourcallyourrule/features/rules/services/rule_management_service.dart';
import 'package:yourcallyourrule/features/rules/widgets/rule_action_selector.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';
import 'package:yourcallyourrule/core/provider/providers/rule_management_service_provider.dart';

/// 电话规则编辑对话框
/// 用于编辑电话规则
class PhoneRuleEditDialog extends ConsumerStatefulWidget {
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
  ConsumerState<PhoneRuleEditDialog> createState() => _PhoneRuleEditDialogState();

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

class _PhoneRuleEditDialogState extends ConsumerState<PhoneRuleEditDialog> {
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
          content: Text(AppLocalizations.of(context)!.ruleNameAndPhoneNumberCannotBeEmpty),
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

      final ruleService = ref.read(ruleManagementServiceProvider);
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
            content: Text(AppLocalizations.of(context)!.ruleUpdateSuccess),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      // 显示错误提示
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.updateRuleFailed(e.toString())),
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
      title: Text(AppLocalizations.of(context)!.editPhoneRule),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context)!.ruleName,
              hintText: AppLocalizations.of(context)!.exampleFamilyFriends,
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _phoneController,
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context)!.phoneNumber,
              hintText: AppLocalizations.of(context)!.examplePhoneNumber,
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
          child: Text(AppLocalizations.of(context)!.cancel),
        ),
        TextButton(
          onPressed: _isProcessing ? null : _saveRule,
          child: _isProcessing
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Text(AppLocalizations.of(context)!.save),
        ),
      ],
    );
  }
}