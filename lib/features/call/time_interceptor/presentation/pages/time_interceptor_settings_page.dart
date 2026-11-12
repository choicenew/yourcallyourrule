import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/features/call/time_interceptor/presentation/widgets/time_interceptor_settings_widget.dart';
import 'package:yourcallyourrule/features/call/time_interceptor/provider/time_interceptor_provider.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

class TimeInterceptorSettingsPage extends ConsumerWidget {
  const TimeInterceptorSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncConfig = ref.watch(timeInterceptorConfigProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.timeInterceptorSettingsTitle),
        actions: [
          if (asyncConfig.isLoading)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
        ],
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: TimeInterceptorSettingsWidget(),
      ),
    );
  }
}
