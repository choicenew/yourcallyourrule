import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plugindemo/features/plugin/services/plugin_execution_service.dart';

final pluginExecutionServiceProvider = Provider<PluginExecutionService>((ref) {
  return PluginExecutionService();
});
