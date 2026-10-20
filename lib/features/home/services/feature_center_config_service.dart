import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yourcallyourrule/data/repositories/config/config_repository.dart';

part 'feature_center_config_service.g.dart';

@Riverpod(keepAlive: true)
FeatureCenterConfigService featureCenterConfigService(Ref ref) {
  final configRepository = ref.watch(configRepositoryProvider);
  return FeatureCenterConfigService(configRepository);
}

class FeatureCenterConfigService {
  final ConfigRepository _configRepository;
  static const String _configKey = 'config_feature_center_order';

  FeatureCenterConfigService(this._configRepository);

  Future<List<String>?> getOrder() async {
    final json = await _configRepository.getConfig(_configKey);
    if (json != null && json['order'] is List) {
      return List<String>.from(json['order']);
    }
    return null;
  }

  Future<void> saveOrder(List<String> order) async {
    await _configRepository.saveConfig(_configKey, {'order': order});
  }
}
