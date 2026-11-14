import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/features/call_filter/providers/call_filter_provider.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 过滤器面板控制组件 (归位至 call_filter/presentation/widgets/filter_control_widget.dart)
class FilterControlWidget extends ConsumerStatefulWidget {
  const FilterControlWidget({super.key});

  @override
  ConsumerState<FilterControlWidget> createState() => _FilterControlWidgetState();
}

class _FilterControlWidgetState extends ConsumerState<FilterControlWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final callConfigAsync = ref.watch(callFilterConfigProvider);

    return callConfigAsync.when(
      data: (config) {
        final notifier = ref.read(callFilterConfigProvider.notifier);
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context).filterControlPanelTitle,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 16),
              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(color: theme.colorScheme.outlineVariant, width: 1.0),
                ),
                child: Column(
                  children: [
                    SwitchListTile(
                      title: Text(AppLocalizations.of(context).rejectAllCalls),
                      subtitle: Text(AppLocalizations.of(context).rejectAllCallsDescription),
                      value: config.rejectAllNumbers,
                      onChanged: (value) => notifier.updateConfig(config.copyWith(rejectAllNumbers: value)),
                    ),
                    SwitchListTile(
                      title: Text(AppLocalizations.of(context).allowAllowedNumbers),
                      subtitle: Text(AppLocalizations.of(context).allowAllowedNumbersDesc),
                      value: config.allowAllAllowedNumbers,
                      onChanged: (value) => notifier.updateConfig(config.copyWith(allowAllAllowedNumbers: value)),
                    ),
                    SwitchListTile(
                      title: Text(AppLocalizations.of(context).allowRegexAllowRules),
                      subtitle: Text(AppLocalizations.of(context).allowRegexAllowRulesDescription),
                      value: config.allowRegexAllowRules,
                      onChanged: (value) => notifier.updateConfig(config.copyWith(allowRegexAllowRules: value)),
                    ),
                    SwitchListTile(
                      title: Text(AppLocalizations.of(context).allowBlockedNumbers),
                      subtitle: Text(AppLocalizations.of(context).allowBlockedNumbersDesc),
                      value: config.allowBlockedNumbers,
                      onChanged: (value) => notifier.updateConfig(config.copyWith(allowBlockedNumbers: value)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, st) => Center(child: Text('Error: $err')),
    );
  }
}
