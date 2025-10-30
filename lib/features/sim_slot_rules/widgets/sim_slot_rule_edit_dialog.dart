import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sim_reader/sim_reader.dart';
import 'package:yourcallyourrule/core/entities/list/list_entry.dart';
import 'package:yourcallyourrule/core/entities/rule/sim_slot_rule.dart';

import 'package:yourcallyourrule/core/value_objects/phone_number.dart';
import 'package:yourcallyourrule/core/value_objects/rule_action.dart';
import 'package:yourcallyourrule/features/common/widgets/public_select_label.dart';
import 'package:yourcallyourrule/features/device_profile/provider/sim_info_provider.dart';
import 'package:yourcallyourrule/features/rules/widgets/rule_action_selector.dart';
import 'package:yourcallyourrule/features/sim_slot_rules/services/sim_slot_rule_service.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// SIM卡槽位规则编辑/新增对话框
class SimSlotRuleEditDialog extends ConsumerStatefulWidget {
  final SimSlotRule? rule; // 为 null 表示新增
  // [修正]: simSlotIndex 变为可选，因为它只在编辑时确定
  final int? simSlotIndex;
  final Function? onRuleUpdated;
  final Color themeColor;

  const SimSlotRuleEditDialog({
    super.key,
    this.rule,
    this.simSlotIndex,
    this.onRuleUpdated,
    this.themeColor = const Color(0xFFF5A623),
  });

  @override
  ConsumerState<SimSlotRuleEditDialog> createState() => _SimSlotRuleEditDialogState();

  // [修正]: showAdd 方法不再需要 simSlotIndex 参数
  static void showAdd(
    BuildContext context, {
    Function? onRuleUpdated,
    Color themeColor = const Color(0xFFF5A623),
  }) {
    showDialog(
      context: context,
      builder: (context) => SimSlotRuleEditDialog(
        rule: null,
        onRuleUpdated: onRuleUpdated,
        themeColor: themeColor,
      ),
    );
  }

  static void showEdit(
    BuildContext context,
    SimSlotRule rule, {
    Function? onRuleUpdated,
    Color themeColor = const Color(0xFFF5A623),
  }) {
    showDialog(
      context: context,
      builder: (context) => SimSlotRuleEditDialog(
        simSlotIndex: rule.simSlotIndex, // 编辑时传入已有的 simSlotIndex
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
  
  // [新增]: 用于存储在对话框中选择的 SIM 卡索引
  int? _selectedSimSlotIndex;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.rule?.name ?? '');
    _phoneController = TextEditingController(text: widget.rule?.phoneNumber.value ?? '');
    _selectedLabelId = widget.rule?.labelId;
    _selectedAction = widget.rule?.action ?? RuleAction.block;
    // [注释]: 如果是编辑模式，则使用 widget 传入的 simSlotIndex 初始化
    _selectedSimSlotIndex = widget.simSlotIndex;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _saveRule() async {
    // [注释]: 保持输入校验
    if (_phoneController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.ruleNameAndPhoneNumberCannotBeEmpty),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // [修正]: 在新增模式下，必须选择一个 SIM 卡
    if (widget.rule == null && _selectedSimSlotIndex == null) {
       ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.selectSimCard), // 假设有这个国际化文本
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
        // [注释]: 新增规则
        final entry = ListEntry(
          id: '',
          name: _nameController.text,
          phoneNumber: PhoneNumber.fromString(_phoneController.text),
          labelId: _selectedLabelId ?? '',
        );
        // [修正]: 使用在对话框中选择的 _selectedSimSlotIndex
        await service.addSimSlotRule(entry, _selectedSimSlotIndex!, action: _selectedAction);
      } else {
        // [注释]: 编辑规则
        final updated = widget.rule!.copyWith(
          name: _nameController.text,
          phoneNumber: PhoneNumber.fromString(_phoneController.text),
          labelId: _selectedLabelId ?? '',
          action: _selectedAction,
          // [注释]: 编辑模式下 simSlotIndex 不变
        );
        await service.updateSimSlotRule(updated);
      }

      widget.onRuleUpdated?.call();

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
    final isEditing = widget.rule != null;
    final simCardsAsync = ref.watch(simCardsProvider);

    return AlertDialog(
      title: Text(isEditing 
          ? AppLocalizations.of(context)!.editRule 
          : AppLocalizations.of(context)!.addRule),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ▼▼▼▼▼ 核心修正部分 ▼▼▼▼▼
            // [修正]: 仅在新增模式下显示 SIM 卡选择器
            if (!isEditing) ...[
              Text(
                AppLocalizations.of(context)!.addRule, 
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 8),
              simCardsAsync.when(
                data: (sims) {
                  if (sims.isEmpty) {
                    return Text(AppLocalizations.of(context)!.noSimCardDetected);
                  }
                  // [注释]: 如果只有一个SIM卡，则自动选择它。
                  if (sims.length == 1 && _selectedSimSlotIndex == null) {
                     _selectedSimSlotIndex = sims.first.simSlotIndex;
                  }
                  return DropdownButtonFormField<int>(
                    initialValue: _selectedSimSlotIndex,
                    hint: Text(AppLocalizations.of(context)!.selectSimCard),
                    items: sims.map((sim) => DropdownMenuItem(
                      value: sim.simSlotIndex,
                      child: Text(sim.carrierName ?? '${AppLocalizations.of(context)!.simCard(sim.simSlotIndex! + 1)}'),
                    )).toList(), 
                    onChanged: (value) {
                      setState(() {
                        _selectedSimSlotIndex = value;
                      });
                    },
                    decoration: const InputDecoration(border: OutlineInputBorder()),
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, st) => Text('Error: $e', style: const TextStyle(color: Colors.red)),
              ),
              const SizedBox(height: 16),
            ],
            // ▲▲▲▲▲ 修正结束 ▲▲▲▲▲
            
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
      ),
      actions: [
        TextButton(
          onPressed: _isProcessing ? null : () => Navigator.pop(context),
          child: Text(AppLocalizations.of(context)!.cancelButton),
        ),
        TextButton(
          onPressed: _isProcessing ? null : _saveRule,
          child: _isProcessing
              ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
              : Text(AppLocalizations.of(context)!.save),
        ),
      ],
    );
  }
}