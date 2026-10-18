import 'package:flutter/material.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

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
    final theme = Theme.of(context);

    final isEnabled = selectedCount > 0 && !isDownloading;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
        child: Row(
          children: [
            TextButton(
              onPressed: isDownloading ? null : onSkip,
              child: Text(
                l10n.initialSetupSkip,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
                ),
              ),
            ),
            const Spacer(),
            Container(
              decoration: BoxDecoration(
                gradient: isEnabled
                    ? LinearGradient(
                        colors: [
                          theme.colorScheme.primary,
                          theme.colorScheme.primary.withValues(alpha: 0.85),
                        ],
                      )
                    : null,
                color: isEnabled
                    ? null
                    : theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.8),
                borderRadius: BorderRadius.circular(16),
                boxShadow: isEnabled
                    ? [
                        BoxShadow(
                          color: theme.colorScheme.primary.withValues(alpha: 0.3),
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
                  foregroundColor: isEnabled
                      ? Colors.white
                      : theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: isEnabled ? onDownloadSelected : null,
                icon: isDownloading
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                      )
                    : Icon(
                        Icons.download_rounded,
                        size: 18,
                        color: isEnabled
                            ? Colors.white
                            : theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
                      ),
                label: Text(
                  isDownloading
                      ? l10n.initialSetupSaving
                      : l10n.initialSetupSelectedCount(selectedCount),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13.5,
                    color: isEnabled
                        ? Colors.white
                        : theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
