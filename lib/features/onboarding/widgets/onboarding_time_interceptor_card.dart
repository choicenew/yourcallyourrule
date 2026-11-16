import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/features/phone_time_interception/provider/time_interceptor_provider.dart';
import 'package:yourcallyourrule/features/phone_time_interception/time_interceptor_config.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

// TODO: 待规划功能——重复呼叫紧急穿透规则 (Repeat Call Emergency Penetration)
// 依据 EmergencyNumberFloor 现有硬规则防护，后续可扩展同一号码短时间内连续拨打自动穿透防打扰机制。

/// 引导页 6：时间段拦截与防打扰卡片组件
class OnboardingTimeInterceptorCard extends ConsumerWidget {
  const OnboardingTimeInterceptorCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);

    final configAsync = ref.watch(timeInterceptorConfigProvider);
    final config = configAsync.value ?? const TimeInterceptorConfig();
    final notifier = ref.read(timeInterceptorConfigProvider.notifier);

    final isEnabled = config.shouldIntercept;
    final currentMinutes = config.duration.inMinutes;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 上层：时间拦截器倒计时与状态演示 Banner
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: isEnabled
                    ? theme.colorScheme.primary.withValues(alpha: 0.4)
                    : theme.colorScheme.outlineVariant,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: isEnabled
                            ? theme.colorScheme.primaryContainer
                            : theme.colorScheme.surfaceContainerHighest,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.timer_rounded,
                        color: isEnabled
                            ? theme.colorScheme.primary
                            : theme.colorScheme.onSurfaceVariant,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.timeInterceptor,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            isEnabled
                                ? '${l10n.timeInterceptorDescription} ($currentMinutes min)'
                                : l10n.timeInterceptorDescription,
                            style: TextStyle(fontSize: 12, color: theme.colorScheme.onSurfaceVariant),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    Switch(
                      value: isEnabled,
                      onChanged: (val) {
                        notifier.updateShouldIntercept(val);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Text(
            l10n.timeInterceptor,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            l10n.timeInterceptorDescription,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              color: theme.colorScheme.onSurfaceVariant,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 16),

          // 下层：时长选择直接交互（支持预设与自定义分钟数）
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: theme.colorScheme.outlineVariant),
            ),
            child: Wrap(
              alignment: WrapAlignment.center,
              spacing: 8,
              runSpacing: 8,
              children: [
                ...[15, 30, 60, 120].map((mins) {
                  final selected = currentMinutes == mins;
                  return ChoiceChip(
                    label: Text('${mins}m'),
                    selected: selected,
                    onSelected: isEnabled
                        ? (_) {
                            notifier.updateDuration(mins);
                          }
                        : null,
                  );
                }),
                ChoiceChip(
                  avatar: const Icon(Icons.tune_rounded, size: 14),
                  label: Text(
                    ![15, 30, 60, 120].contains(currentMinutes)
                        ? '${currentMinutes}m'
                        : l10n.custom,
                  ),
                  selected: ![15, 30, 60, 120].contains(currentMinutes),
                  onSelected: isEnabled
                      ? (_) {
                          _showCustomMinutesDialog(
                            context,
                            currentMinutes,
                            notifier,
                            l10n,
                          );
                        }
                      : null,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showCustomMinutesDialog(
    BuildContext context,
    int initialMinutes,
    TimeInterceptorConfigNotifier notifier,
    AppLocalizations l10n,
  ) async {
    final controller = TextEditingController(text: initialMinutes.toString());
    final result = await showDialog<int>(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text(l10n.custom),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: controller,
                keyboardType: TextInputType.number,
                autofocus: true,
                decoration: InputDecoration(
                  labelText: l10n.minutes,
                  suffixText: 'm',
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                children: [45, 90, 180, 360].map((preset) {
                  return ActionChip(
                    label: Text('${preset}m'),
                    onPressed: () {
                      controller.text = preset.toString();
                    },
                  );
                }).toList(),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: Text(l10n.cancel),
            ),
            FilledButton(
              onPressed: () {
                final parsed = int.tryParse(controller.text.trim());
                if (parsed != null && parsed > 0 && parsed <= 1440) {
                  Navigator.of(ctx).pop(parsed);
                }
              },
              child: Text(l10n.confirm),
            ),
          ],
        );
      },
    );

    if (result != null) {
      notifier.updateDuration(result);
    }
  }
}
