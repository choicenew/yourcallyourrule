import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/data/repositories/config/config_repository.dart';
import 'package:yourcallyourrule/features/home/services/feature_center_config_service.dart';

final configRepositoryProvider = Provider<ConfigRepository>((ref) => SharedPreferencesConfigRepository());

final featureCenterConfigServiceProvider = Provider<FeatureCenterConfigService>((ref) {
  final configRepository = ref.watch(configRepositoryProvider);
  return FeatureCenterConfigService(configRepository);
});