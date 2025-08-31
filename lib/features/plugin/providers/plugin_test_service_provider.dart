import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/features/plugin/services/plugin_test_service.dart';

final pluginTestServiceProvider = Provider<PluginTestService>((ref) {
  final service = PluginTestService();
  ref.onDispose(() => service.dispose());
  return service;
});