import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../domain/entities/rule/blocked_rule.dart';
import '../../../domain/entities/rule/rule_base.dart';
import '../../../domain/value_objects/phone_number.dart';
import '../../../domain/value_objects/rule_action.dart';
import '../../state/providers/rule_provider.dart';
import '../../widgets/rule/rule_card.dart';
import '../../widgets/rule/rule_form.dart';
import '../base_page.dart';

/// 阻止规则页面
/// 用于管理用户手动添加的阻止规则
class BlockedPage extends BasePage {
  const BlockedPage({Key? key}) : super(key: key);

  @override
  String get title => '阻止规则';

  @override
  Widget buildContent(BuildContext context) {
    final ruleProvider = Provider.of<RuleProvider>(context);
    final blockedRules = ruleProvider.rules
        .where((rule) => rule is BlockedRule)
        .cast<BlockedRule>()
        .toList();

    return Column(
      children: [
        _buildHeader(context, blockedRules.length),
        Expanded(
          child: blockedRules.isEmpty
              ? _buildEmptyState(context)
              : _buildRuleList(context, blockedRules),
        ),
      ],
    );
  }

  @override
  Widget? buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => _showAddRuleDialog(context),
      backgroundColor: Colors.red,
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
          const Icon(Icons.block, color: Colors.red),
          const SizedBox(width: 8),
          Text(
            '共 $ruleCount 条阻止规则',
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
  Widget _buildRuleList(BuildContext context, List<BlockedRule> rules) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: rules.length,
      itemBuilder: (context, index) {
        final rule = rules[index];
        return RuleCard(
          rule: rule,
          onEdit: () => _showEditRuleDialog(context, rule),
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
            Icons.block_outlined,
            size: 64,
            color: Colors.grey,
          ),
          const SizedBox(height: 16),
          const Text(
            '暂无阻止规则',
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
          const SizedBox(height: 8),
          const Text(
            '点击右下角按钮添加规则',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            icon: const Icon(Icons.add),
            label: const Text('添加阻止规则'),
            onPressed: () => _showAddRuleDialog(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
          ),
        ],
      ),
    );
  }

  // 显示添加规则对话框
  void _showAddRuleDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('添加阻止规则'),
        content: RuleForm(
          onSubmit: (phoneNumber, name, description) {
            final rule = BlockedRule(
              id: DateTime.now().millisecondsSinceEpoch.toString(),
              phoneNumber: PhoneNumber(phoneNumber),
              name: name,
              description: description,
              action: RuleAction.block,
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
              isEnabled: true,
              isUserCreated: true,
            );

            Provider.of<RuleProvider>(context, listen: false).addRule(rule);
            Navigator.of(context).pop();
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('取消'),
          ),
        ],
      ),
    );
  }

  // 显示编辑规则对话框
  void _showEditRuleDialog(BuildContext context, BlockedRule rule) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('编辑阻止规则'),
        content: RuleForm(
          initialPhoneNumber: rule.phoneNumber.value,
          initialName: rule.name,
          initialDescription: rule.description,
          onSubmit: (phoneNumber, name, description) {
            final updatedRule = BlockedRule(
              id: rule.id,
              phoneNumber: PhoneNumber(phoneNumber),
              name: name,
              description: description,
              action: rule.action,
              createdAt: rule.createdAt,
              updatedAt: DateTime.now(),
              isEnabled: rule.isEnabled,
              isUserCreated: rule.isUserCreated,
            );

            Provider.of<RuleProvider>(context, listen: false).updateRule(updatedRule);
            Navigator.of(context).pop();
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('取消'),
          ),
        ],
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
        title: const Text('阻止规则说明'),
        content: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('阻止规则说明：'),
              SizedBox(height: 8),
              Text('• 阻止规则优先级仅次于允许规则'),
              Text('• 匹配阻止规则的来电和短信将被阻止'),
              Text('• 如果同时匹配允许规则，则允许规则优先'),
              SizedBox(height: 16),
              Text('使用场景：'),
              SizedBox(height: 8),
              Text('• 添加骚扰电话号码，自动拦截'),
              Text('• 添加不想接听的号码，避免打扰'),
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