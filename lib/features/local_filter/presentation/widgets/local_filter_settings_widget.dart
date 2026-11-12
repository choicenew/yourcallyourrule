import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_ads_hub/pyro_ads_hub.dart';
import 'package:yourcallyourrule/features/local_filter/provider/local_count_filter_provider.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

class LocalFilterSettingsWidget extends ConsumerWidget {
  const LocalFilterSettingsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(localCountFilterConfigProvider.select((asyncValue) => asyncValue.value));
    
    if (config == null) {
      return const Center(child: CircularProgressIndicator());
    }
    
    final notifier = ref.read(localCountFilterConfigProvider.notifier);
    final l10nDynamic = AppLocalizations.of(context) as dynamic;

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
                title: Text(AppLocalizations.of(context)!.enableLocalCountFilter, style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15, color: Theme.of(context).colorScheme.onSurface)),
                subtitle: Text(AppLocalizations.of(context)!.enableLocalCountFilterDescription, style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onSurfaceVariant)),
                activeColor: Theme.of(context).colorScheme.primary,
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
                  l10nDynamic.localCountThreshold as String? ?? 'Local Count Threshold',
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14.5, color: Theme.of(context).colorScheme.onSurface),
                ),
                const SizedBox(height: 4),
                Text(
                  l10nDynamic.localCountThresholdDescription as String? ?? 'Local Count Threshold Description',
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
                title: Text(AppLocalizations.of(context)!.rejectExceededNumbers, style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14.5, color: Theme.of(context).colorScheme.onSurface)),
                subtitle: Text(AppLocalizations.of(context)!.rejectExceededNumbersDescription, style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onSurfaceVariant)),
                activeColor: Theme.of(context).colorScheme.primary,
                value: config.rejectExceededNumbers,
                onChanged: (value) => notifier.updateConfig(config.copyWith(rejectExceededNumbers: value)),
              ),
              Divider(height: 1, indent: 16, endIndent: 16, color: Theme.of(context).colorScheme.outlineVariant),
              SwitchListTile(
                title: Text(AppLocalizations.of(context)!.allowNonExceededNumbers, style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14.5, color: Theme.of(context).colorScheme.onSurface)),
                subtitle: Text(AppLocalizations.of(context)!.allowNonExceededNumbersDescription, style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onSurfaceVariant)),
                activeColor: Theme.of(context).colorScheme.primary,
                value: config.allowNonExceededNumbers,
                onChanged: (value) => notifier.updateConfig(config.copyWith(allowNonExceededNumbers: value)),
              ),
              Divider(height: 1, indent: 16, endIndent: 16, color: Theme.of(context).colorScheme.outlineVariant),
              SwitchListTile(
                title: Text(AppLocalizations.of(context)!.logAllLocalQueries, style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14.5, color: Theme.of(context).colorScheme.onSurface)),
                subtitle: Text(AppLocalizations.of(context)!.logAllLocalQueriesDescription, style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onSurfaceVariant)),
                activeColor: Theme.of(context).colorScheme.primary,
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
    final l10nDynamic = AppLocalizations.of(context) as dynamic;
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
                l10nDynamic.aboutLocalCountFilter as String? ?? 'About Local Count Filter',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Theme.of(context).colorScheme.primary),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            l10nDynamic.localCountFilterExplanation as String? ?? 'Local Count Filter Explanation',
            style: TextStyle(fontSize: 11.5, color: Theme.of(context).colorScheme.onSurfaceVariant, height: 1.4),
          ),
        ],
      ),
    );
  }
}
