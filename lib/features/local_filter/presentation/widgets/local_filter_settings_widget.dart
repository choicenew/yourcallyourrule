import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_ads_hub/pyro_ads_hub.dart';
import 'package:yourcallyourrule/features/local_filter/provider/local_count_filter_provider.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

class LocalFilterSettingsWidget extends ConsumerWidget {
  const LocalFilterSettingsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final configAsync = ref.watch(localCountFilterConfigProvider);
    final config = configAsync.value ?? LocalCountFilterConfig();
    final notifier = ref.read(localCountFilterConfigProvider.notifier);
    final l10n = AppLocalizations.of(context);

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Theme.of(context).colorScheme.outlineVariant,
              width: 1.1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            children: [
              SwitchListTile(
                title: Text(l10n.enableLocalCountFilter, style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15, color: Theme.of(context).colorScheme.onSurface)),
                subtitle: Text(l10n.enableLocalCountFilterDescription, style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onSurfaceVariant)),
                activeThumbColor: Theme.of(context).colorScheme.primary,
                value: config.enableLocalCountFilter,
                onChanged: (value) => notifier.updateConfig(config.copyWith(enableLocalCountFilter: value)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Theme.of(context).colorScheme.outlineVariant,
              width: 1.1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.countThresholdLabel,
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14.5, color: Theme.of(context).colorScheme.onSurface),
                ),
                const SizedBox(height: 4),
                Text(
                  l10n.countThresholdDescription,
                  style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onSurfaceVariant),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: Slider(
                        value: config.countThreshold.toDouble(),
                        min: 1,
                        max: 100,
                        divisions: 99,
                        label: config.countThreshold.toString(),
                        activeColor: Theme.of(context).colorScheme.primary,
                        onChanged: (value) {
                          notifier.updateConfig(config.copyWith(countThreshold: value.toInt()));
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '${config.countThreshold}',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 14),
        const AdsInlineBanner(),
        const SizedBox(height: 14),
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Theme.of(context).colorScheme.outlineVariant,
              width: 1.1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            children: [
              SwitchListTile(
                title: Text(l10n.rejectExceededNumbers, style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14.5, color: Theme.of(context).colorScheme.onSurface)),
                subtitle: Text(l10n.rejectExceededNumbersDescription, style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onSurfaceVariant)),
                activeThumbColor: Theme.of(context).colorScheme.primary,
                value: config.rejectExceededNumbers,
                onChanged: (value) => notifier.updateConfig(config.copyWith(rejectExceededNumbers: value)),
              ),
              Divider(height: 1, indent: 16, endIndent: 16, color: Theme.of(context).colorScheme.outlineVariant),
              SwitchListTile(
                title: Text(l10n.allowNonExceededNumbers, style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14.5, color: Theme.of(context).colorScheme.onSurface)),
                subtitle: Text(l10n.allowNonExceededNumbersDescription, style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onSurfaceVariant)),
                activeThumbColor: Theme.of(context).colorScheme.primary,
                value: config.allowNonExceededNumbers,
                onChanged: (value) => notifier.updateConfig(config.copyWith(allowNonExceededNumbers: value)),
              ),
              Divider(height: 1, indent: 16, endIndent: 16, color: Theme.of(context).colorScheme.outlineVariant),
              SwitchListTile(
                title: Text(l10n.logAllLocalQueries, style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14.5, color: Theme.of(context).colorScheme.onSurface)),
                subtitle: Text(l10n.logAllLocalQueriesDescription, style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onSurfaceVariant)),
                activeThumbColor: Theme.of(context).colorScheme.primary,
                value: config.logAllLocalQueries,
                onChanged: (value) => notifier.updateConfig(config.copyWith(logAllLocalQueries: value)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        const AdsInlineBanner(),
        const SizedBox(height: 14),
        _buildExplanationCard(context),
      ],
    );
  }

  Widget _buildExplanationCard(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info_outline, size: 18, color: Theme.of(context).colorScheme.primary),
              const SizedBox(width: 8),
              Text(
                l10n.localCountFilterExplanationTitle,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Theme.of(context).colorScheme.primary),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            l10n.localCountFilterExplanationContent,
            style: TextStyle(fontSize: 11.5, color: Theme.of(context).colorScheme.onSurfaceVariant, height: 1.4),
          ),
        ],
      ),
    );
  }
}
