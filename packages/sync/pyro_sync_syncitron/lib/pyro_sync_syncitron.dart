library pyro_sync_syncitron;

import 'package:material_ui/material_ui.dart';
import 'package:pyro_sync_hub/pyro_sync_hub.dart';
import 'package:pyro_sync_ui/pyro_sync_ui.dart';

export 'src/store/protocol_local_store.dart';

class PyroSyncSyncitron {
  static void register() {
    SyncHub.instance.registerUIConfig(
      'syncitron',
      SyncServiceUIConfig(
        providerId: 'syncitron',
        displayName: 'Syncitron 离线优先同步',
        icon: Icons.offline_pin,
        themeColor: const Color(0xFF673AB7),
        settingsBuilder: (context) => const Placeholder(),
      ),
    );
  }
}
