import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plugindemo/features/plugin/services/plugin_test_service.dart';

final pluginTestServiceProvider = Provider<PluginTestService>((ref) {
  return PluginTestService();
});
