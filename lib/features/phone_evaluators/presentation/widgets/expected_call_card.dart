import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_tile_hub/pyro_tile_hub.dart';
import 'package:yourcallyourrule/features/phone_evaluators/evaluators/expected_call_service.dart';

/// “期待电话”临时放行与 Quick Settings Tile 联动卡片
class ExpectedCallCard extends ConsumerWidget {
  const ExpectedCallCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expectedService = ref.watch(expectedCallServiceProvider);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
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
                        '期待电话 · 临时放行',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        isActive
                            ? '正在临时放行所有未知来电 (剩余 $timeStr)'
                            : '等外卖/快递时临时豁免拦截规则',
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
                  activeColor: colorScheme.primary,
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
                  _buildDurationChip(context, expectedService, '15分钟', const Duration(minutes: 15)),
                  const SizedBox(width: 8),
                  _buildDurationChip(context, expectedService, '30分钟', const Duration(minutes: 30)),
                  const SizedBox(width: 8),
                  _buildDurationChip(context, expectedService, '1小时', const Duration(hours: 1)),
                  const SizedBox(width: 8),
                  _buildDurationChip(context, expectedService, '2小时', const Duration(hours: 2)),
                ],
              ),
            ],
            const SizedBox(height: 10),
            InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () async {
                final ok = await TileHub.instance.requestAddTile();
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(ok ? '已发送添加至系统下拉通知栏请求' : '系统不支持或已添加下拉快捷开关'),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                }
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  children: [
                    Icon(Icons.dashboard_customize_rounded, size: 16, color: colorScheme.secondary),
                    const SizedBox(width: 6),
                    Text(
                      '添加“期待电话”至系统下拉控制中心 (Quick Settings Tile)',
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

