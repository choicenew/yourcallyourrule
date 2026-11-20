import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_sync_ui/pyro_sync_ui.dart';
import 'package:yourcallyourrule/core/coordinator/app_hub_exchange_connector.dart';
import 'package:yourcallyourrule/features/commercial/services/commercial_service.dart';
import 'package:yourcallyourrule/features/commercial/widgets/vip_feature_guard.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 用户个人数据库与云节点同步配置页面 (薄外壳胶水层，100% 装配 pyro_sync_ui，受 VIP 特权管控)
class UserDatabaseSyncPage extends ConsumerWidget {
  const UserDatabaseSyncPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final isVip = ref.watch(isVipUserProvider);

    if (!isVip) {
      return VipFeatureGuard(
        title: l10n.userDatabaseSyncTitle,
      );
    }

    final syncHub = ref.watch(syncHubProvider);

    return SyncSettingsPage(
      title: l10n.userDatabaseSyncTitle,
      statusText: l10n.ready,
      isSyncing: false,
      syncHub: syncHub,
      onSyncNow: () async {
        await ref.read(appHubExchangeConnectorProvider).syncUserDatabase();
      },
    );
  }
}
