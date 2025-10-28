import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yourcallyourrule/core/provider/providers/config_repository_provider.dart';
import 'package:yourcallyourrule/data/repositories/config/config_repository.dart';
import 'package:yourcallyourrule/features/call/time_interceptor/time_interceptor_config.dart';



part 'time_interceptor_provider.g.dart';

// 2. 移除了 TimeInterceptorConfig 类的重复定义

// 状态管理器 (AsyncNotifier)
@riverpod
class TimeInterceptorConfigNotifier extends _$TimeInterceptorConfigNotifier {
  static const String _configKey = 'config_time_interceptor';

  ConfigRepository get _configRepo => ref.read(configRepositoryProvider);

  @override
  Future<TimeInterceptorConfig> build() async {
    final configMap = await _configRepo.getConfig(_configKey);
    if (configMap != null) {
      return TimeInterceptorConfig.fromMap(configMap);
    }
    return const TimeInterceptorConfig(); // 返回默认配置
  }

  // 更新方法保持不变
  Future<void> updateShouldIntercept(bool isEnabled) async {
    final previousState = await future;
    final newState = previousState.copyWith(shouldIntercept: isEnabled);

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _configRepo.saveConfig(_configKey, newState.toMap());
      return newState;
    });
  }

  Future<void> updateDuration(int minutes) async {
    final previousState = await future;
    final newState = previousState.copyWith(duration: Duration(minutes: minutes));

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _configRepo.saveConfig(_configKey, newState.toMap());
      return newState;
    });
  }
}