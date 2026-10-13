// -----------------------------------------------------------------------------
// 文件: elite_app_bar.dart
// 描述: Elite 顶部应用栏，动态读取系统默认来电拦截角色权限状态（Protection Active/Inactive），支持点击直接调起原生授权。
// -----------------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yourcallyourrule/core/router/app_router.dart';
import 'package:yourcallyourrule/features/caller_id/services/call_protection_service.dart';
import 'package:yourcallyourrule/features/caller_id/services/call_screen_plugin.dart';
import 'package:yourcallyourrule/features/home/di/home_stats_provider.dart';
import 'package:yourcallyourrule/features/home_elite/theme/elite_dopamine_theme.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

// ------------------- Widget 定义 -------------------

class EliteAppBar extends ConsumerWidget {
  final VoidCallback? onSwitchToPro;

  const EliteAppBar({
    super.key,
    this.onSwitchToPro,
  });

  void _handleSettingsTap(BuildContext context) {
    context.pushNamed(AppRouter.settings);
  }

  void _handleNotificationsTap(BuildContext context) {
    context.pushNamed(AppRouter.notifications);
  }

  void _handleProSwitch(BuildContext context) {
    if (onSwitchToPro != null) {
      onSwitchToPro!();
    } else {
      context.goNamed(AppRouter.proHome);
    }
  }

  Future<void> _handleStatusTap(BuildContext context, WidgetRef ref, bool isProtectionActive) async {
    final l10n = AppLocalizations.of(context)!;
    if (isProtectionActive) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.callScreeningPermission),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 2),
        ),
      );
    } else {
      // 调起 Android 原生“设为默认来电拦截与识别应用”对话框
      CallProtectionService().clearCachedStatus();
      final granted = await CallScreeningPlugin.requestCallScreeningRole();
      if (context.mounted) {
        ref.invalidate(homeStatsProvider);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(granted ? l10n.permissionGranted : l10n.callScreeningPermissionNotGranted),
            backgroundColor: granted ? Colors.green : Colors.orange,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final asyncStats = ref.watch(homeStatsProvider);
    final isProtectionActive = asyncStats.value?.isProtectionActive ?? false;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 品牌 Logo 与暖色多巴胺标题（使用 Expanded 防止小屏幕溢出）
          Expanded(
            child: Row(
              children: [
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    gradient: EliteDopamineTheme.heroWarmGradient,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: EliteDopamineTheme.warmSunAmber.withValues(alpha: 0.35),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.shield_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ShaderMask(
                        shaderCallback: (bounds) => EliteDopamineTheme.heroWarmGradient.createShader(bounds),
                        child: Text(
                          l10n.appName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -0.3,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      // 动态系统默认来电防护激活状态条
                      GestureDetector(
                        onTap: () => _handleStatusTap(context, ref, isProtectionActive),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              width: 6,
                              height: 6,
                              decoration: BoxDecoration(
                                color: isProtectionActive
                                    ? EliteDopamineTheme.freshMint
                                    : EliteDopamineTheme.warmSunAmber,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              isProtectionActive ? l10n.enabled : l10n.disabled,
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0.5,
                                color: isProtectionActive
                                    ? EliteDopamineTheme.freshMint
                                    : EliteDopamineTheme.sunsetTangerine,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),

          // 右侧：Pro 模式切换胶囊 + 设置按钮
          Row(
            children: [
              IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    color: EliteDopamineTheme.warmSunAmber.withValues(alpha: 0.14),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: EliteDopamineTheme.warmSunAmber.withValues(alpha: 0.35),
                      width: 1,
                    ),
                  ),
                  child: const Icon(
                    Icons.dashboard_customize_outlined,
                    size: 18,
                    color: EliteDopamineTheme.sunsetTangerine,
                  ),
                ),
                onPressed: () => _handleProSwitch(context),
                tooltip: l10n.phoneRuleManagement,
              ),
              const SizedBox(width: 4),
              IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.04),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.notifications_outlined,
                    size: 18,
                    color: Colors.black87,
                  ),
                ),
                onPressed: () => _handleNotificationsTap(context),
                tooltip: l10n.notifications,
              ),
              IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.04),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.settings_outlined,
                    size: 18,
                    color: Colors.black87,
                  ),
                ),
                onPressed: () => _handleSettingsTap(context),
                tooltip: l10n.settingsTab,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ------------------- Widget Previewer 支持 -------------------

@Preview(name: 'Elite App Bar', group: 'Elite Showcase')
Widget previewEliteAppBar() {
  return const ProviderScope(
    child: MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(
        backgroundColor: EliteDopamineTheme.warmCanvasBackground,
        body: SafeArea(
          child: EliteAppBar(),
        ),
      ),
    ),
  );
}
