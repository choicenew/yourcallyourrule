import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/setup_config.dart';
import '../services/initial_setup_service.dart';

part 'initial_setup_provider.g.dart';

@riverpod
InitialSetupService initialSetupService(Ref ref) {
  return InitialSetupService();
}

@riverpod
Future<SetupConfig> setupConfig(Ref ref) async {
  final service = ref.watch(initialSetupServiceProvider);
  return await service.fetchConfig();
}

@riverpod
Future<String?> detectedCountryCode(Ref ref) async {
  final service = ref.watch(initialSetupServiceProvider);
  return await service.detectUserCountry();
}
