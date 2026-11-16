import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yourcallyourrule/features/common/router/app_router.dart';
import 'package:yourcallyourrule/features/call_time_interception/presentation/widgets/time_interceptor_settings_widget.dart';
import 'package:yourcallyourrule/features/call_time_interception/provider/time_interceptor_provider.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

class TimeInterceptorSettingsPage extends ConsumerWidget {
  const TimeInterceptorSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncConfig = ref.watch(timeInterceptorConfigProvider);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        if (GoRouter.of(context).canPop()) {
          context.pop();
        } else {
          GoRouter.of(context).goNamed(AppRouter.home);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context).timeInterceptorSettingsTitle),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
            onPressed: () {
              if (GoRouter.of(context).canPop()) {
                context.pop();
              } else {
                GoRouter.of(context).goNamed(AppRouter.home);
              }
            },
          ),
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
      ),
    );
  }
}
