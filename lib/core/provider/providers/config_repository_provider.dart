import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yourcallyourrule/data/repositories/config/config_repository.dart';

/// 共享偏好设置的Provider
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('需要在ProviderScope.overrides中提供实际实例');
});

/// ConfigRepository的Provider
final configRepositoryProvider = Provider<ConfigRepository>((ref) {
  return SharedPreferencesConfigRepository();
});