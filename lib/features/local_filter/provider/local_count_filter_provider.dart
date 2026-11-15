import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yourcallyourrule/features/config/data/repositories/config_repository.dart';
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
    // 0ms 乐观更新，不摧毁 UI 渲染树与手势
    state = AsyncValue.data(newConfig);
    try {
      await _configRepo.saveConfig(_configKey, newConfig.toMap());
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}