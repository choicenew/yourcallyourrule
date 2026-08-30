import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yourcallyourrule/features/call/time_interceptor/presentation/widgets/time_interceptor_settings_widget.dart';
import 'package:yourcallyourrule/features/home_elite/presentation/widgets/elite_floating_nav_bar.dart';
import 'package:yourcallyourrule/features/home_elite/theme/elite_dopamine_theme.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';
import 'package:yourcallyourrule/presentation/about.dart';
import 'package:yourcallyourrule/theme/theme_selector.dart';

class EliteSettingsPage extends ConsumerStatefulWidget {
  const EliteSettingsPage({super.key});

  @override
  ConsumerState<EliteSettingsPage> createState() => _EliteSettingsPageState();
}

class _EliteSettingsPageState extends ConsumerState<EliteSettingsPage> {
  int _currentIndex = 4; // Settings tab is index 4

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: EliteDopamineTheme.warmCanvasBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        title: Text(
          l10n.settingsTitle,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w900,
            color: Colors.black87,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black87, size: 20),
          onPressed: () {
            if (GoRouter.of(context).canPop()) {
              context.pop();
            } else {
              context.go('/elite-home');
            }
          },
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          physics: const BouncingScrollPhysics(),
          children: [
            // 1. 账户与基础偏好组
            _buildSectionHeader(l10n.systemSettingsTitle, Icons.person_pin_circle_rounded, EliteDopamineTheme.warmSunAmber),
            _buildGroupedCard(
              glowColor: EliteDopamineTheme.warmSunAmber,
              children: [
                _buildTile(
                  icon: Icons.workspace_premium_rounded,
                  iconColor: EliteDopamineTheme.warmSunAmber,
                  title: l10n.purchaseTitle,
                  subtitle: l10n.purchaseDescription,
                  onTap: () => context.push('/purchase'),
                ),
                _buildDivider(),
                _buildTile(
                  icon: Icons.translate_rounded,
                  iconColor: EliteDopamineTheme.sunsetTangerine,
                  title: l10n.languageSettingsTitle,
                  subtitle: l10n.languageSettingsDescription,
                  onTap: () => context.push('/language-settings'),
                ),
                _buildDivider(),
                _buildTile(
                  icon: Icons.palette_rounded,
                  iconColor: EliteDopamineTheme.softLilac,
                  title: l10n.themeTitle,
                  subtitle: l10n.themeDescription,
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => const ThemeSelector(),
                    );
                  },
                ),
                _buildDivider(),
                _buildTile(
                  icon: Icons.sync_rounded,
                  iconColor: EliteDopamineTheme.freshMint,
                  title: l10n.autoUpdateTitle,
                  subtitle: l10n.autoUpdateDescription,
                  onTap: () => context.push('/auto-update'),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // 2. 防护与拦截总控组
            _buildSectionHeader(l10n.functionSettingsTitle, Icons.security_rounded, EliteDopamineTheme.vibrantCoral),
            _buildGroupedCard(
              glowColor: EliteDopamineTheme.vibrantCoral,
              children: [
                _buildTile(
                  icon: Icons.phone_disabled_rounded,
                  iconColor: EliteDopamineTheme.vibrantCoral,
                  title: l10n.interceptionActionSettingsTitle,
                  subtitle: l10n.interceptionActionSettingsSubtitle,
                  onTap: () => context.push('/end-call-settings'),
                ),
                _buildDivider(),
                _buildTile(
                  icon: Icons.timelapse_rounded,
                  iconColor: EliteDopamineTheme.sunsetTangerine,
                  title: l10n.callFrequencyInterceptionTitle,
                  subtitle: l10n.callFrequencyInterceptionSubtitle,
                  onTap: () => _showTimeInterceptorSheet(context),
                ),
                _buildDivider(),
                _buildTile(
                  icon: Icons.shield_outlined,
                  iconColor: EliteDopamineTheme.skyAzure,
                  title: l10n.specialPermissionsTitle,
                  subtitle: l10n.specialPermissionsDescription,
                  onTap: () => context.push('/special-permissions'),
                ),
                _buildDivider(),
                _buildTile(
                  icon: Icons.filter_alt_rounded,
                  iconColor: EliteDopamineTheme.softLilac,
                  title: l10n.filterControlTitle,
                  subtitle: l10n.filterControlSubtitle,
                  onTap: () => context.push('/filter-settings'),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // 3. 云端同步与数据
            _buildSectionHeader(l10n.cloudSyncAndBackupTitle, Icons.cloud_done_rounded, EliteDopamineTheme.skyAzure),
            _buildGroupedCard(
              glowColor: EliteDopamineTheme.skyAzure,
              children: [
                _buildTile(
                  icon: Icons.public_rounded,
                  iconColor: EliteDopamineTheme.skyAzure,
                  title: l10n.databaseSyncTitle,
                  subtitle: l10n.databaseSyncDescription,
                  onTap: () => context.push('/country-sync-settings'),
                ),
                _buildDivider(),
                _buildTile(
                  icon: Icons.cloud_sync_rounded,
                  iconColor: EliteDopamineTheme.freshMint,
                  title: l10n.supabaseTitle,
                  subtitle: l10n.supabaseDescription,
                  onTap: () => context.push('/supabase-settings'),
                ),
                _buildDivider(),
                _buildTile(
                  icon: Icons.settings_backup_restore_rounded,
                  iconColor: EliteDopamineTheme.warmSunAmber,
                  title: l10n.backupRestoreTitle,
                  subtitle: l10n.backupRestoreSubtitle,
                  onTap: () => context.push('/backup-restore'),
                ),
                _buildDivider(),
                _buildTile(
                  icon: Icons.devices_rounded,
                  iconColor: EliteDopamineTheme.softLilac,
                  title: l10n.deviceManagementTitle,
                  subtitle: l10n.deviceManagementSubtitle,
                  onTap: () => context.push('/device-management'),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // 4. 社区与关于
            _buildSectionHeader(l10n.aboutAppTitle, Icons.info_outline_rounded, EliteDopamineTheme.softLilac),
            _buildGroupedCard(
              glowColor: EliteDopamineTheme.softLilac,
              children: [
                _buildTile(
                  icon: Icons.how_to_vote_rounded,
                  iconColor: EliteDopamineTheme.warmSunAmber,
                  title: l10n.deletionProposals,
                  subtitle: l10n.deletionProposalsDescription,
                  onTap: () => context.push('/deletion-proposal'),
                ),
                _buildDivider(),
                _buildTile(
                  icon: Icons.info_rounded,
                  iconColor: EliteDopamineTheme.softLilac,
                  title: l10n.aboutAppTitle,
                  subtitle: l10n.aboutAppDescription,
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                      ),
                      builder: (context) => const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: AboutCard(),
                      ),
                    );
                  },
                ),
              ],
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
      bottomNavigationBar: EliteFloatingNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          EliteFloatingNavBar.handleEliteNavigation(context, index);
        },
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.only(left: 4.0, bottom: 10.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 16, color: color),
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w800,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGroupedCard({
    required List<Widget> children,
    required Color glowColor,
  }) {
    return Container(
      decoration: EliteDopamineTheme.warmCardDecoration(
        context: context,
        glowColor: glowColor,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Column(
          children: children,
        ),
      ),
    );
  }

  Widget _buildTile({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, size: 20, color: iconColor),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey[600],
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 14,
                color: Colors.grey[400],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      height: 1,
      thickness: 1,
      indent: 56,
      endIndent: 16,
      color: Colors.grey[200]!,
    );
  }

  void _showTimeInterceptorSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
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
            child: TimeInterceptorSettingsWidget(),
          ),
        ),
      ),
    );
  }
}
