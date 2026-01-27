import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/features/plugin/services/plugin_webview_service.dart';

/// Provides a singleton instance of [PluginWebViewService].
final pluginWebViewServiceProvider = Provider<PluginWebViewService>((ref) {
  return PluginWebViewService();
});