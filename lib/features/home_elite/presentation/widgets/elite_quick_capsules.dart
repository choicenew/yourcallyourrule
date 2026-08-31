// -----------------------------------------------------------------------------
// 文件: elite_quick_capsules.dart
// 描述: Elite 功能快捷胶囊入口矩阵，聚合高频通讯工具与核心规则配置。
// -----------------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:go_router/go_router.dart';
import 'package:yourcallyourrule/core/router/app_router.dart';
import 'package:yourcallyourrule/features/home_elite/theme/elite_dopamine_theme.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

// ------------------- Widget 定义 -------------------

class EliteQuickCapsules extends StatelessWidget {
  const EliteQuickCapsules({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 4 大核心日常功能入口（大卡片微光排列）
          Row(
            children: [
              Expanded(
                child: _buildPrimaryFeatureCard(
                  context: context,
                  title: l10n.markPhoneManagementTitle,
                  subtitle: l10n.labels,
                  icon: Icons.label_important_rounded,
                  color: EliteDopamineTheme.warmSunAmber,
                  gradient: EliteDopamineTheme.heroWarmGradient,
                  onTap: () => context.pushNamed(AppRouter.markPhoneManagementWithAds),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildPrimaryFeatureCard(
                  context: context,
                  title: l10n.contactsTab,
                  subtitle: l10n.contactsManagement,
                  icon: Icons.contacts_rounded,
                  color: EliteDopamineTheme.sunsetTangerine,
                  gradient: EliteDopamineTheme.coralSunsetGradient,
                  onTap: () => context.pushNamed(AppRouter.contactsManagement),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          Row(
            children: [
              Expanded(
                child: _buildPrimaryFeatureCard(
                  context: context,
                  title: l10n.callHistoryTab,
                  subtitle: l10n.callHistory,
                  icon: Icons.call_rounded,
                  color: EliteDopamineTheme.skyAzure,
                  gradient: const LinearGradient(
                    colors: [Color(0xFF007AFF), Color(0xFF5AC8FA)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  onTap: () => context.pushNamed(AppRouter.callHistory),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildPrimaryFeatureCard(
                  context: context,
                  title: l10n.pluginManagement,
                  subtitle: l10n.pluginManagement,
                  icon: Icons.extension_rounded,
                  color: EliteDopamineTheme.freshMint,
                  gradient: const LinearGradient(
                    colors: [Color(0xFF34C759), Color(0xFF30D158)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  onTap: () => context.pushNamed(AppRouter.pluginManagement),
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // 核心拦截规则与工具胶囊网格
          Text(
            l10n.phoneRuleManagement,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w800,
              color: Colors.grey[700],
              letterSpacing: 0.8,
            ),
          ),

          const SizedBox(height: 8),

          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildCompactCapsule(
                context: context,
                icon: Icons.shield_outlined,
                title: l10n.allowBlock,
                color: EliteDopamineTheme.freshMint,
                onTap: () => context.pushNamed(AppRouter.allowedBlockedSettingsWithAds),
              ),
              _buildCompactCapsule(
                context: context,
                icon: Icons.sim_card_outlined,
                title: l10n.simSlotRules,
                color: EliteDopamineTheme.sunsetTangerine,
                onTap: () => context.pushNamed(
                  AppRouter.simSlotRuleWithAds,
                  pathParameters: {'simSlotIndex': '0'},
                ),
              ),
              _buildCompactCapsule(
                context: context,
                icon: Icons.code_rounded,
                title: l10n.regexRules,
                color: EliteDopamineTheme.warmSunAmber,
                onTap: () => context.pushNamed(AppRouter.regexRuleWithAds),
              ),
              _buildCompactCapsule(
                context: context,
                icon: Icons.cloud_download_outlined,
                title: l10n.phoneSubscription,
                color: EliteDopamineTheme.softLilac,
                onTap: () => context.pushNamed(AppRouter.phoneSubscription),
              ),
              _buildCompactCapsule(
                context: context,
                icon: Icons.timer_outlined,
                title: l10n.timeInterceptor,
                color: EliteDopamineTheme.skyAzure,
                onTap: () => context.pushNamed(AppRouter.timeInterceptorSettings),
              ),
              _buildCompactCapsule(
                context: context,
                icon: Icons.cloud_sync_outlined,
                title: l10n.cloudSyncTitle,
                color: EliteDopamineTheme.warmSunAmber,
                onTap: () => context.pushNamed(AppRouter.cloudSettings),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPrimaryFeatureCard({
    required BuildContext context,
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required Gradient gradient,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: color.withValues(alpha: 0.18),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.08),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  gradient: gradient,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: color.withValues(alpha: 0.3),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(icon, color: Colors.white, size: 20),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                        color: Colors.black87,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[600],
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCompactCapsule({
    required BuildContext context,
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: color.withValues(alpha: 0.25),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.02),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 14, color: color),
              const SizedBox(width: 5),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ------------------- Widget Previewer 支持 -------------------

@Preview(name: 'Quick Capsules', group: 'Elite Showcase')
Widget previewEliteQuickCapsules() {
  return const MaterialApp(
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    home: Scaffold(
      backgroundColor: EliteDopamineTheme.warmCanvasBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          child: EliteQuickCapsules(),
        ),
      ),
    ),
  );
}
