library pyro_sync_cloudflare;

import 'src/config/cloudflare_sync_config_store.dart';

export 'src/cloudflare_sync_provider.dart';
export 'src/config/cloudflare_sync_config_store.dart';
export 'src/entities/cloudflare_sync_entity.dart';
export 'src/models/cloudflare_sync_payload.dart';
export 'src/widgets/cloudflare_settings_widget.dart';

class PyroSyncCloudflare {
  static void register({
    String workerUrl = '',
    String apiSecret = '',
    String deviceId = '',
  }) {
    if (workerUrl.isNotEmpty || apiSecret.isNotEmpty) {
      CloudflareSyncConfigStore.instance.updateConfig(
        workerUrl: workerUrl,
        apiSecret: apiSecret,
        deviceId: deviceId,
      );
    }
  }
}
