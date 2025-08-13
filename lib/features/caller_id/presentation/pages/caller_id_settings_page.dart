import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yourcallyourrule/ads/ad_manager.dart';
import 'package:yourcallyourrule/ads/adwidgets/native_ads.dart';
import 'package:yourcallyourrule/ads/google_ad.dart';
import 'package:yourcallyourrule/features/caller_id/presentation/widgets/caller_id_display_mode_selector.dart';
import 'package:yourcallyourrule/features/caller_id/presentation/widgets/notification_settings_widget.dart';

import 'package:yourcallyourrule/features/permissions/widgets/overlay_permission_widget.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 来电显示设置页面
/// 整合来电显示相关的所有设置
class CallerIdSettingsPage extends ConsumerWidget {
  const CallerIdSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.callerIdSettingsTitle),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            CallerIdDisplayModeSelector(),
            SizedBox(height: 16),
              GoogleAdWidget(adInfo: AdManager.bannerAd),
            NotificationSettingsWidget(),
            SizedBox(height: 16),
              GoogleAdWidget(adInfo: AdManager.bannerAd),
            OverlayPermissionWidget(),
             SizedBox(height: 16),
             nativeAdWidgetMedium(adWidth: 320, adHeight: 320)
          ],
        ),
      ),
    );
  }
}