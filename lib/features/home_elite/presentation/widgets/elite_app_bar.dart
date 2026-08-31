// -----------------------------------------------------------------------------
// 文件: elite_app_bar.dart
// 描述: Elite 顶部应用栏，包含品牌动态标识、双向模式切换胶囊与设置入口。
// -----------------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:go_router/go_router.dart';
import 'package:yourcallyourrule/core/router/app_router.dart';
import 'package:yourcallyourrule/features/home_elite/theme/elite_dopamine_theme.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

// ------------------- Widget 定义 -------------------

class EliteAppBar extends StatelessWidget {
  final VoidCallback? onSwitchToPro;

  const EliteAppBar({
    super.key,
    this.onSwitchToPro,
  });

  void _handleSettingsTap(BuildContext context) {
    context.pushNamed(AppRouter.settings);
  }

  void _handleProSwitch(BuildContext context) {
    if (onSwitchToPro != null) {
      onSwitchToPro!();
    } else {
      context.goNamed(AppRouter.proHome);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

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
                      Row(
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            decoration: const BoxDecoration(
                              color: EliteDopamineTheme.freshMint,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            l10n.enabled,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.5,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
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
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => _handleProSwitch(context),
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: EliteDopamineTheme.warmSunAmber.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: EliteDopamineTheme.warmSunAmber.withValues(alpha: 0.3),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.dashboard_customize_outlined,
                          size: 14,
                          color: EliteDopamineTheme.sunsetTangerine,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          l10n.phoneRuleManagement,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                            color: EliteDopamineTheme.sunsetTangerine,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 6),
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
  return const MaterialApp(
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    home: Scaffold(
      backgroundColor: EliteDopamineTheme.warmCanvasBackground,
      body: SafeArea(
        child: EliteAppBar(),
      ),
    ),
  );
}
