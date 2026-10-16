import 'package:flutter/material.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';
import 'package:yourcallyourrule/features/home_elite/theme/elite_dopamine_theme.dart';

/// 底部晶莹悬浮 Action 控制面板组件：包含跳过按钮与根据选中状态变色的多巴胺渐变主按钮
class InitialSetupBottomBar extends StatelessWidget {
  final int selectedCount;
  final bool isDownloading;
  final VoidCallback onSkip;
  final VoidCallback onDownloadSelected;

  const InitialSetupBottomBar({
    super.key,
    required this.selectedCount,
    required this.isDownloading,
    required this.onSkip,
    required this.onDownloadSelected,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
        child: Row(
          children: [
            TextButton(
              onPressed: isDownloading ? null : onSkip,
              child: Text(l10n.initialSetupSkip, style: const TextStyle(color: EliteDopamineTheme.textMuted)),
            ),
            const Spacer(),
            Container(
              decoration: BoxDecoration(
                gradient: selectedCount > 0 ? EliteDopamineTheme.heroWarmGradient : null,
                color: selectedCount == 0 ? EliteDopamineTheme.slateSubtle : null,
                borderRadius: BorderRadius.circular(16),
                boxShadow: selectedCount > 0
                    ? [
                        BoxShadow(
                          color: EliteDopamineTheme.sunsetTangerine.withValues(alpha: 0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ]
                    : null,
              ),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
                onPressed: (selectedCount == 0 || isDownloading) ? null : onDownloadSelected,
                icon: isDownloading
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                      )
                    : const Icon(Icons.download_rounded, size: 18),
                label: Text(
                  isDownloading ? l10n.initialSetupSaving : l10n.initialSetupSelectedCount(selectedCount),
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
