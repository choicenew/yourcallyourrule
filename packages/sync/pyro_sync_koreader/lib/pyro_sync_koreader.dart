library pyro_sync_koreader;

import 'package:material_ui/material_ui.dart';
import 'package:pyro_sync_hub/pyro_sync_hub.dart';
import 'package:pyro_sync_ui/pyro_sync_ui.dart';
import 'src/koreader_sync_adapter.dart';

export 'src/koreader_sync_adapter.dart';

class PyroSyncKoReader {
  static void register({
    String kosyncServerUrl = '',
    String username = '',
    String userKey = '',
  }) {
    SyncHub.instance.register(
      KoReaderSyncAdapter(
        kosyncServerUrl: kosyncServerUrl,
        username: username,
        userKey: userKey,
      ),
      uiConfig: SyncServiceUIConfig(
        providerId: 'koreader',
        displayName: 'KoSync 电子书同步',
        icon: Icons.menu_book,
        themeColor: const Color(0xFFFF9800),
        settingsBuilder: (context) => const Placeholder(),
      ),
    );
  }
}
