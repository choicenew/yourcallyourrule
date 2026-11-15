import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yourcallyourrule/features/config/data/repositories/config_repository.dart';
import 'package:yourcallyourrule/features/remote_filter/config/remote_number_filter_config.dart';
import 'package:yourcallyourrule/features/remote_filter/services/remote_number_service.dart';

part 'remote_number_filter_provider.g.dart';

@riverpod
class RemoteNumberFilterConfigNotifier extends _$RemoteNumberFilterConfigNotifier {
  static const String _configKey = 'config_remote_number_filter';

  ConfigRepository get _configRepo => ref.read(configRepositoryProvider);

  @override
  Future<RemoteNumberFilterConfig> build() async {
    final configMap = await _configRepo.getConfig(_configKey);
    final config = configMap != null
        ? RemoteNumberFilterConfig.fromMap(configMap)
        : RemoteNumberFilterConfig();

    ref
        .read(remoteNumberServiceProvider)
        .setCountThreshold(config.countThreshold);
    return config;
  }

  Future<void> updateConfig(RemoteNumberFilterConfig newConfig) async {
    // 0ms 乐观更新，避免高频拖动 Slider 时触发 Loading 销毁 RenderBox
    state = AsyncValue.data(newConfig);
    try {
      await _configRepo.saveConfig(_configKey, newConfig.toMap());
      ref
          .read(remoteNumberServiceProvider)
          .setCountThreshold(newConfig.countThreshold);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
