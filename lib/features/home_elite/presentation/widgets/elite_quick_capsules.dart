import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yourcallyourrule/features/home_elite/theme/elite_dopamine_theme.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

class EliteQuickCapsules extends StatelessWidget {
  const EliteQuickCapsules({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: EliteDopamineTheme.dopamineCardDecoration(
        context: context,
        glowColor: EliteDopamineTheme.neonCyan,
      ),
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 标题与分类
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [EliteDopamineTheme.neonCyan, EliteDopamineTheme.emeraldGreen],
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.widgets_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n?.featureCenter ?? 'Smart Toolkit & Rules',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        'Direct access to all protection engines',
                        style: TextStyle(
                          fontSize: 11,
                          color: isDark ? Colors.grey[400] : Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 18),

          // 一、高频日常安全大卡片（双列灵动卡）
          Row(
            children: [
              Expanded(
                child: _buildFeaturedActionCard(
                  title: l10n?.allowBlock ?? 'Allow / Block',
                  subtitle: 'Custom numbers & lists',
                  icon: Icons.shield_outlined,
                  color: EliteDopamineTheme.emeraldGreen,
                  isDark: isDark,
                  onTap: () => context.push('/allowed-blocked-settings-with-ads'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildFeaturedActionCard(
                  title: l10n?.markPhoneManagementTitle ?? 'Marked Numbers',
                  subtitle: 'Crowdsourced tags & labels',
                  icon: Icons.label_important_outline_rounded,
                  color: EliteDopamineTheme.electricViolet,
                  isDark: isDark,
                  onTap: () => context.push('/mark-phone-management-with-ads'),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: _buildFeaturedActionCard(
                  title: l10n?.callHistoryTab ?? 'Call Timeline',
                  subtitle: 'Intercepted logs & detail',
                  icon: Icons.history_rounded,
                  color: EliteDopamineTheme.neonCyan,
                  isDark: isDark,
                  onTap: () => context.push('/call-history'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildFeaturedActionCard(
                  title: l10n?.contactsTab ?? 'Contacts Shield',
                  subtitle: 'Address book rules',
                  icon: Icons.contacts_rounded,
                  color: EliteDopamineTheme.sunsetOrange,
                  isDark: isDark,
                  onTap: () => context.push('/contacts-management'),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // 二、进阶极客扩展胶囊区（横向多巴胺药丸）
          Text(
            'ADVANCED EXTENSIONS & ENGINES',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.0,
              color: isDark ? Colors.grey[400] : Colors.grey[600],
            ),
          ),
          const SizedBox(height: 10),

          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: [
              _buildCapsulePill(
                title: l10n?.pluginManagement ?? 'Plugins',
                icon: Icons.extension_rounded,
                color: const Color(0xFFAB47BC),
                isDark: isDark,
                onTap: () => context.push('/plugin-management-with-ads'),
              ),
              _buildCapsulePill(
                title: l10n?.regexRules ?? 'Regex Engine',
                icon: Icons.code_rounded,
                color: const Color(0xFF26A69A),
                isDark: isDark,
                onTap: () => context.push('/regex-rule-with-ads'),
              ),
              _buildCapsulePill(
                title: l10n?.phoneSubscription ?? 'Subscriptions',
                icon: Icons.cloud_download_rounded,
                color: const Color(0xFF42A5F5),
                isDark: isDark,
                onTap: () => context.push('/phone-subscription-with-ads'),
              ),
              _buildCapsulePill(
                title: l10n?.simSlotRules ?? 'Dual SIM',
                icon: Icons.sim_card_rounded,
                color: const Color(0xFFFFA726),
                isDark: isDark,
                onTap: () => context.push('/sim-slot-rule-with-ads/0'),
              ),
              _buildCapsulePill(
                title: 'SMS Rules',
                icon: Icons.sms_rounded,
                color: const Color(0xFFEF5350),
                isDark: isDark,
                onTap: () => context.push('/sms-management'),
              ),
              _buildCapsulePill(
                title: 'Cloud Sync',
                icon: Icons.sync_rounded,
                color: const Color(0xFF7E57C2),
                isDark: isDark,
                onTap: () => context.push('/cloud-settings'),
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
    required bool isDark,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: isDark ? Colors.white.withValues(alpha: 0.04) : Colors.grey[50],
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: isDark ? Colors.white.withValues(alpha: 0.08) : Colors.grey[200]!,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              const SizedBox(height: 10),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 10,
                  color: isDark ? Colors.grey[400] : Colors.grey[600],
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
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
    required bool isDark,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: isDark ? Colors.white.withValues(alpha: 0.05) : Colors.grey[100],
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: color.withValues(alpha: 0.3),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 14, color: color),
              const SizedBox(width: 6),
              Text(
                title,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: isDark ? Colors.white70 : Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
