import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../state/providers/app_provider.dart';
import '../../state/providers/rule_provider.dart';
import '../../state/providers/call_provider.dart';
import '../../state/providers/sms_provider.dart';
import '../base_page.dart';
import '../rule/allowed_page.dart';
import '../rule/blocked_page.dart';
import '../rule/whitelist_page.dart';
import '../rule/blacklist_page.dart';
import '../rule/regex_page.dart';
import '../call/call_history_page.dart';
import '../sms/sms_history_page.dart';
import '../settings/settings_page.dart';

/// 首页
/// 应用的主入口页面
class HomePage extends BasePage {
  const HomePage({Key? key}) : super(key: key);

  @override
  String get title => '来电短信过滤';

  @override
  Widget buildContent(BuildContext context) {
    return Column(
      children: [
        _buildStatisticsCard(context),
        const SizedBox(height: 16),
        _buildRuleCategories(context),
        const SizedBox(height: 16),
        _buildHistorySection(context),
      ],
    );
  }

  @override
  PreferredSizeWidget buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: [
        IconButton(
          icon: const Icon(Icons.settings),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SettingsPage()),
            );
          },
        ),
      ],
    );
  }

  // 构建统计卡片
  Widget _buildStatisticsCard(BuildContext context) {
    final ruleProvider = Provider.of<RuleProvider>(context);
    final callProvider = Provider.of<CallProvider>(context);
    final smsProvider = Provider.of<SmsProvider>(context);

    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '过滤统计',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem('规则总数', '${ruleProvider.rules.length}', Colors.blue),
                _buildStatItem('已拦截来电', '${callProvider.callLogs.where((call) => call.isBlocked).length}', Colors.red),
                _buildStatItem('已拦截短信', '${smsProvider.smsMessages.where((sms) => sms.isBlocked).length}', Colors.orange),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // 构建统计项
  Widget _buildStatItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
      ],
    );
  }

  // 构建规则分类
  Widget _buildRuleCategories(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '规则管理',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildRuleButton(
                  context,
                  '允许规则',
                  Icons.check_circle,
                  Colors.green,
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AllowedPage()),
                  ),
                ),
                _buildRuleButton(
                  context,
                  '阻止规则',
                  Icons.block,
                  Colors.red,
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const BlockedPage()),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildRuleButton(
                  context,
                  '白名单',
                  Icons.person,
                  Colors.blue,
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const WhitelistPage()),
                  ),
                ),
                _buildRuleButton(
                  context,
                  '黑名单',
                  Icons.person_off,
                  Colors.grey,
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const BlacklistPage()),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildRuleButton(
                  context,
                  '正则规则',
                  Icons.code,
                  Colors.purple,
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const RegexPage()),
                  ),
                ),
                const SizedBox(width: 80), // 占位，保持对称
              ],
            ),
          ],
        ),
      ),
    );
  }

  // 构建规则按钮
  Widget _buildRuleButton(
    BuildContext context,
    String label,
    IconData icon,
    Color color,
    VoidCallback onPressed,
  ) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: 80,
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  // 构建历史记录部分
  Widget _buildHistorySection(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '历史记录',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildHistoryButton(
                  context,
                  '通话记录',
                  Icons.call,
                  Colors.green,
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CallHistoryPage()),
                  ),
                ),
                _buildHistoryButton(
                  context,
                  '短信记录',
                  Icons.message,
                  Colors.blue,
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SmsHistoryPage()),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // 构建历史记录按钮
  Widget _buildHistoryButton(
    BuildContext context,
    String label,
    IconData icon,
    Color color,
    VoidCallback onPressed,
  ) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: 120,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(fontSize: 14, color: color),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}