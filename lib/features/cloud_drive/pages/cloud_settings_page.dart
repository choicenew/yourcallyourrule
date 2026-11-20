import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_cloud_drive_ui/pyro_cloud_drive_ui.dart' as cloud_ui;
import 'package:yourcallyourrule/features/commercial/services/commercial_service.dart';
import 'package:yourcallyourrule/features/commercial/widgets/vip_feature_guard.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 云盘设置页面 —— 100% 渲染包内 pyro_cloud_drive_ui 自注册标准页面，仅限 VIP 用户解锁
class CloudSettingsPage extends ConsumerWidget {
  const CloudSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final isVip = ref.watch(isVipUserProvider);

    if (!isVip) {
      return VipFeatureGuard(
        title: l10n.cloudSyncSettingsTitle,
      );
    }

    return const cloud_ui.CloudSettingsPage();
  }
}
