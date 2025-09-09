import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/data/repositories/config/config_repository.dart';
import 'package:yourcallyourrule/features/caller_id/config/caller_id_config_repository.dart';

/// CallerID配置仓库提供者
/// 用于在应用中提供CallerIdConfigRepository的实例
final callerIdConfigRepositoryProvider = Provider<CallerIdConfigRepository>((ref) {
  // 获取ConfigRepository实例
  final configRepository = SharedPreferencesConfigRepository();
  
  // 创建CallerIdConfigRepository实例
  return CallerIdConfigRepository(configRepository);
});