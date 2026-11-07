library pyro_sync_suwayomi;

import 'package:material_ui/material_ui.dart';
import 'package:pyro_sync_hub/pyro_sync_hub.dart';
import 'package:pyro_sync_ui/pyro_sync_ui.dart';

export 'src/service/suwayomi_service_impl.dart';

class PyroSyncSuwayomi {
  static void register() {
    SyncHub.instance.registerUIConfig(
      'suwayomi',
      SyncServiceUIConfig(
        providerId: 'suwayomi',
        displayName: 'Suwayomi 漫画书架同步',
        icon: Icons.auto_stories,
        themeColor: const Color(0xFFE91E63),
        settingsBuilder: (context) => const Placeholder(),
      ),
    );
  }
}
