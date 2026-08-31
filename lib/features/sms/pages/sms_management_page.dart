import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:yourcallyourrule/core/entities/sms/sms_regex_rule.dart';

import 'package:yourcallyourrule/core/value_objects/rule_action.dart';
import 'package:yourcallyourrule/features/common/widgets/public_select_label.dart';
import 'package:yourcallyourrule/features/sms/providers/sms_service_provider.dart';
import 'package:yourcallyourrule/features/sms/services/sms_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';


/// 短信规则管理页面
class SmsManagementPage extends ConsumerStatefulWidget {
  const SmsManagementPage({super.key});

  @override
  ConsumerState<SmsManagementPage> createState() => _SmsManagementPageState();
}

class _SmsManagementPageState extends ConsumerState<SmsManagementPage> {
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
          content: Text(AppLocalizations.of(context)!.loadSmsRulesFailed(e.toString())),
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
    final TextEditingController senderPatternController = TextEditingController();
    final TextEditingController contentPatternController = TextEditingController();
    RuleAction selectedAction = RuleAction.block;
    String? selectedLabel;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text(AppLocalizations.of(context)!.addSmsRule),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.ruleName,
                    hintText: AppLocalizations.of(context)!.exampleBlockMarketingSms,
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: senderPatternController,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.senderRegexOptional,
                    hintText: "${AppLocalizations.of(context)!.exampleSenderRegexHint}:'^10086\$ '",
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: contentPatternController,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.contentRegex,
                    hintText: "${AppLocalizations.of(context)!.exampleContentRegexHint}:'*xx.*'",
                  ),
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
                PublicSelectLabel(
                  initialLabelId: selectedLabel,
                  onLabelIdChanged: (labelId) {
                    setState(() {
                      selectedLabel = labelId;
                    });
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
            TextButton(
              onPressed: () async {
                if (nameController.text.isEmpty || contentPatternController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(AppLocalizations.of(context)!.ruleNameAndContentRegexCannotBeEmpty),
                    backgroundColor: Colors.red,
                  ));
                  return;
                }
                
                try {
                  final service = ref.read(smsServiceProvider);
                  
                  // 验证正则表达式
                  if (!service.validateRegexPattern(contentPatternController.text)) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(AppLocalizations.of(context)!.invalidContentRegex),
                      backgroundColor: Colors.red,
                    ));
                    return;
                  }

                  if (senderPatternController.text.isNotEmpty && 
                      !service.validateRegexPattern(senderPatternController.text)) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(AppLocalizations.of(context)!.invalidSenderRegex),
                      backgroundColor: Colors.red,
                    ));
                    return;
                  }
                  
                  // 创建短信规则
                  final rule = SmsRegexRule(
                    id: const Uuid().v4(),
                    name: nameController.text,
                    contentRegex: contentPatternController.text,
                    senderRegex: senderPatternController.text.isNotEmpty 
                        ? senderPatternController.text 
                        : null,
                    action: selectedAction,
                    labelId: selectedLabel ?? '',
                    isEnabled: true,
                  );
                  
                  // 添加规则
                  await service.save(rule);
                  
                  // 刷新规则列表
                  if (mounted) {
                    Navigator.pop(context);
                    await _loadRules();
                    
                    // 显示成功提示
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(AppLocalizations.of(context)!.smsRuleAddedSuccessfully),
                      backgroundColor: Colors.green,
                    ));
                  }
                } catch (e) {
                  // 显示错误提示
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(AppLocalizations.of(context)!.failedToAddRule(e.toString())),
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
      final updatedRule = rule.copyWith(
        isEnabled: isEnabled,
      );
      
      await service.update(updatedRule);
      await _loadRules();
      
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(isEnabled ? AppLocalizations.of(context)!.ruleEnabledSuccessfully : AppLocalizations.of(context)!.ruleDisabledSuccessfully),
        backgroundColor: Colors.green,
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(AppLocalizations.of(context)!.failedToToggleRuleStatus(e.toString())),
        backgroundColor: Colors.red,
      ));
    }
  }

  Future<void> _deleteRule(String ruleId) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.deleteRule),
        content: Text(AppLocalizations.of(context)!.confirmDeleteSmsRule),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(AppLocalizations.of(context)!.cancelButton),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(AppLocalizations.of(context)!.deleteButton, style: const TextStyle(color: Colors.red)),
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
          content: Text(AppLocalizations.of(context)!.smsRuleDeletedSuccessfully),
          backgroundColor: Colors.green,
        ));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(AppLocalizations.of(context)!.failedToDeleteSmsRule(e.toString())),
          backgroundColor: Colors.red,
        ));
      }
    }
  }

  Future<void> _importRules() async {
    try {
      final result = await FilePicker.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['json', 'txt'],
      );

      if (result != null && result.files.single.path != null) {
        final service = ref.read(smsServiceProvider);
        final importExportService = service.importExportService;
        final rules = await importExportService.importFromFile(result.files.single.path!);
        
        // 过滤出短信规则
        final smsRules = rules.whereType<SmsRegexRule>().toList();
        
        if (smsRules.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(AppLocalizations.of(context)!.noValidSmsRulesFoundInFile),
            backgroundColor: Colors.orange,
          ));
          return;
        }
        
        // 保存导入的规则
        await service.saveAll(smsRules);
        await _loadRules();
        
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(AppLocalizations.of(context)!.successfullyImportedRules(smsRules.length)),
          backgroundColor: Colors.green,
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(AppLocalizations.of(context)!.failedToImportRules(e.toString())),
        backgroundColor: Colors.red,
      ));
    }
  }

  Future<void> _exportRules() async {
    try {
      final service = ref.read(smsServiceProvider);
      final importExportService = service.importExportService;
      
      // 准备导出数据字节
      final bytes = await importExportService.prepareExportBytes(_smsRules);

      final result = await FilePicker.saveFile(
        dialogTitle: AppLocalizations.of(context)!.exportSmsRules,
        fileName: 'sms_rules.json',
        bytes: bytes,
      );

      if (result != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(AppLocalizations.of(context)!.rulesExportedSuccessfully),
          backgroundColor: Colors.green,
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(AppLocalizations.of(context)!.failedToExportRules(e.toString())),
        backgroundColor: Colors.red,
      ));
    }
  }

  String _getActionText(RuleAction action) {
    switch (action.type) {
      case RuleActionType.block:
        return AppLocalizations.of(context)!.block;
      case RuleActionType.allow:
        return AppLocalizations.of(context)!.allow;
      case RuleActionType.silence:
        return AppLocalizations.of(context)!.silence;
      default:
        return AppLocalizations.of(context)!.unknown;
    }
  }

  Color _getActionColor(RuleAction action) {
    switch (action.type) {
      case RuleActionType.block:
        return Colors.red;
      case RuleActionType.allow:
        return Colors.green;
      case RuleActionType.silence:
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.smsRuleManagement),
        backgroundColor: const Color(0xFFF5A623),
        elevation: 0,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'import') {
                _importRules();
              } else if (value == 'export') {
                _exportRules();
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem<String>(
                value: 'import',
                child: Row(
                  children: [
                    const Icon(Icons.file_upload, color: Color(0xFFF5A623)),
                    const SizedBox(width: 8),
                    Text(AppLocalizations.of(context)!.importRules),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: 'export',
                child: Row(
                  children: [
                    const Icon(Icons.file_download, color: Color(0xFFF5A623)),
                    const SizedBox(width: 8),
                    Text(AppLocalizations.of(context)!.exportRules),
                  ],
                ),
              ),
            ],
          ),
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
              AppLocalizations.of(context)!.noSmsRulesYet,
              style: const TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _showAddRuleDialog,
              icon: const Icon(Icons.add),
              label: Text(AppLocalizations.of(context)!.addSmsRule),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF5A623),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
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
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
                        color: actionColor.withValues(alpha:0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.sms,
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
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${AppLocalizations.of(context)!.content}: ${rule.contentPattern.pattern}',
                            style: const TextStyle(fontSize: 14, color: Colors.grey, fontFamily: 'monospace'),
                          ),
                          if (rule.senderPattern != null)
                            Text(
                              '${AppLocalizations.of(context)!.sender}: ${rule.senderPattern!.pattern}',
                              style: const TextStyle(fontSize: 14, color: Colors.grey, fontFamily: 'monospace'),
                            ),
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
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Row(
                    children: [
                      Chip(
                        label: Text(actionText),
                        backgroundColor: actionColor.withValues(alpha:0.1),
                        labelStyle: TextStyle(color: actionColor),
                      ),
                      if (rule.labelId.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Chip(
                            label: Text(rule.labelId),
                            backgroundColor: Colors.blue.withValues(alpha:0.1),
                            labelStyle: const TextStyle(color: Colors.blue),
                            avatar: const Icon(Icons.label, size: 16, color: Colors.blue),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}