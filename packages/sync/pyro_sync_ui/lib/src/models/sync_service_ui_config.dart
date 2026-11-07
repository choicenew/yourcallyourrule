import 'package:material_ui/material_ui.dart';

/// Self-registering UI configuration for sync providers (Supabase, WebDAV, KoSync, Cloudflare).
@immutable
class SyncServiceUIConfig {
  final String providerId;
  final String displayName;
  final IconData icon;
  final Color themeColor;
  final WidgetBuilder settingsBuilder;

  const SyncServiceUIConfig({
    required this.providerId,
    required this.displayName,
    required this.icon,
    required this.themeColor,
    required this.settingsBuilder,
  });
}
