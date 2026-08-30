// -----------------------------------------------------------------------------
// 文件: elite_quick_capsules.dart
// 描述: Elite 功能胶囊区，精选高频日常拦截与进阶规则引擎（插件、正则、订阅、SIM 卡、云同步）。
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
      decoration: EliteDopamineTheme.warmCardDecoration(
        context: context,
        glowColor: EliteDopamineTheme.warmSunAmber,
      ),
      padding: const EdgeInsets.all(18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 标题与分类
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                  gradient: EliteDopamineTheme.heroWarmGradient,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.widgets_rounded,
                  color: Colors.white,
                  size: 18,
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.phoneRuleManagement,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    l10n.filterManagementDescription,
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 14),

          // 一、高频日常安全大卡片（双列灵动卡）
          Row(
            children: [
              Expanded(
                child: _buildFeaturedActionCard(
                  title: l10n.allowBlock,
                  subtitle: l10n.ruleManagementTitle,
                  icon: Icons.shield_outlined,
                  color: EliteDopamineTheme.freshMint,
                  onTap: () => context.push('/${AppRouter.allowedBlockedSettingsWithAds}'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildFeaturedActionCard(
                  title: l10n.markPhoneManagementTitle,
                  subtitle: l10n.labelManagementTitle,
                  icon: Icons.label_important_outline_rounded,
                  color: EliteDopamineTheme.warmSunAmber,
                  onTap: () => context.push('/${AppRouter.markPhoneManagementWithAds}'),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          Row(
            children: [
              Expanded(
                child: _buildFeaturedActionCard(
                  title: l10n.callHistoryTab,
                  subtitle: l10n.blockedCallsToday,
                  icon: Icons.history_rounded,
                  color: EliteDopamineTheme.skyAzure,
                  onTap: () => context.push('/${AppRouter.callHistory}'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildFeaturedActionCard(
                  title: l10n.contactsTab,
                  subtitle: l10n.serviceTypeContact,
                  icon: Icons.contacts_rounded,
                  color: EliteDopamineTheme.sunsetTangerine,
                  onTap: () => context.push('/${AppRouter.contactsManagement}'),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // 二、进阶极客扩展胶囊区
          Text(
            l10n.advancedRuleSettingsTitle.toUpperCase(),
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w900,
              letterSpacing: 0.8,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),

          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: [
              _buildCapsulePill(
                title: l10n.pluginManagement,
                icon: Icons.extension_rounded,
                color: EliteDopamineTheme.softLilac,
                onTap: () => context.push('/${AppRouter.pluginManagement}'),
              ),
              _buildCapsulePill(
                title: l10n.regexRules,
                icon: Icons.code_rounded,
                color: EliteDopamineTheme.skyAzure,
                onTap: () => context.push('/${AppRouter.regexRuleWithAds}'),
              ),
              _buildCapsulePill(
                title: l10n.phoneSubscription,
                icon: Icons.cloud_download_rounded,
                color: EliteDopamineTheme.freshMint,
                onTap: () => context.push('/${AppRouter.phoneSubscription}'),
              ),
              _buildCapsulePill(
                title: l10n.simSlotRules,
                icon: Icons.sim_card_rounded,
                color: EliteDopamineTheme.warmSunAmber,
                onTap: () => context.push('/${AppRouter.simSlotRuleWithAds}/0'),
              ),
              _buildCapsulePill(
                title: l10n.smsFilterManagement,
                icon: Icons.sms_rounded,
                color: EliteDopamineTheme.vibrantCoral,
                onTap: () => context.push('/${AppRouter.smsManagement}'),
              ),
              _buildCapsulePill(
                title: l10n.cloudSettingsTitle,
                icon: Icons.sync_rounded,
                color: EliteDopamineTheme.sunsetTangerine,
                onTap: () => context.push('/${AppRouter.cloudSettings}'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedActionCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xFFFBF9F5),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: color.withValues(alpha: 0.22),
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w800,
                        color: Colors.black87,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 9.5,
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

  Widget _buildCapsulePill({
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 7),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: color.withValues(alpha: 0.28),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 13, color: color),
              const SizedBox(width: 4),
              Text(
                title,
                style: TextStyle(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w700,
                  color: Colors.grey[800],
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

@Preview(name: 'Quick Action Capsules', group: 'Elite Showcase')
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
