import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/features/plugin/services/plugin_url_webview_service.dart';

final pluginUrlWebViewServiceProvider = Provider<PluginUrlWebViewService>((ref) {
  final service = PluginUrlWebViewService();
  ref.onDispose(() => service.dispose());
  return service;
});