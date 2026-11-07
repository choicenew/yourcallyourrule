import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'config_repository.dart';
import 'config_backup_service.dart';

part 'config_backup_provider.g.dart';

/// 全局单一正统预加载 SharedPreferences Provider
final sharedPreferencesProvider = Provider<SharedPreferences?>((ref) {
  return null;
});

/// 配置仓库提供者
@riverpod
ConfigRepository configRepository(Ref ref) {
  return SharedPreferencesConfigRepository();
}

/// 配置备份服务提供者
@riverpod
ConfigBackupService configBackupService(Ref ref) {
  final configRepository = ref.watch(configRepositoryProvider);
  final service = ConfigBackupService(configRepository);

  service.initialize();

  return service;
}
