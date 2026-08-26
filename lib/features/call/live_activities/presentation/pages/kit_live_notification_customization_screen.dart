// lib/features/call/live_activities/presentation/pages/kit_live_notification_customization_screen.dart
/// [New Version / 现代版本] 针对 live_activity_kit 灵动岛与 Android 实时通知的专属独立自定义与测试控制台
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/ads/ad_manager.dart';
import 'package:yourcallyourrule/ads/adwidgets/inline_adaptive_ad.dart';
import 'package:yourcallyourrule/common/utils/avatar_utils.dart';
import 'package:yourcallyourrule/features/call/caller_id/mock_data/caller_id_mock.dart';
import 'package:yourcallyourrule/features/call/live_activities/live_activity_config/live_notification_config.dart';
import 'package:yourcallyourrule/features/call/live_activities/providers/live_notification_config_provider.dart';
import 'package:yourcallyourrule/features/caller_id/services/call_handlers/kit_live_activity_handler.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

class KitLiveNotificationCustomizationScreen extends ConsumerStatefulWidget {
  const KitLiveNotificationCustomizationScreen({super.key});

  @override
  ConsumerState<KitLiveNotificationCustomizationScreen> createState() =>
      _KitLiveNotificationCustomizationScreenState();
}

class _KitLiveNotificationCustomizationScreenState
    extends ConsumerState<KitLiveNotificationCustomizationScreen> {
  bool _isActivityActive = false;

  Future<void> _sendLiveActivity() async {
    try {
      final handler = await ref.read(kitLiveActivityHandlerProvider.future);
      final mockData = CallerIdMockData.mockCallerIdData();
      final mockSimInfo = CallerIdMockData.mockSimInfoData();
      final mockStirInfo = CallerIdMockData.mockStirInfoData();

      await handler.showCallerIdActivity(
        callerIdData: mockData,
        simInfo: mockSimInfo,
        stirInfo: mockStirInfo,
      );

      setState(() {
        _isActivityActive = true;
      });
    } catch (e) {
      debugPrint('Error sending live activity: $e');
    }
  }

  Future<void> _endLiveActivity() async {
    try {
      final handler = await ref.read(kitLiveActivityHandlerProvider.future);
      await handler.endActivity();
      setState(() {
        _isActivityActive = false;
      });
    } catch (e) {
      debugPrint('Error ending live activity: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final asyncConfig = ref.watch(liveNotificationConfigProvider);
    final notifier = ref.read(liveNotificationConfigProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).liveNotificationCustomizationTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: AppLocalizations.of(context).reset,
            onPressed: () => notifier.resetToDefaults(),
          ),
          IconButton(
            icon: const Icon(Icons.save),
            tooltip: AppLocalizations.of(context).save,
            onPressed: () async {
              await notifier.saveConfig();
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(AppLocalizations.of(context).configSaved)),
                );
              }
            },
          ),
        ],
      ),
      body: asyncConfig.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
        data: (config) {
          return ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              // 1. 实时通知 / Live Activity 效果实时预览卡片
              _buildLivePreviewCard(config),
              const SizedBox(height: 20),

              // 2. 测试控制按钮栏
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.send),
                      label: Text(
                        !_isActivityActive
                            ? AppLocalizations.of(context).liveActivitiesTestSendNewActivity
                            : AppLocalizations.of(context).liveActivitiesTestUpdateActivity,
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: _sendLiveActivity,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.cancel),
                      label: Text(AppLocalizations.of(context).liveActivitiesTestEndActivity),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        foregroundColor: Colors.red,
                        side: const BorderSide(color: Colors.red),
                      ),
                      onPressed: !_isActivityActive ? null : _endLiveActivity,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                AppLocalizations.of(context).notification_instructions,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelMedium,
              ),
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 10),

              // 3. 自定义开关配置面板（100% 国际化）
              Text(
                AppLocalizations.of(context).elementsSettingsTitle,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              SwitchListTile(
                title: Text(AppLocalizations.of(context).avatar),
                value: config.avatar.visible,
                onChanged: (val) => notifier.updateElementVisibility('avatar', val),
              ),

              SwitchListTile(
                title: Text(AppLocalizations.of(context).name),
                value: config.name.visible,
                onChanged: (val) => notifier.updateElementVisibility('name', val),
              ),

              SwitchListTile(
                title: Text(AppLocalizations.of(context).phoneNumber),
                value: config.number.visible,
                onChanged: (val) => notifier.updateElementVisibility('number', val),
              ),

              SwitchListTile(
                title: Text(AppLocalizations.of(context).location),
                value: config.location.visible,
                onChanged: (val) => notifier.updateElementVisibility('location', val),
              ),

              SwitchListTile(
                title: Text(AppLocalizations.of(context).carrier),
                value: config.carrier.visible,
                onChanged: (val) => notifier.updateElementVisibility('carrier', val),
              ),

              SwitchListTile(
                title: Text(AppLocalizations.of(context).country),
                value: config.countryName.visible,
                onChanged: (val) => notifier.updateElementVisibility('countryName', val),
              ),

              SwitchListTile(
                title: Text(AppLocalizations.of(context).labels),
                value: config.labels.visible,
                onChanged: (val) => notifier.updateElementVisibility('labels', val),
              ),

              SwitchListTile(
                title: Text(AppLocalizations.of(context).markCounts),
                value: config.count.visible,
                onChanged: (val) => notifier.updateElementVisibility('count', val),
              ),

              SwitchListTile(
                title: Text(AppLocalizations.of(context).phoneNumberType),
                value: config.numberType.visible,
                onChanged: (val) => notifier.updateElementVisibility('numberType', val),
              ),

              SwitchListTile(
                title: Text(AppLocalizations.of(context).stirVerificationTitle),
                value: config.stir.visible,
                onChanged: (val) => notifier.updateElementVisibility('stir', val),
              ),

              SwitchListTile(
                title: Text(AppLocalizations.of(context).simCardTitle),
                value: config.simCard.visible,
                onChanged: (val) => notifier.updateElementVisibility('simCard', val),
              ),

              SwitchListTile(
                title: Text(AppLocalizations.of(context).securityMessage),
                value: config.securityMessage.visible,
                onChanged: (val) => notifier.updateElementVisibility('securityMessage', val),
              ),

              const SizedBox(height: 20),
              InlineAdaptiveBannerAdWidget(adInfo: AdManager.bannerAd, width: 400),
            ],
          );
        },
      ),
    );
  }

  /// 构建专属于 Live Activity / 实时通知的预览卡片
  Widget _buildLivePreviewCard(LiveNotificationConfig config) {
    final mockData = CallerIdMockData.mockCallerIdData();
    final mockSimInfo = CallerIdMockData.mockSimInfoData();
    final mockStirInfo = CallerIdMockData.mockStirInfoData();

    final String? labelText = (mockData.labels != null && mockData.labels!.isNotEmpty)
        ? mockData.labels!.first.label
        : null;
    final ImageProvider? avatarProvider = config.avatar.visible
        ? AvatarUtils.getAvatarImage(mockData.avatar, labelText)
        : null;

    final List<String> details = [];
    if (config.carrier.visible && mockData.carrier != null) details.add(mockData.carrier!);
    if (config.location.visible && mockData.region != null) details.add(mockData.region!);
    if (config.countryName.visible && mockData.countryName != null) details.add(mockData.countryName!);
    if (config.simCard.visible && mockSimInfo.displayName != null) details.add(mockSimInfo.displayName!);
    final String detailLine = details.join(' · ');

    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. 展开大卡片（锁屏 / Android 展开式实时通知）
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: theme.dividerColor.withAlpha(80)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(20),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  if (config.avatar.visible && avatarProvider != null)
                    CircleAvatar(radius: 22, backgroundImage: avatarProvider)
                  else if (config.avatar.visible)
                    CircleAvatar(
                      radius: 22,
                      backgroundColor: AvatarUtils.getColorFromName(mockData.name ?? ''),
                      child: const Icon(Icons.person, color: Colors.white, size: 26),
                    ),
                  if (config.avatar.visible) const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (config.name.visible)
                          Text(
                            mockData.name ?? AppLocalizations.of(context).callerIdNotificationTitle,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontSize: config.name.fontSize,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        if (config.number.visible)
                          Text(
                            mockData.phoneNumber.value,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontSize: config.number.fontSize,
                              color: theme.textTheme.bodyMedium?.color?.withAlpha(180),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              if (detailLine.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(
                  detailLine,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.textTheme.bodySmall?.color?.withAlpha(160),
                  ),
                ),
              ],
              if (config.stir.visible && mockStirInfo.isVerified) ...[
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.verified_user, color: Colors.green, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      AppLocalizations.of(context).stirVerificationTitle,
                      style: const TextStyle(
                        color: Colors.green,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
        const SizedBox(height: 12),

        // 2. 紧凑胶囊态（灵动岛 / 状态栏芯片）
        Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(40),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (config.avatar.visible && avatarProvider != null)
                  CircleAvatar(radius: 10, backgroundImage: avatarProvider)
                else
                  const Icon(Icons.phone_in_talk, color: Colors.blueAccent, size: 16),
                const SizedBox(width: 8),
                if (config.name.visible)
                  Text(
                    mockData.name ?? AppLocalizations.of(context).callerIdNotificationTitle,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                else
                  Text(
                    mockData.phoneNumber.value,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
