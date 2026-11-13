import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_phone_rules_protocol/pyro_phone_rules_protocol.dart';
import 'package:yourcallyourrule/features/common/widgets/public_select_label.dart';
import 'package:yourcallyourrule/features/phone_rules/widgets/rule_action_selector.dart';
import 'package:yourcallyourrule/features/phone_rules/utils/rule_action_display_utils.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';
import 'package:yourcallyourrule/features/phone_rules/services/rule_management_service.dart';

class PhoneRuleEditDialog extends ConsumerStatefulWidget {
  final PhoneRuleEntity rule;
  final Function? onRuleUpdated;
  final Color? themeColor;

  const PhoneRuleEditDialog({
    super.key,
    required this.rule,
    this.onRuleUpdated,
    this.themeColor,
  });

  @override
  ConsumerState<PhoneRuleEditDialog> createState() => _PhoneRuleEditDialogState();

  static void show(BuildContext context, PhoneRuleEntity rule, {Function? onRuleUpdated, Color? themeColor}) {
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
  String _selectedActionType = 'allow';
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.rule.name);
    _phoneController = TextEditingController(text: widget.rule.phoneNumber ?? '');
    _selectedLabelId = widget.rule.labelId;
    _selectedActionType = widget.rule.actionType;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _saveRule() async {
    if (_nameController.text.isEmpty || _phoneController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context).ruleNameAndPhoneNumberCannotBeEmpty),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
      return;
    }

    setState(() {
      _isProcessing = true;
    });

    try {
      final updatedRule = widget.rule.copyWith(
        name: _nameController.text,
        phoneNumber: _phoneController.text,
        labelId: _selectedLabelId ?? '',
        actionType: _selectedActionType,
      );

      final ruleService = ref.read(ruleManagementServiceProvider);
      await ruleService.updatePhoneNumberRule(updatedRule);

      if (widget.onRuleUpdated != null) {
        widget.onRuleUpdated!();
      }

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context).ruleUpdateSuccess),
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context).updateRuleFailed(e.toString())),
            backgroundColor: Theme.of(context).colorScheme.error,
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
    final theme = Theme.of(context);

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: theme.colorScheme.outlineVariant, width: 1.0),
      ),
      title: Text(AppLocalizations.of(context).editPhoneRule),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context).ruleName,
                hintText: AppLocalizations.of(context).exampleFamilyFriends,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context).phoneNumber,
                hintText: AppLocalizations.of(context).examplePhoneNumber,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 12),
            PublicSelectLabel(
              initialLabelId: _selectedLabelId,
              onLabelIdChanged: (labelId) {
                setState(() {
                  _selectedLabelId = labelId;
                });
              },
              themeColor: widget.themeColor ?? theme.primaryColor,
            ),
            const SizedBox(height: 12),
            RuleActionSelector(
              initialAction: RuleActionDisplayUtils.parseActionType(_selectedActionType),
              showAd: false,
              padding: EdgeInsets.zero,
              onActionChanged: (action) {
                setState(() {
                  _selectedActionType = action.type.name;
                });
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isProcessing ? null : () => Navigator.pop(context),
          child: Text(AppLocalizations.of(context).cancelButton),
        ),
        TextButton(
          onPressed: _isProcessing ? null : _saveRule,
          child: _isProcessing
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Text(AppLocalizations.of(context).save),
        ),
      ],
    );
  }
}
