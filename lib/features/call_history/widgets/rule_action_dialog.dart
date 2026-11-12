import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_phone_call_history_protocol/pyro_phone_call_history_protocol.dart';
import 'package:yourcallyourrule/features/phone_rules/services/allowed_blocked_service.dart';
import 'package:yourcallyourrule/features/phone_rules/services/rule_management_service.dart';
import 'package:yourcallyourrule/features/common/value_objects/phone_number.dart';
import 'package:yourcallyourrule/features/common/value_objects/rule_action.dart';
import 'package:yourcallyourrule/features/phone_rules/utils/rule_action_display_utils.dart';
import 'package:yourcallyourrule/features/phone_rules/widgets/rule_action_selector.dart';
import 'package:yourcallyourrule/features/common/widgets/public_select_label.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

class RuleActionDialog extends ConsumerStatefulWidget {
  final CallLogEntry log;

  const RuleActionDialog({
    super.key,
    required this.log,
  });

  @override
  ConsumerState<RuleActionDialog> createState() => _RuleActionDialogState();
}

class _RuleActionDialogState extends ConsumerState<RuleActionDialog> {
  late TextEditingController _nameController;
  RuleAction _selectedAction = RuleAction.block;
  String? _selectedLabelId;
  bool _isAllowedBlockedService = true;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.log.phoneNumber);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context).addRule),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context).ruleName,
                hintText: 'Enter Rule Name',
              ),
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
            const SizedBox(height: 16),
            PublicSelectLabel(
              initialLabelId: _selectedLabelId,
              onLabelIdChanged: (labelId) {
                setState(() {
                  _selectedLabelId = labelId;
                });
              },
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text('Target List'),
                const SizedBox(width: 8),
                ChoiceChip(
                  label: Text(AppLocalizations.of(context).allowedBlockedRule),
                  selected: _isAllowedBlockedService,
                  onSelected: (selected) {
                    if (selected) {
                      setState(() {
                        _isAllowedBlockedService = true;
                      });
                    }
                  },
                ),
                const SizedBox(width: 8),
                ChoiceChip(
                  label: Text(AppLocalizations.of(context).phoneRule),
                  selected: !_isAllowedBlockedService,
                  onSelected: (selected) {
                    if (selected) {
                      setState(() {
                        _isAllowedBlockedService = false;
                      });
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(AppLocalizations.of(context).cancelButton),
        ),
        TextButton(
          onPressed: _saveRule,
          child: Text(AppLocalizations.of(context).save),
        ),
      ],
    );
  }

  Future<void> _saveRule() async {
    try {
      final name = _nameController.text.trim();
      if (name.isEmpty) {
        _showErrorSnackBar(AppLocalizations.of(context).nameCannotBeEmpty);
        return;
      }

      final phoneNumber = PhoneNumber.fromString(widget.log.phoneNumber);
      
      if (_isAllowedBlockedService) {
        await _addToAllowedBlockedRule(name, phoneNumber, _selectedAction);
      } else {
        await _addToPhoneRule(name, phoneNumber, _selectedAction);
      }
      
      if (mounted) {
        Navigator.pop(context);
      }
    } catch (e) {
      _showErrorSnackBar('${AppLocalizations.of(context).addRuleFailed}: $e');
    }
  }
  
  void _showSuccessSnackBar(String serviceName, RuleAction action) {
    if (!mounted) return;

    final actionName = RuleActionDisplayUtils.getActionTypeName(context, action.type);
    final actionColor = RuleActionDisplayUtils.getActionTypeColor(action.type);

    final message = "${AppLocalizations.of(context).addToRules} $serviceName: $actionName";

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: actionColor,
    ));
  }
  
  void _showErrorSnackBar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Future<void> _addToAllowedBlockedRule(String name, PhoneNumber phoneNumber, RuleAction action) async {
    try {
      final service = ref.read(allowedBlockedServiceProvider);
      await service.addAllowedBlockedRule(name, phoneNumber, action);
      
      final serviceName = AppLocalizations.of(context).allowedBlockedRule;
      _showSuccessSnackBar(serviceName, action);

    } catch (e) {
      rethrow;
    }
  }

  Future<void> _addToPhoneRule(String name, PhoneNumber phoneNumber, RuleAction action) async {
    try {
      final service = ref.read(ruleManagementServiceProvider);
      await service.addPhoneRule(name, phoneNumber, action);
      
      final serviceName = AppLocalizations.of(context).phoneRule;
      _showSuccessSnackBar(serviceName, action);

    } catch (e) {
      rethrow;
    }
  }
}
