import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/features/call_time_interception/provider/time_interceptor_provider.dart';
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            AppLocalizations.of(context).timeWindowLabel(durationMinutes), 
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        const SizedBox(height: 8),
        Slider(
          value: durationMinutes.toDouble(),
          min: 5,
          max: 120,
          divisions: 23,
          label: durationMinutes.toString(),
          onChanged: (value) {
            onChanged(value.round());
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(AppLocalizations.of(context).timeWindowDescription),
        ),
      ],
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
