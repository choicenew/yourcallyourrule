import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yourcallyourrule/features/config/data/repositories/config_repository.dart';
import 'package:yourcallyourrule/features/time_interceptor/time_interceptor_config.dart';

part 'time_interceptor_provider.g.dart';

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
    return const TimeInterceptorConfig();
  }

  Future<void> updateShouldIntercept(bool isEnabled) async {
    final previousState = state.value ?? const TimeInterceptorConfig();
    final newState = previousState.copyWith(shouldIntercept: isEnabled);

    // 0ms 乐观更新
    state = AsyncValue.data(newState);
    try {
      await _configRepo.saveConfig(_configKey, newState.toMap());
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> updateDuration(int minutes) async {
    final previousState = state.value ?? const TimeInterceptorConfig();
    final newState = previousState.copyWith(duration: Duration(minutes: minutes));

    // 0ms 乐观更新
    state = AsyncValue.data(newState);
    try {
      await _configRepo.saveConfig(_configKey, newState.toMap());
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
