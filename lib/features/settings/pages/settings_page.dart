import 'package:flutter/material.dart';
import 'package:yourcallyourrule/features/auto_update/pages/auto_update_settings_page.dart';
import 'package:yourcallyourrule/features/language/pages/language_settings_page.dart';
import 'package:yourcallyourrule/features/phone/pages/phone_subscription_page.dart';
import 'package:yourcallyourrule/features/plugin/pages/plugin_management_page.dart';
import 'package:yourcallyourrule/features/sms/pages/sms_subscription_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('设置'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildUserInfoCard(context),
          const SizedBox(height: 24),
          _buildSectionTitle('功能设置'),
          const SizedBox(height: 8),
          _buildCallSettingsCard(context),
          const SizedBox(height: 12),
          _buildSmsSettingsCard(context),
          const SizedBox(height: 12),
          _buildContactSettingsCard(context),
          const SizedBox(height: 24),
          _buildSectionTitle('系统设置'),
          const SizedBox(height: 8),
          _buildAutoUpdateCard(context),
          const SizedBox(height: 12),
          _buildPluginManagementCard(context),
          const SizedBox(height: 12),
          _buildLanguageSettingsCard(context),
          const SizedBox(height: 12),
          _buildAboutCard(context),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildUserInfoCard(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 32,
              backgroundColor: Theme.of(context).primaryColor,
              child: const Text(
                'U',
                style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(width: 16),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '用户名',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'user@example.com',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget _buildCallSettingsCard(BuildContext context) {
    return _buildSettingsCard(
      context,
      icon: Icons.phone,
      iconColor: Colors.blue,
      title: '来电设置',
      subtitle: '来电识别、过滤和拦截设置',
      onTap: () {
        // 导航到来电设置页面
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const PhoneSubscriptionPage()),
        );
      },
    );
  }

  Widget _buildSmsSettingsCard(BuildContext context) {
    return _buildSettingsCard(
      context,
      icon: Icons.sms,
      iconColor: Colors.orange,
      title: '短信设置',
      subtitle: '短信过滤和关键词拦截',
      onTap: () {
        // 导航到短信设置页面
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const SmsSubscriptionPage()),
        );
      },
    );
  }

  Widget _buildContactSettingsCard(BuildContext context) {
    return _buildSettingsCard(
      context,
      icon: Icons.contacts,
      iconColor: Colors.green,
      title: '联系人设置',
      subtitle: '联系人管理和标签设置',
      onTap: () {
        // 导航到联系人设置页面
        // 这里暂时没有实现联系人页面
      },
    );
  }

  Widget _buildAutoUpdateCard(BuildContext context) {
    return _buildSettingsCard(
      context,
      icon: Icons.update,
      iconColor: Colors.purple,
      title: '自动更新设置',
      subtitle: '管理规则和插件的自动更新',
      onTap: () {
        // 导航到自动更新设置页面
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const AutoUpdateSettingsPage()),
        );
      },
    );
  }

  Widget _buildPluginManagementCard(BuildContext context) {
    return _buildSettingsCard(
      context,
      icon: Icons.extension,
      iconColor: Colors.amber,
      title: '插件管理',
      subtitle: '管理和配置第三方插件',
      onTap: () {
        // 导航到插件管理页面
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const PluginManagementPage()),
        );
      },
    );
  }

  Widget _buildLanguageSettingsCard(BuildContext context) {
    return _buildSettingsCard(
      context,
      icon: Icons.language,
      iconColor: Colors.teal,
      title: '语言设置',
      subtitle: '更改应用显示语言',
      onTap: () {
        // 导航到语言设置页面
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const LanguageSettingsPage()),
        );
      },
    );
  }

  Widget _buildAboutCard(BuildContext context) {
    return _buildSettingsCard(
      context,
      icon: Icons.info_outline,
      iconColor: Colors.blue,
      title: '关于',
      subtitle: '应用版本和法律信息',
      onTap: () {
        // 显示关于对话框
        showAboutDialog(
          context: context,
          applicationName: 'Your Call Your Rule',
          applicationVersion: '1.0.0',
          applicationIcon: Icon(
            Icons.phone_android,
            color: Theme.of(context).primaryColor,
            size: 48,
          ),
          applicationLegalese: '© 2023 Your Call Your Rule. 保留所有权利。',
        );
      },
    );
  }

  Widget _buildSettingsCard(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: iconColor.withOpacity(0.1),
                child: Icon(icon, color: iconColor),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}