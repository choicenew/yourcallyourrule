import 'package:material_ui/material_ui.dart';
import 'package:pyro_user_database_protocol/pyro_user_database_protocol.dart';
import '../config/cloudflare_sync_config_store.dart';
import '../l10n/generated/app_localizations.dart';

/// Cloudflare 边缘同步强类型 Provider 实体描述符 (纯底层 Driver 零 Hub 依赖，跨 Package 0 冲突)
class CloudflareSyncEntity implements SyncProviderEntity {
  const CloudflareSyncEntity();

  @override
  Type get entityToken => CloudflareSyncEntity;

  @override
  String Function(BuildContext context) get titleBuilder =>
      (context) => AppLocalizations.of(context)!.cloudflareConfigTitle;

  @override
  IconData get icon => Icons.cloud_queue;

  @override
  Color get themeColor => const Color(0xFFF48120);

  @override
  Future<bool> testConnection() async {
    return CloudflareSyncConfigStore.instance.isConfigured;
  }
}
