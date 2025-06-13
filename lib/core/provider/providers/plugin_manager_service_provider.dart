import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/features/plugin/services/plugin_manager_service.dart';
import 'package:yourcallyourrule/core/provider/basic_provider/plugin_repository_provider.dart';
import 'package:yourcallyourrule/core/provider/providers/config_repository_provider.dart';

/// PluginManagerService的Provider
final pluginManagerServiceProvider = Provider<PluginManagerService>((ref) {
  final pluginRepository = ref.watch(pluginRepositoryProvider);
  final configRepository = ref.watch(configRepositoryProvider);
  return PluginManagerService(pluginRepository, configRepository: configRepository);
});