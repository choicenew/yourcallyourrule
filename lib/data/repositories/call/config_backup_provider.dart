import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/data/repositories/call/config_backup_service.dart';
import 'package:yourcallyourrule/data/repositories/call/config_repository.dart';

/// 配置备份还原服务提供者
/// 用于在应用中提供ConfigBackupService的实例
final configBackupServiceProvider = Provider<ConfigBackupService>((ref) {
  // 获取ConfigRepository实例
  final configRepository = SharedPreferencesConfigRepository();
  
  // 创建ConfigBackupService实例
  final service = ConfigBackupService(configRepository);
  
  // 初始化服务
  service.initialize();
  
  return service;
});

/// 配置仓库提供者
/// 用于在应用中提供ConfigRepository的实例
final configRepositoryProvider = Provider<ConfigRepository>((ref) {
  return SharedPreferencesConfigRepository();
});