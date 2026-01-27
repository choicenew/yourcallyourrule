import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plugindemo/features/plugin/services/plugin_url_execution_service.dart';

final pluginUrlWebViewServiceProvider = Provider<PluginUrlExecutionService>((
  ref,
) {
  return PluginUrlExecutionService();
});
