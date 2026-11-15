import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/features/time_interceptor/provider/time_interceptor_provider.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

class TimeInterceptorSettingsWidget extends ConsumerWidget {
  const TimeInterceptorSettingsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final configAsync = ref.watch(timeInterceptorConfigProvider);
    final config = configAsync.value ?? const TimeInterceptorConfig();
    final notifier = ref.read(timeInterceptorConfigProvider.notifier);

    return Column(
      children: [
        SwitchListTile(
          title: Text(AppLocalizations.of(context).enableTimeInterceptor),
          subtitle: Text(AppLocalizations.of(context).timeInterceptorDescription),
          value: config.shouldIntercept,
          onChanged: (isEnabled) {
            notifier.updateShouldIntercept(isEnabled);
          },
        ),
      ],
    );
  }
}
