import 'package:yourcallyourrule/data/repositories/config/config_repository.dart';

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