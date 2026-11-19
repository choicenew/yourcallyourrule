import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/features/phone_time_interception/provider/time_interceptor_provider.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

class TimeInterceptorSettingsWidget extends ConsumerWidget {
  const TimeInterceptorSettingsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(timeInterceptorConfigProvider.select((asyncValue) => asyncValue.value));
    
    if (config == null) {
      final configAsync = ref.watch(timeInterceptorConfigProvider);
      if (configAsync.hasError) {
        return Center(child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text('Error: ${configAsync.error}'),
        ));
      }
      return const Center(child: CircularProgressIndicator());
    }

    final notifier = ref.read(timeInterceptorConfigProvider.notifier);

    return Column(
      children: [
        _buildEnableSwitch(context, config.shouldIntercept, (value) {
          notifier.updateShouldIntercept(value);
        }),
        const Divider(),
        Opacity(
          opacity: config.shouldIntercept ? 1.0 : 0.5,
          child: IgnorePointer(
            ignoring: !config.shouldIntercept,
            child: _buildDurationSetting(context, config.duration.inMinutes, (value) {
              notifier.updateDuration(value);
            }),
          ),
        ),
        const SizedBox(height: 32),
        _buildExplanationCard(context),
      ],
    );
  }

  Widget _buildEnableSwitch(BuildContext context, bool isEnabled, ValueChanged<bool> onChanged) {
    return SwitchListTile(
      title: Text(AppLocalizations.of(context).enableTimeInterceptor),
      subtitle: Text(AppLocalizations.of(context).timeInterceptorDescription),
      value: isEnabled,
      onChanged: onChanged,
    );
  }

  Widget _buildDurationSetting(BuildContext context, int durationMinutes, ValueChanged<int> onChanged) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l10n.timeWindowLabel(durationMinutes),
                style: theme.textTheme.titleMedium,
              ),
              TextButton.icon(
                icon: const Icon(Icons.edit_calendar_rounded, size: 18),
                label: Text('$durationMinutes min (${l10n.custom})'),
                onPressed: () => _showCustomDurationDialog(context, durationMinutes, onChanged),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Slider(
          value: durationMinutes.toDouble().clamp(1.0, 180.0),
          min: 1,
          max: 180,
          divisions: 179,
          label: '$durationMinutes min',
          onChanged: (value) {
            onChanged(value.round());
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Wrap(
            spacing: 8,
            children: [5, 15, 30, 60, 120].map((mins) {
              final isSelected = durationMinutes == mins;
              return ChoiceChip(
                label: Text('$mins min'),
                selected: isSelected,
                onSelected: (_) => onChanged(mins),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(l10n.timeWindowDescription),
        ),
      ],
    );
  }

  void _showCustomDurationDialog(BuildContext context, int currentMinutes, ValueChanged<int> onChanged) {
    final controller = TextEditingController(text: currentMinutes.toString());
    final l10n = AppLocalizations.of(context);

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.custom),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: l10n.timeWindowLabel(currentMinutes),
            suffixText: 'min',
            border: const OutlineInputBorder(),
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(l10n.cancel),
          ),
          ElevatedButton(
            onPressed: () {
              final val = int.tryParse(controller.text.trim());
              if (val != null && val > 0) {
                onChanged(val);
                Navigator.pop(ctx);
              }
            },
            child: Text(l10n.confirm),
          ),
        ],
      ),
    );
  }

  Widget _buildExplanationCard(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppLocalizations.of(context).timeInterceptorExplanationTitle, 
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 8),
            Text(AppLocalizations.of(context).timeInterceptorExplanationContent),
            const SizedBox(height: 8),
            Text(AppLocalizations.of(context).howItWorksTitle),
            Text("• ${AppLocalizations.of(context).howItWorksPoint1}"),
            Text("• ${AppLocalizations.of(context).howItWorksPoint2}"),
            Text("• ${AppLocalizations.of(context).howItWorksPoint3}"),
            const SizedBox(height: 8),
            Text(AppLocalizations.of(context).useCasesTitle),
            Text("• ${AppLocalizations.of(context).useCasesPoint1}"),
            Text("• ${AppLocalizations.of(context).useCasesPoint2}"),
            Text("• ${AppLocalizations.of(context).useCasesPoint3}"),
            const SizedBox(height: 8),
            Text(AppLocalizations.of(context).differentFromLocalCounter),
          ],
        ),
      ),
    );
  }
}
