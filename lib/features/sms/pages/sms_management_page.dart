import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import 'package:yourcallyourrule/features/common/value_objects/rule_action.dart';
import 'package:yourcallyourrule/features/common/widgets/public_select_label.dart';
import 'package:yourcallyourrule/features/sms/domain/sms_regex_rule.dart';
import 'package:yourcallyourrule/features/sms/services/sms_service.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

class SmsManagementPage extends ConsumerStatefulWidget {
  const SmsManagementPage({super.key});

  @override
  ConsumerState<SmsManagementPage> createState() => _SmsManagementPageState();
}

class _SmsManagementPageState extends ConsumerState<SmsManagementPage> {
  bool _isLoading = true;
  List<SmsRegexRule> _smsRules = [];

  @override
  void initState() {
    super.initState();
    _loadRules();
  }

  Future<void> _loadRules() async {
    setState(() => _isLoading = true);
    try {
      final service = ref.read(smsServiceProvider);
      final rules = await service.getAllRules();
      if (mounted) {
        setState(() {
          _smsRules = rules;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('${AppLocalizations.of(context)!.smsRuleLoadFailed}: $e'),
        ));
      }
    }
  }

  Future<void> _deleteRule(String ruleId) async {
    try {
      final service = ref.read(smsServiceProvider);
      await service.deleteRule(ruleId);
      await _loadRules();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(AppLocalizations.of(context)!.ruleDeleted),
        ));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('${AppLocalizations.of(context)!.deleteRuleFailed}: $e'),
          backgroundColor: Colors.red,
        ));
      }
    }
  }

  void _showAddRuleDialog() {
    final nameController = TextEditingController();
    final contentPatternController = TextEditingController();
    RuleAction selectedAction = RuleAction.block;
    String? selectedLabel;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text(AppLocalizations.of(context)!.addSmsRule),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.ruleName,
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: contentPatternController,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.contentRegex,
                  ),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<RuleAction>(
                  initialValue: selectedAction,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.action,
                  ),
                  items: RuleAction.values.map((a) {
                    return DropdownMenuItem(
                      value: a,
                      child: Text(a.name),
                    );
                  }).toList(),
                  onChanged: (val) {
                    if (val != null) {
                      setDialogState(() => selectedAction = val);
                    }
                  },
                ),
                const SizedBox(height: 12),
                PublicSelectLabel(
                  initialLabelId: selectedLabel,
                  onLabelIdChanged: (id) => selectedLabel = id,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(AppLocalizations.of(context)!.cancelButton),
            ),
            ElevatedButton(
              onPressed: () async {
                final service = ref.read(smsServiceProvider);
                if (!service.validateRegexPattern(contentPatternController.text)) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(AppLocalizations.of(context)!.invalidContentRegex),
                    backgroundColor: Colors.red,
                  ));
                  return;
                }

                final rule = SmsRegexRule(
                  id: const Uuid().v4(),
                  pattern: contentPatternController.text,
                  action: selectedAction.name,
                  isEnabled: true,
                  description: nameController.text,
                );

                await service.addRule(rule);
                if (mounted) {
                  Navigator.pop(context);
                  _loadRules();
                }
              },
              child: Text(AppLocalizations.of(context)!.save),
            ),
          ],
        ),
      ),
    );
  }

  void _showEditRuleDialog(SmsRegexRule rule) {
    final nameController = TextEditingController(text: rule.description ?? '');
    final contentPatternController = TextEditingController(text: rule.pattern);
    RuleAction selectedAction = RuleAction.values.firstWhere(
      (a) => a.name == rule.action,
      orElse: () => RuleAction.block,
    );

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text(AppLocalizations.of(context)!.editRule),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.ruleName,
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: contentPatternController,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.contentRegex,
                  ),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<RuleAction>(
                  initialValue: selectedAction,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.action,
                  ),
                  items: RuleAction.values.map((a) {
                    return DropdownMenuItem(
                      value: a,
                      child: Text(a.name),
                    );
                  }).toList(),
                  onChanged: (val) {
                    if (val != null) {
                      setDialogState(() => selectedAction = val);
                    }
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(AppLocalizations.of(context)!.cancelButton),
            ),
            ElevatedButton(
              onPressed: () async {
                final service = ref.read(smsServiceProvider);
                final updatedRule = rule.copyWith(
                  pattern: contentPatternController.text,
                  action: selectedAction.name,
                  description: nameController.text,
                );

                await service.updateRule(updatedRule);
                if (mounted) {
                  Navigator.pop(context);
                  _loadRules();
                }
              },
              child: Text(AppLocalizations.of(context)!.save),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRuleCard(SmsRegexRule rule) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        title: Text(
          rule.description != null && rule.description!.isNotEmpty
              ? rule.description!
              : rule.pattern,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('Pattern: ${rule.pattern} | Action: ${rule.action}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Switch(
              activeColor: Theme.of(context).colorScheme.primary,
              value: rule.isEnabled,
              onChanged: (val) async {
                final service = ref.read(smsServiceProvider);
                await service.updateRule(rule.copyWith(isEnabled: val));
                _loadRules();
              },
            ),
            IconButton(
              icon: const Icon(Icons.edit_outlined),
              onPressed: () => _showEditRuleDialog(rule),
            ),
            IconButton(
              icon: const Icon(Icons.delete_outline, color: Colors.red),
              onPressed: () => _deleteRule(rule.id),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.smsManagementTitle),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _smsRules.isEmpty
              ? Center(child: Text(AppLocalizations.of(context)!.noRules))
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _smsRules.length,
                  itemBuilder: (context, index) {
                    return _buildRuleCard(_smsRules[index]);
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddRuleDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
