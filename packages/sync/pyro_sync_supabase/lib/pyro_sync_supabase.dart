library supabase_sync_package;

import 'config/supabase_sync_config_provider.dart';

export 'config/supabase_sync_config_provider.dart';
export 'services/supabase_sync_manager.dart';
export 'src/entities/supabase_sync_entity.dart';

class PyroSyncSupabase {
  static void register({
    String supabaseUrl = '',
    String anonKey = '',
    String? serviceRoleKey,
  }) {
    if (supabaseUrl.isNotEmpty || anonKey.isNotEmpty) {
      SupabaseSyncConfigStore.instance.updateConfig(
        supabaseUrl: supabaseUrl,
        anonKey: anonKey,
        serviceRoleKey: serviceRoleKey,
      );
    }
  }
}
