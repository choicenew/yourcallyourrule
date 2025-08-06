import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/entities/sms/sms_regex_rule.dart';

import 'package:yourcallyourrule/core/provider/providers/sms_service_provider.dart';
import 'package:yourcallyourrule/core/value_objects/rule_action.dart';
import 'package:yourcallyourrule/features/common/widgets/public_select_label.dart';
import 'package:yourcallyourrule/features/sms/services/sms_service.dart';
import 'package:yourcallyourrule/common/utils/hint.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 短信过滤规则管理页面
class SmsFilterPage extends ConsumerStatefulWidget {
  const SmsFilterPage({super.key});

  @override
  ConsumerState<SmsFilterPage> createState() => _SmsFilterPageState();
}

class _SmsFilterPageState extends ConsumerState<SmsFilterPage> {
  bool _isLoading = true;
  List<SmsRegexRule> _smsRules = [];
  String? _selectedLabel;

  @override
  void initState() {
    super.initState();
    _loadRules();
  }

  Future<void> _loadRules() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final service = ref.read(smsServiceProvider);
      final rules = await service.getAll();

      setState(() {
        _smsRules = rules;
        _isLoading = false;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              AppLocalizations.of(context)!.smsRuleLoadFailed(e.toString())),
          backgroundColor: Colors.red,
        ));
      }
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showAddRuleDialog() {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController senderPatternController =
        TextEditingController();
    final TextEditingController contentPatternController =
        TextEditingController();
    RuleAction selectedAction = RuleAction.block;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text(AppLocalizations.of(context)!.addSmsFilterRule),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.ruleName,
                    hintText:
                        AppLocalizations.of(context)!.exampleBlockMarketingSms,
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: senderPatternController,
                  decoration: InputDecoration(
                    labelText:
                        AppLocalizations.of(context)!.senderRegexOptional,
                    hintText: 'Example: ^\\d{11}\$',
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: contentPatternController,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.contentRegex,
                    hintText: AppLocalizations.of(context)!
                        .exampleCouponPromotionDiscount,
                  ),
                  maxLines: 2,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<RuleAction>(
                  value: selectedAction,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.ruleAction,
                  ),
                  items: [
                    DropdownMenuItem(
                      value: RuleAction.block,
                      child: Text(AppLocalizations.of(context)!.block),
                    ),
                    DropdownMenuItem(
                      value: RuleAction.allow,
                      child: Text(AppLocalizations.of(context)!.allow),
                    ),
                    DropdownMenuItem(
                      value: RuleAction.silence,
                      child: Text(AppLocalizations.of(context)!.silence),
                    ),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        selectedAction = value;
                      });
                    }
                  },
                ),
                const SizedBox(height: 16),
                // 标签选择
                PublicSelectLabel(
                  initialLabelId: _selectedLabel,
                  onLabelIdChanged: (labelId) {
                    setState(() {
                      _selectedLabel = labelId;
                    });
                  },
                  themeColor: const Color(0xFFF5A623),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(AppLocalizations.of(context)!.cancelButton),
            ),
            TextButton(
              onPressed: () async {
                if (nameController.text.isEmpty ||
                    contentPatternController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(AppLocalizations.of(context)!
                        .ruleNameAndContentRegexCannotBeEmpty),
                    backgroundColor: Colors.red,
                  ));
                  return;
                }

                try {
                  final service = ref.read(smsServiceProvider);

                  // 验证正则表达式
                  if (!service
                      .validateRegexPattern(contentPatternController.text)) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                          AppLocalizations.of(context)!.invalidContentRegex),
                      backgroundColor: Colors.red,
                    ));
                    return;
                  }

                  if (senderPatternController.text.isNotEmpty &&
                      !service
                          .validateRegexPattern(senderPatternController.text)) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                          AppLocalizations.of(context)!.invalidSenderRegex),
                      backgroundColor: Colors.red,
                    ));
                    return;
                  }

                  // 创建短信规则
                  final rule = SmsRegexRule(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    name: nameController.text,
                    contentRegex: contentPatternController.text,
                    senderRegex: senderPatternController.text.isNotEmpty
                        ? senderPatternController.text
                        : null,
                    action: selectedAction,
                    isEnabled: true,
                    labelId: _selectedLabel ?? '',
                  );

                  // 添加规则
                  await service.save(rule);

                  // 刷新规则列表
                  if (mounted) {
                    Navigator.pop(context);
                    await _loadRules();

                    // 显示成功提示
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(AppLocalizations.of(context)!
                          .smsFilterRuleAddedSuccessfully),
                      backgroundColor: Colors.green,
                    ));
                  }
                } catch (e) {
                  // 显示错误提示
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(AppLocalizations.of(context)!
                          .addRuleFailed(e.toString())),
                      backgroundColor: Colors.red,
                    ));
                  }
                }
              },
              child: Text(AppLocalizations.of(context)!.save),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _toggleRule(String ruleId, bool isEnabled) async {
    try {
      final service = ref.read(smsServiceProvider);
      final rule = _smsRules.firstWhere((r) => r.id == ruleId);
      final updatedRule = SmsRegexRule(
        id: rule.id,
        name: rule.name,
        contentRegex: rule.contentPattern.pattern,
        senderRegex: rule.senderPattern?.pattern,
        action: rule.action,
        isEnabled: isEnabled,
        labelId: rule.labelId,
      );

      await service.update(updatedRule);
      await _loadRules();

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(AppLocalizations.of(context)!.ruleStatusChanged(isEnabled
            ? AppLocalizations.of(context)!.enabled
            : AppLocalizations.of(context)!.disabled)),
        backgroundColor: Colors.green,
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content:
            Text(AppLocalizations.of(context)!.operationFailed(e.toString())),
        backgroundColor: Colors.red,
      ));
    }
  }

  Future<void> _deleteRule(String ruleId) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.deleteRule),
        content: Text(AppLocalizations.of(context)!.confirmDeleteSmsFilterRule),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(AppLocalizations.of(context)!.cancelButton),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(AppLocalizations.of(context)!.deleteButton,
                style: const TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        final service = ref.read(smsServiceProvider);
        final rule = _smsRules.firstWhere((r) => r.id == ruleId);
        await service.delete(rule);
        await _loadRules();

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(AppLocalizations.of(context)!.ruleDeletedSuccessfully),
          backgroundColor: Colors.green,
        ));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              AppLocalizations.of(context)!.deleteRuleFailed(e.toString())),
          backgroundColor: Colors.red,
        ));
      }
    }
  }

  Future<void> _importExportRules() async {
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.file_upload),
            title: Text(AppLocalizations.of(context)!.importRules),
            onTap: () async {
              Navigator.pop(context);
              // 导入规则逻辑
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content:
                    Text(AppLocalizations.of(context)!.importFeatureComingSoon),
              ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.file_download),
            title: Text(AppLocalizations.of(context)!.exportRules),
            onTap: () async {
              Navigator.pop(context);
              // 导出规则逻辑
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content:
                    Text(AppLocalizations.of(context)!.exportFeatureComingSoon),
              ));
            },
          ),
        ],
      ),
    );
  }

  String _getActionText(RuleAction action) {
    switch (action) {
      case RuleAction.block:
        return AppLocalizations.of(context)!.block;
      case RuleAction.allow:
        return AppLocalizations.of(context)!.allow;
      case RuleAction.silence:
        return AppLocalizations.of(context)!.silence;
      default:
        return AppLocalizations.of(context)!.unknown;
    }
  }

  Color _getActionColor(RuleAction action) {
    switch (action) {
      case RuleAction.block:
        return Colors.red;
      case RuleAction.allow:
        return Colors.green;
      case RuleAction.silence:
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.smsFilterRules),
        backgroundColor: const Color(0xFFF5A623),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.import_export),
            onPressed: _importExportRules,
            tooltip: AppLocalizations.of(context)!.importExportRules,
          ),
          const RegexPatternExplanationButton(),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Color(0xFFFFF3E0)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _buildRulesList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddRuleDialog,
        backgroundColor: const Color(0xFFF5A623),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildRulesList() {
    if (_smsRules.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.sms_failed,
              size: 64,
              color: Colors.grey,
            ),
            const SizedBox(height: 16),
            Text(
              AppLocalizations.of(context)!.noSmsFilterRulesYet,
              style: const TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _showAddRuleDialog,
              icon: const Icon(Icons.add),
              label: Text(AppLocalizations.of(context)!.addSmsFilterRule),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF5A623),
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _smsRules.length,
      itemBuilder: (context, index) {
        final rule = _smsRules[index];
        final actionText = _getActionText(rule.action);
        final actionColor = _getActionColor(rule.action);

        return Card(
          elevation: 4,
          margin: const EdgeInsets.only(bottom: 16),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: actionColor.withValues(alpha: 0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.sms_failed,
                        color: actionColor,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            rule.name,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${AppLocalizations.of(context)!.content}: ${rule.contentPattern.pattern}',
                            style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                                fontFamily: 'monospace'),
                            overflow: TextOverflow.ellipsis,
                          ),
                          if (rule.senderPattern != null) ...[
                            const SizedBox(height: 2),
                            Text(
                              '${AppLocalizations.of(context)!.sender}: ${rule.senderPattern!.pattern}',
                              style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                  fontFamily: 'monospace'),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ],
                      ),
                    ),
                    Switch(
                      value: rule.isEnabled,
                      onChanged: (value) => _toggleRule(rule.id, value),
                      activeColor: const Color(0xFFF5A623),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _deleteRule(rule.id),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8, right: 8),
                      child: Chip(
                        label: Text(actionText),
                        backgroundColor: actionColor.withValues(alpha: 0.1),
                        labelStyle: TextStyle(color: actionColor),
                      ),
                    ),
                    if (rule.labelId.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Chip(
                          label: Text(rule.labelId),
                          backgroundColor: Colors.blue.withValues(alpha: 0.1),
                          labelStyle: const TextStyle(color: Colors.blue),
                          avatar: const Icon(Icons.label,
                              size: 16, color: Colors.blue),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
