import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yourcallyourrule/core/provider/providers/config_repository_provider.dart';
import 'package:yourcallyourrule/data/repositories/config/config_repository.dart';
import 'package:yourcallyourrule/features/remote_filter/config/remote_number_filter_config.dart';
import 'package:yourcallyourrule/features/remote_filter/services/remote_number_service.dart'; // 依赖 remote service

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

    // 同步更新服务中的计数阈值
    ref
        .read(remoteNumberServiceProvider)
        .setCountThreshold(config.countThreshold);
    return config;
  }

  Future<void> updateConfig(RemoteNumberFilterConfig newConfig) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _configRepo.saveConfig(_configKey, newConfig.toMap());
      // 同步更新服务中的计数阈值
      ref
          .read(remoteNumberServiceProvider)
          .setCountThreshold(newConfig.countThreshold);
      return newConfig;
    });
  }
}