import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/features/plugin/services/plugin_execution_service.dart';
import 'package:yourcallyourrule/features/plugin/services/plugin_invoker_service.dart';
import 'package:yourcallyourrule/features/plugin/services/plugin_manager_service.dart';

import 'package:yourcallyourrule/core/provider/basic_provider/plugin_repository_provider.dart';
import 'config_repository_provider.dart';

/// PluginInvokerService的Provider
/// PluginInvokerService的Provider
final pluginServiceProvider = Provider<PluginInvokerService>((ref) {
  final pluginManagerService = PluginManagerService(
    ref.watch(pluginRepositoryProvider),
    configRepository: ref.watch(configRepositoryProvider),
  );
  final pluginExecutionService = PluginExecutionService();
  return PluginInvokerService(pluginManagerService, pluginExecutionService);
});
