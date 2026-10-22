import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yourcallyourrule/cloud_sync/provider/backup_restore_provider.dart';
import 'package:yourcallyourrule/cloud_sync/services/backup_encryption_service.dart';
import 'package:yourcallyourrule/cloud_sync/services/backup_restore_service.dart';
import 'package:yourcallyourrule/core/provider/rules_provider.dart';
import 'package:yourcallyourrule/data/repositories/config/config_backup_service.dart';
import 'package:yourcallyourrule/data/repositories/config/config_repository.dart';
import 'package:yourcallyourrule/features/call_statistic/data/services/call_statistics_provider.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    SharedPreferences.setMockInitialValues({});
    
    // Mock path_provider and secure_storage channels
    const MethodChannel pathChannel = MethodChannel('plugins.flutter.io/path_provider');
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(pathChannel, (MethodCall methodCall) async {
      return '.';
    });

    const MethodChannel secureStorageChannel =
        MethodChannel('plugins.it_nomads.com/flutter_secure_storage');
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(secureStorageChannel, (MethodCall methodCall) async {
      return null;
    });
  });

  group('Crashlytics 崩溃修复专项单元测试', () {
    test('1. 验证 BackupRestoreService 异步自愈自动初始化，避免提前调用抛出未初始化异常', () async {
      final encryptionService = BackupEncryptionService();
      final configRepository = SharedPreferencesConfigRepository();
      final configBackupService = ConfigBackupService(configRepository);

      final service = BackupRestoreService(
        encryptionService,
        configBackupService,
      );

      // 故意不先 await service.initialize({})，而是直接并发/同步调起 getBackupConfig()
      // 验证重构后的 _ensureInitialized 能自动调起并 await 初始化完成，决不抛出 Exception
      final config = await service.getBackupConfig();
      expect(config, isNotNull);
      expect(config.keepAllVersions, isFalse);
    });

    test('2. 验证 backupRestoreServiceProvider 容器提供者场景下的自动初始化防崩防护', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final service = container.read(backupRestoreServiceProvider);
      // Provider 实例化后立即读取配置
      final config = await service.getBackupConfig();
      expect(config, isNotNull);
    });

    test('3. 验证 ProviderContainer 无依赖全局 Invalidate，规避组件 Unmount 后访问 Ref 抛出 Bad State', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      // 验证使用 ProviderContainer 直接 invalidate 可以在无 Context/无 Active ConsumerState 时安全触发
      expect(() {
        container.invalidate(callStatisticsProvider);
      }, returnsNormally);
    });
  });
}
