import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yourcallyourrule/core/provider/providers/config_repository_provider.dart';
import 'package:yourcallyourrule/data/repositories/config/config_repository.dart';
import 'package:yourcallyourrule/features/call/call_filter/config/call_filter_config.dart';

part 'call_filter_provider.g.dart';

@riverpod
class CallFilterConfigNotifier extends _$CallFilterConfigNotifier {
  static const String _configKey = 'config_call_filter';

  ConfigRepository get _configRepo => ref.read(configRepositoryProvider);

  @override
  Future<CallFilterConfig> build() async {
    final configMap = await _configRepo.getConfig(_configKey);
    if (configMap != null) {
      return CallFilterConfig.fromMap(configMap);
    }
    return CallFilterConfig(); // 返回默认配置
  }

  /// 提供一个统一的更新方法，接收一个新的Config对象
  Future<void> updateConfig(CallFilterConfig newConfig) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _configRepo.saveConfig(_configKey, newConfig.toMap());
      return newConfig;
    });
  }
}