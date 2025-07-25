import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:yourcallyourrule/features/call/time_interceptor/presentation/widgets/time_interceptor_settings_widget.dart';
import 'package:yourcallyourrule/features/call/time_interceptor/time_interceptor_service.dart';
import 'package:yourcallyourrule/core/provider/providers/time_interceptor_service_provider.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settingsTitle),
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
          _buildSectionTitle(
              AppLocalizations.of(context)!.functionSettingsTitle),
          const SizedBox(height: 8),
          _buildCallSettingsCard(context),
          const SizedBox(height: 8),
          _buildTimeInterceptorCard(context, ref),
          const SizedBox(height: 12),
          _buildSmsSettingsCard(context),
          const SizedBox(height: 12),
          _buildContactSettingsCard(context),
          const SizedBox(height: 12),
          _buildMarkPhoneManagementCard(context),
          const SizedBox(height: 24),
          _buildSectionTitle(
              AppLocalizations.of(context)!.cloudSyncAndBackupTitle),
          const SizedBox(height: 8),
          _buildCloudSettingsCard(context),
          const SizedBox(height: 12),
          _buildBackupRestoreCard(context),
          const SizedBox(height: 12),
          _buildDeviceManagementCard(context),
          const SizedBox(height: 24),
          _buildSectionTitle(AppLocalizations.of(context)!.systemSettingsTitle),
          const SizedBox(height: 8),
          _buildAutoUpdateCard(context),
          const SizedBox(height: 12),
          _buildPluginManagementCard(context),
          const SizedBox(height: 12),
          _buildSearchCard(context),
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
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.usernameLabel,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    AppLocalizations.of(context)!.userEmail,
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
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
    return Column(
      children: [
        _buildSettingsCard(
          context,
          icon: Icons.phone,
          iconColor: Colors.blue,
          title: AppLocalizations.of(context)!.callSettingsTitle,
          subtitle: AppLocalizations.of(context)!.callSettingsSubtitle,
          onTap: () {
            // 使用GoRouter导航到来电设置页面
            GoRouter.of(context).push('/phone-subscription');
          },
        ),
        const SizedBox(height: 8),
        _buildSettingsCard(
          context,
          icon: Icons.filter_alt,
          iconColor: Colors.deepPurple,
          title: AppLocalizations.of(context)!.filterControlTitle,
          subtitle: AppLocalizations.of(context)!.filterControlSubtitle,
          onTap: () {
            // 使用GoRouter导航到过滤器设置页面
            GoRouter.of(context).push('/filter-settings');
          },
        ),
        const SizedBox(height: 8),
        _buildSettingsCard(
          context,
          icon: Icons.block,
          iconColor: Colors.red,
          title: AppLocalizations.of(context)!.interceptionActionSettingsTitle,
          subtitle:
              AppLocalizations.of(context)!.interceptionActionSettingsSubtitle,
          onTap: () {
            GoRouter.of(context).push('/end-call-settings');
          },
        ),
      ],
    );
  }

  Widget _buildTimeInterceptorCard(BuildContext context, WidgetRef ref) {
    return _buildSettingsCard(
      context,
      icon: Icons.timer,
      iconColor: Colors.deepOrange,
      title: AppLocalizations.of(context)!.callFrequencyInterceptionTitle,
      subtitle: AppLocalizations.of(context)!.callFrequencyInterceptionSubtitle,
      onTap: () {
        final timeInterceptorService = ref.read(timeInterceptorServiceProvider);
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          builder: (context) => DraggableScrollableSheet(
            initialChildSize: 0.7,
            minChildSize: 0.5,
            maxChildSize: 0.95,
            expand: false,
            builder: (context, scrollController) => SingleChildScrollView(
              controller: scrollController,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: TimeInterceptorSettingsWidget(
                  isEnabled: timeInterceptorService.config.shouldIntercept,
                  durationMinutes: timeInterceptorService.config.duration.inMinutes,
                  onEnabledChanged: (value) => timeInterceptorService.updateConfig(
                    timeInterceptorService.config.duration,
                    value,
                  ),
                  onDurationMinutesChanged: (value) => timeInterceptorService.updateConfig(
                    Duration(minutes: value),
                    timeInterceptorService.config.shouldIntercept,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSmsSettingsCard(BuildContext context) {
    return _buildSettingsCard(
      context,
      icon: Icons.sms,
      iconColor: Colors.orange,
      title: AppLocalizations.of(context)!.smsSettingsTitle,
      subtitle: AppLocalizations.of(context)!.smsSettingsSubtitle,
      onTap: () {
        // 使用GoRouter导航到带广告的短信订阅页面
        GoRouter.of(context).push('/sms-subscription-with-ads');
      },
    );
  }

  Widget _buildContactSettingsCard(BuildContext context) {
    return _buildSettingsCard(
      context,
      icon: Icons.contacts,
      iconColor: Colors.green,
      title: AppLocalizations.of(context)!.contactSettingsTitle,
      subtitle: AppLocalizations.of(context)!.contactSettingsSubtitle,
      onTap: () {
        // 导航到联系人设置页面
        // 这里暂时没有实现联系人页面
      },
    );
  }

  Widget _buildMarkPhoneManagementCard(BuildContext context) {
    return _buildSettingsCard(
      context,
      icon: Icons.label,
      iconColor: Colors.deepPurple,
      title: AppLocalizations.of(context)!.markPhoneManagementTitle,
      subtitle: AppLocalizations.of(context)!.markPhoneManagementSubtitle,
      onTap: () {
        // 使用GoRouter导航到号码标记管理页面
        GoRouter.of(context).push('/mark-phone-management');
      },
    );
  }

  Widget _buildCloudSettingsCard(BuildContext context) {
    return _buildSettingsCard(
      context,
      icon: Icons.cloud,
      iconColor: Colors.lightBlue,
      title: AppLocalizations.of(context)!.cloudSyncSettingsTitle,
      subtitle: AppLocalizations.of(context)!.cloudSyncSettingsSubtitle,
      onTap: () {
        // 使用GoRouter导航到云端同步设置页面
        GoRouter.of(context).push('/cloud-settings');
      },
    );
  }

  Widget _buildBackupRestoreCard(BuildContext context) {
    return _buildSettingsCard(
      context,
      icon: Icons.backup,
      iconColor: Colors.indigo,
      title: AppLocalizations.of(context)!.backupAndRestoreTitle,
      subtitle: AppLocalizations.of(context)!.backupAndRestoreSubtitle,
      onTap: () {
        // 使用GoRouter导航到备份与恢复页面
        GoRouter.of(context).push('/backup-restore');
      },
    );
  }

  Widget _buildDeviceManagementCard(BuildContext context) {
    return _buildSettingsCard(
      context,
      icon: Icons.devices,
      iconColor: Colors.deepOrange,
      title: AppLocalizations.of(context)!.deviceManagementTitle,
      subtitle: AppLocalizations.of(context)!.deviceManagementSubtitle,
      onTap: () {
        // 使用GoRouter导航到设备管理页面
        GoRouter.of(context).push('/device-management');
      },
    );
  }

  Widget _buildAutoUpdateCard(BuildContext context) {
    return _buildSettingsCard(
      context,
      icon: Icons.update,
      iconColor: Colors.purple,
      title: AppLocalizations.of(context)!.autoUpdateTitle,
      subtitle: AppLocalizations.of(context)!.autoUpdateSubtitle,
      onTap: () {
        // 使用GoRouter导航到自动更新设置页面
        GoRouter.of(context).push('/auto-update');
      },
    );
  }

  Widget _buildPluginManagementCard(BuildContext context) {
    return _buildSettingsCard(
      context,
      icon: Icons.extension,
      iconColor: Colors.amber,
      title: AppLocalizations.of(context)!.pluginManagementTitle,
      subtitle: AppLocalizations.of(context)!.pluginManagementSubtitle,
      onTap: () {
        // 使用GoRouter导航到插件管理页面
        GoRouter.of(context).push('/plugin-management');
      },
    );
  }

  Widget _buildLanguageSettingsCard(BuildContext context) {
    return _buildSettingsCard(
      context,
      icon: Icons.language,
      iconColor: Colors.teal,
      title: AppLocalizations.of(context)!.languageSettingsTitle,
      subtitle: AppLocalizations.of(context)!.languageSettingsSubtitle,
      onTap: () {
        // 使用GoRouter导航到语言设置页面
        GoRouter.of(context).push('/language-settings');
      },
    );
  }

  Widget _buildSearchCard(BuildContext context) {
    return _buildSettingsCard(
      context,
      icon: Icons.search,
      iconColor: Colors.blueGrey,
      title: AppLocalizations.of(context)!.searchSettingsTitle,
      subtitle: AppLocalizations.of(context)!.searchSettingsSubtitle,
      onTap: () {
        // 使用GoRouter导航到搜索页面
        GoRouter.of(context).push('/search');
      },
    );
  }

  Widget _buildAboutCard(BuildContext context) {
    return _buildSettingsCard(
      context,
      icon: Icons.info_outline,
      iconColor: Colors.blue,
      title: AppLocalizations.of(context)!.aboutTitle,
      subtitle: AppLocalizations.of(context)!.aboutSubtitle,
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