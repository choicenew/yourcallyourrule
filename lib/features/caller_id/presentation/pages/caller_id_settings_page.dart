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
      backgroundColor: const Color(0xFFFFFBF5),
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.callerIdSettingsTitle,
          style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 20, color: Colors.black87),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        foregroundColor: Colors.black87,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20, color: Colors.black87),
          onPressed: () => context.pop(),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        children: const [
          CallerIdDisplayModeSelector(),
          SizedBox(height: 14),
          GoogleAdWidget(adInfo: AdManager.bannerAd),
          SizedBox(height: 14),
          NotificationSettingsWidget(),
          SizedBox(height: 14),
          GoogleAdWidget(adInfo: AdManager.bannerAd),
          SizedBox(height: 14),
          OverlayPermissionWidget(),
          SizedBox(height: 14),
          nativeAdWidgetMedium(adWidth: 320, adHeight: 320),
        ],
      ),
    );
  }
}