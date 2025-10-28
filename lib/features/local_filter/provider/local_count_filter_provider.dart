import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yourcallyourrule/core/provider/providers/config_repository_provider.dart';
import 'package:yourcallyourrule/data/repositories/config/config_repository.dart';
import 'package:yourcallyourrule/features/local_filter/config/local_count_filter_config.dart';

part 'local_count_filter_provider.g.dart';

@riverpod
class LocalCountFilterConfigNotifier extends _$LocalCountFilterConfigNotifier {
  static const String _configKey = 'config_local_count_filter';

  ConfigRepository get _configRepo => ref.read(configRepositoryProvider);

  @override
  Future<LocalCountFilterConfig> build() async {
    final configMap = await _configRepo.getConfig(_configKey);
    if (configMap != null) {
      return LocalCountFilterConfig.fromMap(configMap);
    }
    return LocalCountFilterConfig();
  }

  Future<void> updateConfig(LocalCountFilterConfig newConfig) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _configRepo.saveConfig(_configKey, newConfig.toMap());
      return newConfig;
    });
  }
}