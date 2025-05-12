import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yourcallyourrule/core/entities/sms/sms_regex_rule.dart';
import 'package:yourcallyourrule/core/value_objects/rule_action.dart';
import 'package:yourcallyourrule/features/common/widgets/public_select_label.dart';
import 'package:yourcallyourrule/features/sms/services/sms_service.dart';
import 'package:yourcallyourrule/common/utils/hint.dart';

/// 短信过滤规则管理页面
class SmsFilterPage extends StatefulWidget {
  const SmsFilterPage({super.key});

  @override
  State<SmsFilterPage> createState() => _SmsFilterPageState();
}

class _SmsFilterPageState extends State<SmsFilterPage> {
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

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('添加短信过滤规则'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
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
                    hintText: 'Example: ^\\\\d{11}\$',
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: contentPatternController,
                  decoration: const InputDecoration(
                    labelText: '内容正则表达式',
                    hintText: '例如：.*(优惠|促销|打折).*',
                  ),
                  maxLines: 2,
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
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('短信过滤规则添加成功'),
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
        content: const Text('确定要删除这条短信过滤规则吗？'),
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

  Future<void> _importExportRules() async {
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.file_upload),
            title: const Text('导入规则'),
            onTap: () async {
              Navigator.pop(context);
              // 导入规则逻辑
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('导入功能即将上线'),
              ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.file_download),
            title: const Text('导出规则'),
            onTap: () async {
              Navigator.pop(context);
              // 导出规则逻辑
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('导出功能即将上线'),
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
        return '阻止';
      case RuleAction.allow:
        return '允许';
      case RuleAction.silence:
        return '静音';
      default:
        return '未知';
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
        title: const Text('短信过滤规则'),
        backgroundColor: const Color(0xFFF5A623),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.import_export),
            onPressed: _importExportRules,
            tooltip: '导入/导出规则',
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
            const Text(
              '暂无短信过滤规则',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _showAddRuleDialog,
              icon: const Icon(Icons.add),
              label: const Text('添加短信过滤规则'),
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
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '内容: ${rule.contentPattern.pattern}',
                            style: const TextStyle(fontSize: 12, color: Colors.grey, fontFamily: 'monospace'),
                            overflow: TextOverflow.ellipsis,
                          ),
                          if (rule.senderPattern != null) ...[  
                            const SizedBox(height: 2),
                            Text(
                              '发送者: ${rule.senderPattern!.pattern}',
                              style: const TextStyle(fontSize: 12, color: Colors.grey, fontFamily: 'monospace'),
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
                        backgroundColor: actionColor.withValues(alpha:0.1),
                        labelStyle: TextStyle(color: actionColor),
                      ),
                    ),
                    if (rule.labelId.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Chip(
                          label: Text(rule.labelId),
                          backgroundColor: Colors.blue.withValues(alpha:0.1),
                          labelStyle: const TextStyle(color: Colors.blue),
                          avatar: const Icon(Icons.label, size: 16, color: Colors.blue),
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