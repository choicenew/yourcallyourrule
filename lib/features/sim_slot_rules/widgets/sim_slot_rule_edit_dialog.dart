import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_phone_rules_protocol/pyro_phone_rules_protocol.dart';
import 'package:yourcallyourrule/features/common/value_objects/rule_action.dart';
import 'package:yourcallyourrule/features/common/widgets/public_select_label.dart';
import 'package:yourcallyourrule/features/device_profile/provider/sim_info_provider.dart';
import 'package:yourcallyourrule/features/phone_rules/widgets/rule_action_selector.dart';
import 'package:yourcallyourrule/features/sim_slot_rules/services/sim_slot_rule_service.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

class SimSlotRuleEditDialog extends ConsumerStatefulWidget {
  final SimSlotRuleEntity? rule;
  final int? simSlotIndex;
  final Function? onRuleUpdated;
  final Color? themeColor;

  const SimSlotRuleEditDialog({
    super.key,
    this.rule,
    this.simSlotIndex,
    this.onRuleUpdated,
    this.themeColor,
  });

  @override
  ConsumerState<SimSlotRuleEditDialog> createState() => _SimSlotRuleEditDialogState();
}

class _SimSlotRuleEditDialogState extends ConsumerState<SimSlotRuleEditDialog> {
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  String? _selectedLabelId;
  RuleAction _selectedAction = const RuleAction(type: RuleActionType.block);
  int? _selectedSimSlotIndex;
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.rule?.name ?? '');
    _phoneController = TextEditingController(text: widget.rule?.phoneNumber ?? '');
    _selectedLabelId = widget.rule?.labelId;
    _selectedSimSlotIndex = widget.simSlotIndex ?? widget.rule?.simSlotIndex ?? 0;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _saveRule() async {
    final l10n = AppLocalizations.of(context);

    if (_selectedSimSlotIndex == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.selectSimCard)),
      );
      return;
    }

    setState(() {
      _isProcessing = true;
    });

    try {
      final service = ref.read(simSlotRuleServiceProvider);

      if (widget.rule == null) {
        final entry = {
          'name': _nameController.text,
          'phoneNumber': _phoneController.text,
          'labelId': _selectedLabelId ?? '',
        };
        await service.addSimSlotRule(entry, _selectedSimSlotIndex!, action: _selectedAction);
      } else {
        final updated = widget.rule!.copyWith(
          simSlotIndex: _selectedSimSlotIndex!,
          phoneNumber: _phoneController.text,
          labelId: _selectedLabelId ?? '',
        );
        await service.updateSimSlotRule(updated);
      }

      widget.onRuleUpdated?.call();

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.ruleSavedSuccessfully)),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${l10n.operationFailure}: $e')),
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
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final simInfoAsync = ref.watch(simInfoProvider);

    return AlertDialog(
      title: Text(widget.rule == null ? l10n.addSimSlotRule : l10n.editSimSlotRule),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: l10n.ruleName,
                hintText: l10n.enterRuleName,
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: l10n.phoneNumber,
                hintText: l10n.enterPhoneNumber,
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 12),
            simInfoAsync.when(
              data: (simList) {
                if (simList.isEmpty) {
                  return const SizedBox.shrink();
                }
                return DropdownButtonFormField<int>(
                  value: _selectedSimSlotIndex,
                  decoration: InputDecoration(labelText: l10n.simCardSlot),
                  items: simList.map((sim) {
                    return DropdownMenuItem<int>(
                      value: sim.simSlotIndex ?? 0,
                      child: Text(sim.carrierName ?? l10n.simCard((sim.simSlotIndex ?? 0) + 1)),
                    );
                  }).toList(),
                  onChanged: (val) {
                    setState(() {
                      _selectedSimSlotIndex = val;
                    });
                  },
                );
              },
              loading: () => const CircularProgressIndicator(),
              error: (_, __) => const SizedBox.shrink(),
            ),
            const SizedBox(height: 12),
            PublicSelectLabel(
              initialLabelId: _selectedLabelId,
              onLabelIdChanged: (id) {
                setState(() {
                  _selectedLabelId = id;
                });
              },
              themeColor: widget.themeColor ?? theme.colorScheme.primary,
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
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.cancelButton),
        ),
        ElevatedButton(
          onPressed: _isProcessing ? null : _saveRule,
          child: _isProcessing
              ? const CircularProgressIndicator()
              : Text(l10n.save),
        ),
      ],
    );
  }
}
