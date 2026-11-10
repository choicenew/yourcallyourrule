import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yourcallyourrule/features/common/router/app_router.dart';
import 'package:yourcallyourrule/features/call/call_filter/presentation/widgets/enhanced_composite_filter_settings_widget.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 过滤器设置页面
class FilterSettingsPage extends ConsumerWidget {
  const FilterSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.filterSettingsTitle,
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 20,
            color: theme.colorScheme.onSurface,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        foregroundColor: theme.colorScheme.onSurface,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 20,
            color: theme.colorScheme.onSurface,
          ),
          onPressed: () {
            if (GoRouter.of(context).canPop()) {
              context.pop();
            } else {
              GoRouter.of(context).goNamed(AppRouter.home);
            }
          },
        ),
      ),
      body: const EnhancedCompositeFilterSettingsWidget(),
    );
  }
}
