import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:yourcallyourrule/core/entities/regex/regex_pattern.dart';
import 'package:yourcallyourrule/core/entities/rule/regex_rule.dart';
import 'package:yourcallyourrule/core/value_objects/rule_action.dart';
import 'package:yourcallyourrule/features/common/widgets/public_select_label.dart';
import 'package:yourcallyourrule/features/rules/services/regex_service.dart';

/// 正则规则管理页面
class RegexRulePage extends StatefulWidget {
  const RegexRulePage({super.key});

  @override
  State<RegexRulePage> createState() => _RegexRulePageState();
}

class _RegexRulePageState extends State<RegexRulePage> {
  bool _isLoading = true;
  List<RegexRule> _regexRules = [];

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
      final service = Provider.of<RegexService>(context, listen: false);
      final rules = await service.getAllRegexRules();

      setState(() {
        _regexRules = rules;
        _isLoading = false;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('加载正则规则失败: $e'),
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
    final TextEditingController patternController = TextEditingController();
    RuleAction selectedAction = RuleAction.block;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('添加正则规则'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: '规则名称',
                  hintText: '例如：屏蔽400开头号码',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: patternController,
                decoration: const InputDecoration(
                  labelText: '正则表达式',
                  hintText: '例如：^400\\\\d{7}\$',
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
                  DropdownMenuItem(
                    value: RuleAction.redirect,
                    child: Text('重定向'),
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
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('取消'),
            ),
            TextButton(
              onPressed: () async {
                if (nameController.text.isEmpty || patternController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('规则名称和正则表达式不能为空'),
                    backgroundColor: Colors.red,
                  ));
                  return;
                }
                
                try {
                  final service = Provider.of<RegexService>(context, listen: false);
                  
                  // 验证正则表达式
                  if (!service.isValidRegex(patternController.text)) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('无效的正则表达式'),
                      backgroundColor: Colors.red,
                    ));
                    return;
                  }
                  
                  // 创建正则模式
                  final pattern = RegExPattern(
                    name: nameController.text,
                    pattern: patternController.text,
                    action: selectedAction,
                  );
                  
                  // 添加规则
                  await service.addRegexRule(pattern);
                  
                  // 刷新规则列表
                  if (mounted) {
                    Navigator.pop(context);
                    await _loadRules();
                    
                    // 显示成功提示
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('正则规则添加成功'),
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
      final service = Provider.of<RegexService>(context, listen: false);
      await service.toggleRegexRule(ruleId, isEnabled);
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
        content: const Text('确定要删除这条正则规则吗？'),
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
        final service = Provider.of<RegexService>(context, listen: false);
        await service.removeRegexRule(ruleId);
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

  String _getActionText(RuleAction action) {
    switch (action) {
      case RuleAction.block:
        return '阻止';
      case RuleAction.allow:
        return '允许';
      case RuleAction.silence:
        return '静音';
      case RuleAction.redirect:
        return '重定向';
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
      case RuleAction.redirect:
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('正则规则管理'),
        backgroundColor: const Color(0xFFF5A623),
        elevation: 0,
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
    if (_regexRules.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.code,
              size: 64,
              color: Colors.grey,
            ),
            const SizedBox(height: 16),
            const Text(
              '暂无正则规则',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _showAddRuleDialog,
              icon: const Icon(Icons.add),
              label: const Text('添加正则规则'),
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
      itemCount: _regexRules.length,
      itemBuilder: (context, index) {
        final rule = _regexRules[index];
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
                        Icons.code,
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
                            rule.pattern,
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
                  child: Chip(
                    label: Text(actionText),
                    backgroundColor: actionColor.withValues(alpha:0.1),
                    labelStyle: TextStyle(color: actionColor),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // 标签选择组件
  Widget _buildLabelSelector() {
    return PublicSelectLabel(
      onLabelIdChanged: (labelId) {
        // 处理标签选择逻辑
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('已选择标签ID: $labelId'),
        ));
      },
      themeColor: const Color(0xFFF5A623),
    );
  }
}