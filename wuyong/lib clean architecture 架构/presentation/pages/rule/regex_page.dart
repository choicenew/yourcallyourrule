import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../domain/entities/rule/regex_rule.dart';
import '../../../domain/entities/rule/rule_base.dart';
import '../../../domain/value_objects/phone_number.dart';
import '../../../domain/value_objects/rule_action.dart';
import '../../state/providers/rule_provider.dart';
import '../../widgets/rule/rule_card.dart';
import '../base_page.dart';

/// 正则规则页面
/// 用于管理基于模式的规则
class RegexPage extends BasePage {
  const RegexPage({Key? key}) : super(key: key);

  @override
  String get title => '正则规则';

  @override
  Widget buildContent(BuildContext context) {
    final ruleProvider = Provider.of<RuleProvider>(context);
    final regexRules = ruleProvider.rules
        .where((rule) => rule is RegexRule)
        .cast<RegexRule>()
        .toList();

    return Column(
      children: [
        _buildHeader(context, regexRules.length),
        Expanded(
          child: regexRules.isEmpty
              ? _buildEmptyState(context)
              : _buildRuleList(context, regexRules),
        ),
      ],
    );
  }

  @override
  Widget? buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => _showAddRuleDialog(context),
      backgroundColor: Colors.purple,
      child: const Icon(Icons.add),
    );
  }

  // 构建页面头部
  Widget _buildHeader(BuildContext context, int ruleCount) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Theme.of(context).colorScheme.surface,
      child: Row(
        children: [
          const Icon(Icons.code, color: Colors.purple),
          const SizedBox(width: 8),
          Text(
            '共 $ruleCount 条正则规则',
            style: const TextStyle(fontSize: 16),
          ),
          const Spacer(),
          TextButton.icon(
            icon: const Icon(Icons.help_outline),
            label: const Text('规则说明'),
            onPressed: () => _showRuleHelpDialog(context),
          ),
        ],
      ),
    );
  }

  // 构建规则列表
  Widget _buildRuleList(BuildContext context, List<RegexRule> rules) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: rules.length,
      itemBuilder: (context, index) {
        final rule = rules[index];
        return RuleCard(
          rule: rule,
          onEdit: rule.isUserCreated ? () => _showEditRuleDialog(context, rule) : null,
          onDelete: () => _showDeleteConfirmDialog(context, rule),
        );
      },
    );
  }

  // 构建空状态
  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.code_outlined,
            size: 64,
            color: Colors.grey,
          ),
          const SizedBox(height: 16),
          const Text(
            '暂无正则规则',
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
          const SizedBox(height: 8),
          const Text(
            '正则规则可以匹配特定模式的电话号码',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            icon: const Icon(Icons.add),
            label: const Text('添加正则规则'),
            onPressed: () => _showAddRuleDialog(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple,
            ),
          ),
        ],
      ),
    );
  }

  // 显示添加规则对话框
  void _showAddRuleDialog(BuildContext context) {
    final patternController = TextEditingController();
    final nameController = TextEditingController();
    final descriptionController = TextEditingController();
    RuleAction selectedAction = RuleAction.block;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('添加正则规则'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: patternController,
                  decoration: const InputDecoration(
                    labelText: '正则表达式',
                    hintText: '输入匹配电话号码的正则表达式',
                    prefixIcon: Icon(Icons.code),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: '名称',
                    hintText: '输入规则名称',
                    prefixIcon: Icon(Icons.label),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(
                    labelText: '描述（可选）',
                    hintText: '输入规则描述',
                    prefixIcon: Icon(Icons.description),
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Text('动作：'),
                    const SizedBox(width: 16),
                    ChoiceChip(
                      label: const Text('阻止'),
                      selected: selectedAction == RuleAction.block,
                      onSelected: (selected) {
                        if (selected) {
                          setState(() {
                            selectedAction = RuleAction.block;
                          });
                        }
                      },
                    ),
                    const SizedBox(width: 8),
                    ChoiceChip(
                      label: const Text('允许'),
                      selected: selectedAction == RuleAction.allow,
                      onSelected: (selected) {
                        if (selected) {
                          setState(() {
                            selectedAction = RuleAction.allow;
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
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('取消'),
            ),
            TextButton(
              onPressed: () {
                if (patternController.text.isEmpty || nameController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('请填写必填字段')),
                  );
                  return;
                }

                final rule = RegexRule(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  pattern: patternController.text.trim(),
                  phoneNumber: PhoneNumber(''), // 正则规则不需要具体电话号码
                  name: nameController.text.trim(),
                  description: descriptionController.text.trim().isEmpty
                      ? null
                      : descriptionController.text.trim(),
                  action: selectedAction,
                  createdAt: DateTime.now(),
                  updatedAt: DateTime.now(),
                  isEnabled: true,
                  isUserCreated: true,
                  source: '用户添加',
                );

                Provider.of<RuleProvider>(context, listen: false).addRule(rule);
                Navigator.of(context).pop();
              },
              child: const Text('保存'),
            ),
          ],
        ),
      ),
    );
  }

  // 显示编辑规则对话框
  void _showEditRuleDialog(BuildContext context, RegexRule rule) {
    final patternController = TextEditingController(text: rule.pattern);
    final nameController = TextEditingController(text: rule.name);
    final descriptionController = TextEditingController(text: rule.description ?? '');
    RuleAction selectedAction = rule.action;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('编辑正则规则'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: patternController,
                  decoration: const InputDecoration(
                    labelText: '正则表达式',
                    hintText: '输入匹配电话号码的正则表达式',
                    prefixIcon: Icon(Icons.code),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: '名称',
                    hintText: '输入规则名称',
                    prefixIcon: Icon(Icons.label),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(
                    labelText: '描述（可选）',
                    hintText: '输入规则描述',
                    prefixIcon: Icon(Icons.description),
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Text('动作：'),
                    const SizedBox(width: 16),
                    ChoiceChip(
                      label: const Text('阻止'),
                      selected: selectedAction == RuleAction.block,
                      onSelected: (selected) {
                        if (selected) {
                          setState(() {
                            selectedAction = RuleAction.block;
                          });
                        }
                      },
                    ),
                    const SizedBox(width: 8),
                    ChoiceChip(
                      label: const Text('允许'),
                      selected: selectedAction == RuleAction.allow,
                      onSelected: (selected) {
                        if (selected) {
                          setState(() {
                            selectedAction = RuleAction.allow;
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
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('取消'),
            ),
            TextButton(
              onPressed: () {
                if (patternController.text.isEmpty || nameController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('请填写必填字段')),
                  );
                  return;
                }

                final updatedRule = RegexRule(
                  id: rule.id,
                  pattern: patternController.text.trim(),
                  phoneNumber: rule.phoneNumber,
                  name: nameController.text.trim(),
                  description: descriptionController.text.trim().isEmpty
                      ? null
                      : descriptionController.text.trim(),
                  action: selectedAction,
                  createdAt: rule.createdAt,
                  updatedAt: DateTime.now(),
                  isEnabled: rule.isEnabled,
                  isUserCreated: rule.isUserCreated,
                  source: rule.source,
                );

                Provider.of<RuleProvider>(context, listen: false).updateRule(updatedRule);
                Navigator.of(context).pop();
              },
              child: const Text('保存'),
            ),
          ],
        ),
      ),
    );
  }

  // 显示删除确认对话框
  void _showDeleteConfirmDialog(BuildContext context, RuleBase rule) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('删除规则'),
        content: Text('确定要删除规则 "${rule.name}" 吗？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              Provider.of<RuleProvider>(context, listen: false).deleteRule(rule.id);
              Navigator.of(context).pop();
            },
            child: const Text('删除'),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
          ),
        ],
      ),
    );
  }

  // 显示规则帮助对话框
  void _showRuleHelpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('正则规则说明'),
        content: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('正则规则说明：'),
              SizedBox(height: 8),
              Text('• 正则规则优先级最低'),
              Text('• 使用正则表达式匹配电话号码'),
              Text('• 可以设置匹配后的动作（阻止或允许）'),
              SizedBox(height: 16),
              Text('使用场景：'),
              SizedBox(height: 8),
              Text('• 阻止特定区号或前缀的号码'),
              Text('• 阻止特定格式的号码'),
              Text('• 允许特定模式的号码'),
              SizedBox(height: 16),
              Text('正则表达式示例：'),
              SizedBox(height: 8),
              Text('• ^1[3-9]\d{9}$ - 匹配中国大陆手机号'),
              Text('• ^400\d{7}$ - 匹配400开头的号码'),
              Text('• ^0\d{2,3}-?\d{7,8}$ - 匹配固定电话'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('了解了'),
          ),
        ],
      ),
    );
  }
}