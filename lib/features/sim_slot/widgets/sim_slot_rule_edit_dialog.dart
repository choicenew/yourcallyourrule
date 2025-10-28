import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/entities/list/list_entry.dart';
import 'package:yourcallyourrule/core/entities/rule/sim_slot_rule.dart';
import 'package:yourcallyourrule/core/value_objects/phone_number.dart';
import 'package:yourcallyourrule/core/value_objects/rule_action.dart';
import 'package:yourcallyourrule/features/common/widgets/public_select_label.dart';
import 'package:yourcallyourrule/features/rules/widgets/rule_action_selector.dart';
import 'package:yourcallyourrule/features/sim_slot/services/sim_slot_rule_service.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// SIM卡槽位规则编辑/新增对话框
/// 仅在 sim_slot 特性内使用，支持新增和编辑 SimSlotRule
class SimSlotRuleEditDialog extends ConsumerStatefulWidget {
  final SimSlotRule? rule; // 为 null 表示新增
  final int simSlotIndex; // 新增时需要槽位索引
  final Function? onRuleUpdated;
  final Color themeColor;

  const SimSlotRuleEditDialog({
    super.key,
    required this.simSlotIndex,
    this.rule,
    this.onRuleUpdated,
    this.themeColor = const Color(0xFFF5A623),
  });

  @override
  ConsumerState<SimSlotRuleEditDialog> createState() => _SimSlotRuleEditDialogState();

  /// 显示新增规则对话框
  static void showAdd(
    BuildContext context,
    int simSlotIndex, {
    Function? onRuleUpdated,
    Color themeColor = const Color(0xFFF5A623),
  }) {
    showDialog(
      context: context,
      builder: (context) => SimSlotRuleEditDialog(
        simSlotIndex: simSlotIndex,
        rule: null,
        onRuleUpdated: onRuleUpdated,
        themeColor: themeColor,
      ),
    );
  }

  /// 显示编辑规则对话框
  static void showEdit(
    BuildContext context,
    SimSlotRule rule, {
    Function? onRuleUpdated,
    Color themeColor = const Color(0xFFF5A623),
  }) {
    showDialog(
      context: context,
      builder: (context) => SimSlotRuleEditDialog(
        simSlotIndex: rule.simSlotIndex,
        rule: rule,
        onRuleUpdated: onRuleUpdated,
        themeColor: themeColor,
      ),
    );
  }
}

class _SimSlotRuleEditDialogState extends ConsumerState<SimSlotRuleEditDialog> {
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  String? _selectedLabelId;
  late RuleAction _selectedAction;
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.rule?.name ?? '');
    _phoneController = TextEditingController(text: widget.rule?.phoneNumber.value ?? '');
    _selectedLabelId = widget.rule?.labelId;
    _selectedAction = widget.rule?.action ?? RuleAction.block;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _saveRule() async {
    // 校验输入
    if (_phoneController.text.isEmpty) {
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

    final service = ref.read(simSlotRuleServiceProvider);

    try {
      if (widget.rule == null) {
        // 新增
        final entry = ListEntry(
          id: '', // ListEntry 的 id 在 add 时不使用，这里给空字符串即可
          name: _nameController.text,
          phoneNumber: PhoneNumber.fromString(_phoneController.text),
          labelId: _selectedLabelId ?? '',
        );
        await service.addSimSlotRule(entry, widget.simSlotIndex, action: _selectedAction);
      } else {
        // 编辑
        final updated = widget.rule!.copyWith(
          name: _nameController.text,
          phoneNumber: PhoneNumber.fromString(_phoneController.text),
          labelId: _selectedLabelId ?? '',
          action: _selectedAction,
        );
        await service.updateSimSlotRule(updated);
      }

      // 回调与提示
      if (widget.onRuleUpdated != null) {
        widget.onRuleUpdated!();
      }

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(widget.rule == null
                ? AppLocalizations.of(context)!.ruleAddedSuccess
                : AppLocalizations.of(context)!.ruleUpdateSuccess),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
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
    final l10n = AppLocalizations.of(context)!;
    final isEditing = widget.rule != null;

    return AlertDialog(
      title: Text(isEditing ? l10n.editRule : l10n.addRule),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: l10n.ruleName,
              hintText: l10n.exampleFamilyFriends,
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _phoneController,
            decoration: InputDecoration(
              labelText: l10n.phoneNumber,
              hintText: l10n.examplePhoneNumber,
            ),
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 16),
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
          child: Text(l10n.cancelButton),
        ),
        TextButton(
          onPressed: _isProcessing ? null : _saveRule,
          child: _isProcessing
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Text(l10n.save),
        ),
      ],
    );
  }
}