import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pyro_ads_hub/pyro_ads_hub.dart';
import 'package:yourcallyourrule/features/call_coordinator/presentation/display_mode_selector.dart';
import 'package:yourcallyourrule/features/permissions/widgets/overlay_permission_widget.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 来电显示设置页面
class CallerIdentitySettingsPage extends ConsumerWidget {
  const CallerIdentitySettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).callerIdSettingsTitle,
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20, color: theme.colorScheme.onSurface),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        foregroundColor: theme.colorScheme.onSurface,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, size: 20, color: theme.colorScheme.onSurface),
          onPressed: () => context.pop(),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        children: const [
          CallerIdDisplayModeSelector(),
          SizedBox(height: 14),
          AdsInlineBanner(),
          SizedBox(height: 14),
          OverlayPermissionWidget(),
          SizedBox(height: 14),
          AdsInlineBanner(),
        ],
      ),
    );
  }
}
