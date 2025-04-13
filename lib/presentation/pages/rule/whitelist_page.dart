import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../domain/entities/rule/whitelist_rule.dart';
import '../../../domain/entities/rule/rule_base.dart';
import '../../../domain/value_objects/phone_number.dart';
import '../../../domain/value_objects/rule_action.dart';
import '../../state/providers/rule_provider.dart';
import '../../widgets/rule/rule_card.dart';
import '../../widgets/rule/rule_form.dart';
import '../base_page.dart';

/// 白名单规则页面
/// 用于管理订阅的白名单规则
class WhitelistPage extends BasePage {
  const WhitelistPage({Key? key}) : super(key: key);

  @override
  String get title => '白名单规则';

  @override
  Widget buildContent(BuildContext context) {
    final ruleProvider = Provider.of<RuleProvider>(context);
    final whitelistRules = ruleProvider.rules
        .where((rule) => rule is WhitelistRule)
        .cast<WhitelistRule>()
        .toList();

    return Column(
      children: [
        _buildHeader(context, whitelistRules.length),
        Expanded(
          child: whitelistRules.isEmpty
              ? _buildEmptyState(context)
              : _buildRuleList(context, whitelistRules),
        ),
      ],
    );
  }

  @override
  Widget? buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => _showAddRuleDialog(context),
      backgroundColor: Colors.blue,
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
          const Icon(Icons.person, color: Colors.blue),
          const SizedBox(width: 8),
          Text(
            '共 $ruleCount 条白名单规则',
            style: const TextStyle(fontSize: 16),
          ),
          const Spacer(),
          TextButton.icon(
            icon: const Icon(Icons.sync),
            label: const Text('同步订阅'),
            onPressed: () => _syncWhitelist(context),
          ),
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
  Widget _buildRuleList(BuildContext context, List<WhitelistRule> rules) {
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
            Icons.person_outlined,
            size: 64,
            color: Colors.grey,
          ),
          const SizedBox(height: 16),
          const Text(
            '暂无白名单规则',
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
          const SizedBox(height: 8),
          const Text(
            '您可以添加自定义白名单或订阅官方白名单',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                icon: const Icon(Icons.add),
                label: const Text('添加白名单'),
                onPressed: () => _showAddRuleDialog(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
              ),
              const SizedBox(width: 16),
              OutlinedButton.icon(
                icon: const Icon(Icons.sync),
                label: const Text('订阅白名单'),
                onPressed: () => _syncWhitelist(context),
              ),
            ],
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
        title: const Text('添加白名单规则'),
        content: RuleForm(
          onSubmit: (phoneNumber, name, description) {
            final rule = WhitelistRule(
              id: DateTime.now().millisecondsSinceEpoch.toString(),
              phoneNumber: PhoneNumber(phoneNumber),
              name: name,
              description: description,
              action: RuleAction.allow,
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
              isEnabled: true,
              isUserCreated: true,
              source: '用户添加',
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
  void _showEditRuleDialog(BuildContext context, WhitelistRule rule) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('编辑白名单规则'),
        content: RuleForm(
          initialPhoneNumber: rule.phoneNumber.value,
          initialName: rule.name,
          initialDescription: rule.description,
          onSubmit: (phoneNumber, name, description) {
            final updatedRule = WhitelistRule(
              id: rule.id,
              phoneNumber: PhoneNumber(phoneNumber),
              name: name,
              description: description,
              action: rule.action,
              createdAt: rule.createdAt,
              updatedAt: DateTime.now(),
              isEnabled: rule.isEnabled,
              isUserCreated: rule.isUserCreated,
              source: rule.source,
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

  // 同步白名单
  void _syncWhitelist(BuildContext context) {
    // 这里应该调用同步白名单的逻辑
    // 实际实现时应该添加相应的用例
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('正在同步白名单数据...')),
    );
  }

  // 显示规则帮助对话框
  void _showRuleHelpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('白名单规则说明'),
        content: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('白名单规则说明：'),
              SizedBox(height: 8),
              Text('• 白名单规则优先级低于允许规则和阻止规则'),
              Text('• 匹配白名单规则的来电和短信将被允许'),
              Text('• 如果同时匹配阻止规则，则阻止规则优先'),
              SizedBox(height: 16),
              Text('使用场景：'),
              SizedBox(height: 8),
              Text('• 订阅官方白名单，自动允许重要服务号码'),
              Text('• 添加自定义白名单，允许特定号码'),
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