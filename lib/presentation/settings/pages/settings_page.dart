import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yourcallyourrule/core/router/app_router.dart';

// [重构]: 不再需要导入 TimeInterceptorService 或其 provider
import 'package:yourcallyourrule/features/call/time_interceptor/presentation/widgets/time_interceptor_settings_widget.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';
import 'package:yourcallyourrule/presentation/about.dart';
import 'package:yourcallyourrule/theme/theme_selector.dart';

// [注释]: 页面本身已经是 ConsumerWidget，保持不变。
class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settingsTitle),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (GoRouter.of(context).canPop()) {
              context.pop();
            } else {
              GoRouter.of(context).goNamed(AppRouter.home);
            }
          },
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildSectionTitle(AppLocalizations.of(context)!.systemSettingsTitle),
          const SizedBox(height: 12),
          _buildLanguageSettingsCard(context),
          const SizedBox(height: 12),
          _buildPurchaseCard(context),
          const SizedBox(height: 8),
          _buildAutoUpdateCard(context),
          const SizedBox(height: 12),
          _buildSpecialPermissionsCard(context),
          const SizedBox(height: 12),
          _buildThemeSettingsCard(context),
          const SizedBox(height: 24),
          _buildSectionTitle(AppLocalizations.of(context)!.databaseSyncTitle),
          const SizedBox(height: 8),
          _buildCountrySyncSettingsCard(context),
          const SizedBox(height: 24),
          _buildSectionTitle(AppLocalizations.of(context)!.functionSettingsTitle),
          const SizedBox(height: 8),
          _buildCallSettingsCard(context),
          const SizedBox(height: 8),
          // [重构]: _buildTimeInterceptorCard 不再需要传递 ref。
          _buildTimeInterceptorCard(context),
          const SizedBox(height: 24),
          _buildSectionTitle(AppLocalizations.of(context)!.cloudSyncAndBackupTitle),
                    const SizedBox(height: 12),
          _buildSupabaseSettingsCard(context),
          const SizedBox(height: 8),
          _buildCloudSettingsCard(context),
          const SizedBox(height: 12),
          _buildBackupRestoreCard(context),
          const SizedBox(height: 12),
          _buildDeviceManagementCard(context),


          const SizedBox(height: 24),
          _buildAboutCard(context),
        ],
      ),
    );
  }

  // [注释]: _buildTimeInterceptorCard 的重构是本次修改的核心。
  Widget _buildTimeInterceptorCard(BuildContext context) {
    return _buildSettingsCard(
      context,
      icon: Icons.timer,
      iconColor: Colors.deepOrange,
      title: AppLocalizations.of(context)!.callFrequencyInterceptionTitle,
      subtitle: AppLocalizations.of(context)!.callFrequencyInterceptionSubtitle,
      onTap: () {
        // [重构]: 不再需要 ref.read 来获取 service 实例。
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
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                // [重构]: 直接使用自包含的 TimeInterceptorSettingsWidget，
                // 它不再需要任何参数。
                child: TimeInterceptorSettingsWidget(),
              ),
            ),
          ),
        );
      },
    );
  }

  // --- 以下所有方法都与状态管理无关，保持原样，无需修改 ---
  
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildCallSettingsCard(BuildContext context) {
    return Column(
      children: [
        _buildSettingsCard(
          context,
          icon: Icons.filter_alt,
          iconColor: Colors.deepPurple,
          title: AppLocalizations.of(context)!.filterControlTitle,
          subtitle: AppLocalizations.of(context)!.filterControlSubtitle,
          onTap: () {
            GoRouter.of(context).push('/filter-settings');
          },
        ),
        const SizedBox(height: 8),
        _buildSettingsCard(
          context,
          icon: Icons.block,
          iconColor: Colors.red,
          title: AppLocalizations.of(context)!.interceptionActionSettingsTitle,
          subtitle: AppLocalizations.of(context)!.interceptionActionSettingsSubtitle,
          onTap: () {
            GoRouter.of(context).push('/end-call-settings');
          },
        ),
        const SizedBox(height: 8),
        _buildSettingsCard(
          context,
          icon: Icons.call_end,
          iconColor: Colors.orange,
          title: AppLocalizations.of(context)!.callerIdCustomizationTitle,
          subtitle: AppLocalizations.of(context)!.callerIdCustomizationSubtitle,
          onTap: () {
            GoRouter.of(context).push('/caller-id-customization');
          },
        ),
        /*
        const SizedBox(height: 8),
        _buildSettingsCard(
          context,
          icon: Icons.live_tv,
          iconColor: Colors.red,
          title: AppLocalizations.of(context)!.liveActivitiesTestTitle,
          subtitle: AppLocalizations.of(context)!.liveActivitiesTestSubtitle,
          onTap: () {
            GoRouter.of(context).push('/live-activities-test');
          },
        ),
        */
        const SizedBox(height: 8),
        /*
        // [Legacy] 原始基于 live_updates 自由排版页面（保留供后续观察与过渡使用）
        _buildSettingsCard(
          context,
          icon: Icons.notifications_active,
          iconColor: Colors.blue,
          title: AppLocalizations.of(context)!.liveNotificationCustomizationTitle,
          subtitle: AppLocalizations.of(context)!.liveNotificationCustomizationSubtitle,
          onTap: () {
            GoRouter.of(context).push('/live-notification-customization');
          },
        ),
        */
        _buildSettingsCard(
          context,
          icon: Icons.notifications_active,
          iconColor: Colors.blue,
          title: AppLocalizations.of(context)!.liveNotificationCustomizationTitle,
          subtitle: AppLocalizations.of(context)!.liveNotificationCustomizationSubtitle,
          onTap: () {
            GoRouter.of(context).push('/kit-live-notification-customization');
          },
        ),
        const SizedBox(height: 8),
        _buildSettingsCard(
          context,
          icon: Icons.notifications,
          iconColor: Colors.blue,
          title: AppLocalizations.of(context)!.callerIdSettingsTitle,
          subtitle: AppLocalizations.of(context)!.callerIdSettingsSubtitle,
          onTap: () {
            GoRouter.of(context).push('/caller-id-settings');
          },
        ),
        const SizedBox(height: 8),
        _buildSettingsCard(
          context,
          icon: Icons.warning_amber_rounded,
          iconColor: Colors.amber,
          title: AppLocalizations.of(context)!.fraudAlerSettingTitle,
          subtitle: AppLocalizations.of(context)!.fraudAlerSettingSubtitle,
          onTap: () {
            GoRouter.of(context).push('/fraud-alert-settings');
          },
        ),
      ],
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
        GoRouter.of(context).push('/auto-update');
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
        GoRouter.of(context).push('/language-settings');
      },
    );
  }

  Widget _buildPurchaseCard(BuildContext context) {
    return _buildSettingsCard(
      context,
      icon: Icons.shopping_cart,
      iconColor: Colors.green,
      title: AppLocalizations.of(context)!.purchaseTitle,
      subtitle: AppLocalizations.of(context)!.purchaseSubtitle,
      onTap: () {
        GoRouter.of(context).push('/purchase');
      },
    );
  }

  Widget _buildThemeSettingsCard(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.primary.withValues(alpha:0.1),
                  child: Icon(Icons.palette, color: Theme.of(context).colorScheme.primary),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.themeSettingsTitle,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        AppLocalizations.of(context)!.themeSettingsSubtitle,
                        style: const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Center(child: ThemeSelector()),
          ],
        ),
      ),
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
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const AboutPage(),
          ),
        );
      },
    );
  }

  Widget _buildCountrySyncSettingsCard(BuildContext context) {
    return _buildSettingsCard(
      context,
      icon: Icons.sync,
      iconColor: Colors.blue,
      title: AppLocalizations.of(context)!.countrySyncSettingsTitle,
      subtitle: AppLocalizations.of(context)!.countrySyncSettingsSubtitle,
      onTap: () {
        GoRouter.of(context).push('/${AppRouter.countrySyncSettings}');
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
                backgroundColor: iconColor.withValues(alpha:0.1),
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
  
  Widget _buildSpecialPermissionsCard(BuildContext context) {
    return _buildSettingsCard(
      context,
      icon: Icons.security,
      iconColor: Colors.red,
      title: AppLocalizations.of(context)!.permissionTitle,
      subtitle: AppLocalizations.of(context)!.permissionSubtitle,
      onTap: () {
        GoRouter.of(context).push('/special-permissions');
      },
    );
  }

  Widget _buildSupabaseSettingsCard(BuildContext context) {
    return _buildSettingsCard(
      context,
      icon: Icons.cloud_upload,
      iconColor: Colors.amber,
      title: AppLocalizations.of(context)!.localDatabaseSyncTitle,
      subtitle: AppLocalizations.of(context)!.localDatabaseSyncSubtitle,
      onTap: () {
        GoRouter.of(context).push('/supabase-settings');
      },
    );
  }
}