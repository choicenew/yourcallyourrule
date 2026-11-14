import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/features/time_interceptor/provider/time_interceptor_provider.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

class TimeInterceptorSettingsWidget extends ConsumerWidget {
  const TimeInterceptorSettingsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(timeInterceptorConfigProvider.select((asyncValue) => asyncValue.value));
    
    if (config == null) {
      final configAsync = ref.watch(timeInterceptorConfigProvider);
      if (configAsync.hasError) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('Error: ${configAsync.error}'),
          ),
        );
      }
      return const Center(child: CircularProgressIndicator());
    }

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
