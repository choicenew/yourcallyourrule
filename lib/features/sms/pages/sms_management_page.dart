import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yourcallyourrule/core/entities/sms/sms_regex_rule.dart';
import 'package:yourcallyourrule/core/value_objects/rule_action.dart';
import 'package:yourcallyourrule/features/common/widgets/public_select_label.dart';
import 'package:yourcallyourrule/features/sms/services/sms_service.dart';
import 'package:file_picker/file_picker.dart';

/// 短信规则管理页面
class SmsManagementPage extends StatefulWidget {
  const SmsManagementPage({super.key});

  @override
  State<SmsManagementPage> createState() => _SmsManagementPageState();
}

class _SmsManagementPageState extends State<SmsManagementPage> {
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
      final service = Provider.of<SmsService>(context, listen: false);
      final rules = await service.getAll();

      setState(() {
        _smsRules = rules;
        _isLoading = false;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('加载短信规则失败: $e'),
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
          title: const Text('添加短信规则'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: '规则名称',
                    hintText: '例如：屏蔽营销短信',
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: senderPatternController,
                  decoration: const InputDecoration(
                    labelText: '发送者正则表达式（可选）',
                    hintText: 'Example: ^10086\$ format',
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: contentPatternController,
                  decoration: const InputDecoration(
                    labelText: '内容正则表达式',
                    hintText: '例如：.*优惠.*',
                  ),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<RuleAction>(
                  value: selectedAction,
                  decoration: const InputDecoration(
                    labelText: '规则动作',
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: RuleAction.block,
                      child: Text('阻止'),
                    ),
                    DropdownMenuItem(
                      value: RuleAction.allow,
                      child: Text('允许'),
                    ),
                    DropdownMenuItem(
                      value: RuleAction.silence,
                      child: Text('静音'),
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
              child: const Text('取消'),
            ),
            TextButton(
              onPressed: () async {
                if (nameController.text.isEmpty || contentPatternController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('规则名称和内容正则表达式不能为空'),
                    backgroundColor: Colors.red,
                  ));
                  return;
                }
                
                try {
                  final service = Provider.of<SmsService>(context, listen: false);
                  
                  // 验证正则表达式
                  if (!service.validateRegexPattern(contentPatternController.text)) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('无效的内容正则表达式'),
                      backgroundColor: Colors.red,
                    ));
                    return;
                  }

                  if (senderPatternController.text.isNotEmpty && 
                      !service.validateRegexPattern(senderPatternController.text)) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('无效的发送者正则表达式'),
                      backgroundColor: Colors.red,
                    ));
                    return;
                  }
                  
                  // 创建短信规则
                  final rule = SmsRegexRule(
                    id: '',
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
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('短信规则添加成功'),
                      backgroundColor: Colors.green,
                    ));
                  }
                } catch (e) {
                  // 显示错误提示
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('添加规则失败: $e'),
                      backgroundColor: Colors.red,
                    ));
                  }
                }
              },
              child: const Text('保存'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _toggleRule(String ruleId, bool isEnabled) async {
    try {
      final service = Provider.of<SmsService>(context, listen: false);
      final rule = _smsRules.firstWhere((r) => r.id == ruleId);
      final updatedRule = rule.copyWith(
        isEnabled: isEnabled,
      );
      
      await service.update(updatedRule);
      await _loadRules();
      
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('规则${isEnabled ? "启用" : "禁用"}成功'),
        backgroundColor: Colors.green,
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('操作失败: $e'),
        backgroundColor: Colors.red,
      ));
    }
  }

  Future<void> _deleteRule(String ruleId) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('删除规则'),
        content: const Text('确定要删除这条短信规则吗？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('删除', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
    
    if (confirmed == true) {
      try {
        final service = Provider.of<SmsService>(context, listen: false);
        final rule = _smsRules.firstWhere((r) => r.id == ruleId);
        await service.delete(rule);
        await _loadRules();
        
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('规则删除成功'),
          backgroundColor: Colors.green,
        ));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('删除失败: $e'),
          backgroundColor: Colors.red,
        ));
      }
    }
  }

  Future<void> _importRules() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['json', 'txt'],
      );

      if (result != null && result.files.single.path != null) {
        final service = Provider.of<SmsService>(context, listen: false);
        final importExportService = service.importExportService;
        final rules = await importExportService.importFromFile(result.files.single.path!);
        
        // 过滤出短信规则
        final smsRules = rules.whereType<SmsRegexRule>().toList();
        
        if (smsRules.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('文件中没有找到有效的短信规则'),
            backgroundColor: Colors.orange,
          ));
          return;
        }
        
        // 保存导入的规则
        await service.saveAll(smsRules);
        await _loadRules();
        
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('成功导入 ${smsRules.length} 条规则'),
          backgroundColor: Colors.green,
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('导入规则失败: $e'),
        backgroundColor: Colors.red,
      ));
    }
  }

  Future<void> _exportRules() async {
    try {
      final result = await FilePicker.platform.saveFile(
        dialogTitle: '导出短信规则',
        fileName: 'sms_rules.json',
      );

      if (result != null) {
        final service = Provider.of<SmsService>(context, listen: false);
        final importExportService = service.importExportService;
        final success = await importExportService.exportToFile(result, entities: _smsRules);
        
        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('规则导出成功'),
            backgroundColor: Colors.green,
          ));
        } else {
          throw Exception('导出失败');
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('导出规则失败: $e'),
        backgroundColor: Colors.red,
      ));
    }
  }

  String _getActionText(RuleAction action) {
    switch (action.type) {
      case RuleActionType.block:
        return '阻止';
      case RuleActionType.allow:
        return '允许';
      case RuleActionType.silence:
        return '静音';
      default:
        return '未知';
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
        title: const Text('短信规则管理'),
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
              const PopupMenuItem<String>(
                value: 'import',
                child: Row(
                  children: [
                    Icon(Icons.file_upload, color: Color(0xFFF5A623)),
                    SizedBox(width: 8),
                    Text('导入规则'),
                  ],
                ),
              ),
              const PopupMenuItem<String>(
                value: 'export',
                child: Row(
                  children: [
                    Icon(Icons.file_download, color: Color(0xFFF5A623)),
                    SizedBox(width: 8),
                    Text('导出规则'),
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
            const Text(
              '暂无短信规则',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _showAddRuleDialog,
              icon: const Icon(Icons.add),
              label: const Text('添加短信规则'),
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
                        color: actionColor.withOpacity(0.2),
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
                            '内容: ${rule.contentPattern.pattern}',
                            style: const TextStyle(fontSize: 14, color: Colors.grey, fontFamily: 'monospace'),
                          ),
                          if (rule.senderPattern != null)
                            Text(
                              '发送者: ${rule.senderPattern!.pattern}',
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
                        backgroundColor: actionColor.withOpacity(0.1),
                        labelStyle: TextStyle(color: actionColor),
                      ),
                      if (rule.labelId.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Chip(
                            label: Text(rule.labelId),
                            backgroundColor: Colors.blue.withOpacity(0.1),
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