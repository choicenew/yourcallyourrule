import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/features/call_time_interception/provider/time_interceptor_provider.dart';
import 'package:yourcallyourrule/features/call_time_interception/time_interceptor_config.dart';
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

          // 下层：时长选择直接交互
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: theme.colorScheme.outlineVariant),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [15, 30, 60, 120].map((mins) {
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
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
