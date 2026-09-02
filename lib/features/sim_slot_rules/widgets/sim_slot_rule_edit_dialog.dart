import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/entities/list/list_entry.dart';
import 'package:yourcallyourrule/core/entities/rule/sim_slot_rule.dart';
import 'package:yourcallyourrule/core/value_objects/phone_number.dart';
import 'package:yourcallyourrule/core/value_objects/rule_action.dart';
import 'package:yourcallyourrule/features/common/widgets/public_select_label.dart';
import 'package:yourcallyourrule/features/device_profile/provider/sim_info_provider.dart';
import 'package:yourcallyourrule/features/home_elite/theme/elite_dopamine_theme.dart';
import 'package:yourcallyourrule/features/rules/widgets/rule_action_selector.dart';
import 'package:yourcallyourrule/features/sim_slot_rules/services/sim_slot_rule_service.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// SIM卡槽位规则编辑/新增对话框 (Elite Dopamine 现代视觉规范)
class SimSlotRuleEditDialog extends ConsumerStatefulWidget {
  final SimSlotRule? rule;
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
  int? _selectedSimSlotIndex;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.rule?.name ?? '');
    _phoneController = TextEditingController(text: widget.rule?.phoneNumber.value ?? '');
    _selectedLabelId = widget.rule?.labelId;
    _selectedAction = widget.rule?.action ?? RuleAction.block;
    _selectedSimSlotIndex = widget.simSlotIndex;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _saveRule() async {
    final l10n = AppLocalizations.of(context)!;
    if (_phoneController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.phoneNumberCannotBeEmpty),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    if (widget.rule == null && _selectedSimSlotIndex == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.selectSimCard),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    setState(() {
      _isProcessing = true;
    });

    try {
      final service = ref.read(simSlotRuleServiceProvider);

      if (widget.rule == null) {
        final entry = ListEntry(
          name: _nameController.text,
          phoneNumber: PhoneNumber.fromString(_phoneController.text),
          labelId: _selectedLabelId ?? '',
        );
        await service.addSimSlotRule(entry, _selectedSimSlotIndex!, action: _selectedAction);
      } else {
        final updated = widget.rule!.copyWith(
          name: _nameController.text,
          phoneNumber: PhoneNumber.fromString(_phoneController.text),
          labelId: _selectedLabelId ?? '',
          action: _selectedAction,
        );
        await service.updateSimSlotRule(updated);
      }

      widget.onRuleUpdated?.call();

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(widget.rule == null
                ? l10n.ruleAddedSuccess
                : l10n.ruleUpdateSuccess),
            backgroundColor: EliteDopamineTheme.freshMint,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.updateRuleFailed(e.toString())),
            backgroundColor: Colors.redAccent,
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
    final simCardsAsync = ref.watch(simCardsProvider);

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      title: Text(
        isEditing ? l10n.editRule : l10n.addRule,
        style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ▼▼▼▼▼ 核心修正部分 ▼▼▼▼▼
            // [修正]: 仅在新增模式下显示 SIM 卡选择器
            if (!isEditing) ...[
              Text(
                l10n.selectSimCard, 
                style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
              ),
              const SizedBox(height: 8),
              simCardsAsync.when(
                data: (sims) {
                  if (sims.isEmpty) {
                    return Text(l10n.noSimCardDetected, style: TextStyle(color: Colors.grey[600], fontSize: 12));
                  }
                  // [注释]: 如果只有一个SIM卡，则自动选择它。
                  if (sims.length == 1 && _selectedSimSlotIndex == null) {
                    _selectedSimSlotIndex = sims.first.simSlotIndex;
                  }
                  return DropdownButtonFormField<int>(
                    initialValue: _selectedSimSlotIndex,
                    hint: Text(l10n.selectSimCard),
                    items: sims.map((sim) => DropdownMenuItem(
                      value: sim.simSlotIndex,
                      child: Text(sim.carrierName ?? '${l10n.simCard((sim.simSlotIndex ?? 0) + 1)}'),
                    )).toList(), 
                    onChanged: (value) {
                      setState(() {
                        _selectedSimSlotIndex = value;
                      });
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFFF7F5F0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(color: Color(0xFFEDE8DF)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(color: Color(0xFFEDE8DF)),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                    ),
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, st) => Text('Error: $e', style: const TextStyle(color: Colors.redAccent)),
              ),
              const SizedBox(height: 14),
            ],
            // ▲▲▲▲▲ 修正结束 ▲▲▲▲▲
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: l10n.ruleName,
                hintText: l10n.exampleFamilyFriends,
                filled: true,
                fillColor: const Color(0xFFF7F5F0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(color: Color(0xFFEDE8DF)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(color: Color(0xFFEDE8DF)),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              ),
            ),
            const SizedBox(height: 14),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: l10n.phoneNumber,
                hintText: l10n.examplePhoneNumber,
                filled: true,
                fillColor: const Color(0xFFF7F5F0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(color: Color(0xFFEDE8DF)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(color: Color(0xFFEDE8DF)),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 14),
            PublicSelectLabel(
              initialLabelId: _selectedLabelId,
              onLabelIdChanged: (labelId) {
                setState(() {
                  _selectedLabelId = labelId;
                });
              },
              themeColor: widget.themeColor,
            ),
            const SizedBox(height: 14),
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
          child: Text(l10n.cancelButton, style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.w700)),
        ),
        ElevatedButton(
          onPressed: _isProcessing ? null : _saveRule,
          style: ElevatedButton.styleFrom(
            backgroundColor: widget.themeColor,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            elevation: 0,
          ),
          child: _isProcessing
              ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
              : Text(l10n.save, style: const TextStyle(fontWeight: FontWeight.w800)),
        ),
      ],
    );
  }
}