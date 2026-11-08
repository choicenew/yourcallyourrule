import 'package:material_ui/material_ui.dart';
import 'package:pyro_user_database_protocol/pyro_user_database_protocol.dart';
import '../../config/supabase_sync_config_provider.dart';
import '../l10n/generated/app_localizations.dart';

/// Supabase 数据库同步强类型 Provider 实体描述符 (纯底层 Driver 零 Hub 依赖，跨 Package 0 冲突)
class SupabaseSyncEntity implements SyncProviderEntity {
  const SupabaseSyncEntity();

  @override
  Type get entityToken => SupabaseSyncEntity;

  @override
  String Function(BuildContext context) get titleBuilder =>
      (context) => AppLocalizations.of(context)!.supabaseSyncTitle;

  @override
  IconData get icon => Icons.cloud_sync;

  @override
  Color get themeColor => const Color(0xFF3ECF8E);

  @override
  Future<bool> testConnection() async {
    return SupabaseSyncConfigStore.instance.isConfigured;
  }
}
