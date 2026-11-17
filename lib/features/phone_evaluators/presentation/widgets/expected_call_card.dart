import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_tile_hub/pyro_tile_hub.dart';
import 'package:yourcallyourrule/features/phone_evaluators/evaluators/expected_call_service.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// “期待电话”临时放行与 Quick Settings Tile 联动卡片
class ExpectedCallCard extends ConsumerWidget {
  const ExpectedCallCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expectedService = ref.watch(expectedCallServiceProvider);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context);
    final isActive = expectedService.isActive;
    final remaining = expectedService.remainingDuration;

    final minutes = remaining.inMinutes;
    final seconds = remaining.inSeconds % 60;
    final timeStr = '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';

    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: isActive ? colorScheme.primary : colorScheme.outlineVariant.withValues(alpha: 0.5),
          width: isActive ? 1.5 : 1.0,
        ),
      ),
      color: isActive ? colorScheme.primaryContainer.withValues(alpha: 0.25) : colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  isActive ? Icons.phone_in_talk_rounded : Icons.schedule_rounded,
                  color: isActive ? colorScheme.primary : colorScheme.onSurfaceVariant,
                  size: 24,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.expectedCallTitle,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        isActive
                            ? l10n.expectedCallActiveDesc(timeStr)
                            : l10n.expectedCallInactiveDesc,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: isActive ? colorScheme.primary : colorScheme.onSurfaceVariant,
                          fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
                Switch.adaptive(
                  value: isActive,
                  activeTrackColor: colorScheme.primary,
                  onChanged: (val) {
                    if (val) {
                      expectedService.enable(const Duration(hours: 1));
                    } else {
                      expectedService.disable();
                    }
                  },
                ),
              ],
            ),
            if (isActive) ...[
              const SizedBox(height: 12),
              Row(
                children: [
                  _buildDurationChip(context, expectedService, l10n.duration15Min, const Duration(minutes: 15)),
                  const SizedBox(width: 8),
                  _buildDurationChip(context, expectedService, l10n.duration30Min, const Duration(minutes: 30)),
                  const SizedBox(width: 8),
                  _buildDurationChip(context, expectedService, l10n.duration1Hour, const Duration(hours: 1)),
                  const SizedBox(width: 8),
                  _buildDurationChip(context, expectedService, l10n.duration2Hours, const Duration(hours: 2)),
                ],
              ),
            ],
            const SizedBox(height: 10),
            InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () async {
                final ok = await TileHub.instance.requestAddTile();
                if (context.mounted) {
                  if (ok) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(l10n.expectedCallAddTile),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  } else {
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: Text(l10n.expectedCallAddTile),
                        content: Text(
                          l10n.expectedCallAddTile,
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(ctx).pop(),
                            child: Text(l10n.confirm),
                          ),
                        ],
                      ),
                    );
                  }
                }
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  children: [
                    Icon(Icons.dashboard_customize_rounded, size: 16, color: colorScheme.secondary),
                    const SizedBox(width: 6),
                    Text(
                      l10n.expectedCallAddTile,
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: colorScheme.secondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    Icon(Icons.arrow_forward_ios_rounded, size: 12, color: colorScheme.secondary),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDurationChip(
    BuildContext context,
    ExpectedCallService service,
    String label,
    Duration duration,
  ) {
    final theme = Theme.of(context);
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () => service.enable(duration),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          label,
          style: theme.textTheme.labelSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

