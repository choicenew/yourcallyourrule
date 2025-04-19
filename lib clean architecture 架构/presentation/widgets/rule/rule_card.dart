import 'package:flutter/material.dart';
import '../../../domain/entities/rule/rule_base.dart';
import '../../../domain/entities/rule/allowed_rule.dart';
import '../../../domain/entities/rule/blocked_rule.dart';
import '../../../domain/entities/rule/whitelist_rule.dart';
import '../../../domain/entities/rule/blacklist_rule.dart';
import '../../../domain/entities/rule/regex_rule.dart';
import '../base_widget.dart';

/// 规则卡片组件
/// 用于展示规则信息
class RuleCard extends BaseWidget {
  final RuleBase rule;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onToggle;

  const RuleCard({
    Key? key,
    required this.rule,
    this.onEdit,
    this.onDelete,
    this.onToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            const Divider(),
            _buildContent(context),
            const SizedBox(height: 8),
            _buildFooter(context),
          ],
        ),
      ),
    );
  }

  // 构建卡片头部
  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        _buildRuleTypeIcon(),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            rule.name,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Switch(
          value: rule.isEnabled,
          onChanged: onToggle != null ? (_) => onToggle!() : null,
        ),
      ],
    );
  }

  // 构建规则类型图标
  Widget _buildRuleTypeIcon() {
    IconData iconData;
    Color iconColor;

    if (rule is AllowedRule) {
      iconData = Icons.check_circle;
      iconColor = Colors.green;
    } else if (rule is BlockedRule) {
      iconData = Icons.block;
      iconColor = Colors.red;
    } else if (rule is WhitelistRule) {
      iconData = Icons.person;
      iconColor = Colors.blue;
    } else if (rule is BlacklistRule) {
      iconData = Icons.person_off;
      iconColor = Colors.grey;
    } else if (rule is RegexRule) {
      iconData = Icons.code;
      iconColor = Colors.purple;
    } else {
      iconData = Icons.rule;
      iconColor = Colors.orange;
    }

    return Icon(iconData, color: iconColor);
  }

  // 构建卡片内容
  Widget _buildContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.phone, size: 16, color: Colors.grey),
            const SizedBox(width: 8),
            Text(
              rule.phoneNumber.value,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
        if (rule.description != null && rule.description!.isNotEmpty) ...[  
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.description, size: 16, color: Colors.grey),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  rule.description!,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ),
            ],
          ),
        ],
        if (rule is! AllowedRule && rule is! BlockedRule) ...[  
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.source, size: 16, color: Colors.grey),
              const SizedBox(width: 8),
              Text(
                '来源: ${_getSourceText()}',
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
        ],
      ],
    );
  }

  // 获取来源文本
  String _getSourceText() {
    if (rule is WhitelistRule) {
      return (rule as WhitelistRule).source;
    } else if (rule is BlacklistRule) {
      return (rule as BlacklistRule).source;
    } else if (rule is RegexRule) {
      return (rule as RegexRule).source;
    } else {
      return rule.isUserCreated ? '用户添加' : '系统';
    }
  }

  // 构建卡片底部
  Widget _buildFooter(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          '创建于 ${_formatDate(rule.createdAt)}',
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
        const Spacer(),
        if (onEdit != null)
          IconButton(
            icon: const Icon(Icons.edit, size: 20),
            onPressed: onEdit,
            tooltip: '编辑',
          ),
        if (onDelete != null)
          IconButton(
            icon: const Icon(Icons.delete, size: 20),
            onPressed: onDelete,
            tooltip: '删除',
          ),
      ],
    );
  }

  // 格式化日期
  String _formatDate(DateTime dateTime) {
    return '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}';
  }
}