import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pyro_cloud_drive_hub/pyro_cloud_drive_hub.dart';
import 'package:pyro_sync_protocol/pyro_sync_protocol.dart';
import 'package:pyro_sync_hub/pyro_sync_hub.dart';
import 'package:pyro_cloud_drive_database/pyro_cloud_drive_database.dart';

class _MockMemoryCloudDriveAdapter implements CloudDriveAdapter {
  final Map<String, dynamic> files = {};

  @override
  Type get driverToken => _MockMemoryCloudDriveAdapter;

  @override
  String getTitle(BuildContext context) => 'Mock Cloud Drive';

  @override
  Future<bool> isConnected() async => true;
  @override
  Future<bool> connect(Map<String, dynamic> credentials) async => true;
  @override
  Future<bool> disconnect() async => true;

  @override
  Future<bool> deleteFile(String remotePath) async {
    files.remove(remotePath);
    return true;
  }

  @override
  Future<bool> downloadFile(String remotePath, String localPath) async => true;
  @override
  Future<bool> fileExists(String remotePath) async => files.containsKey(remotePath);
  @override
  Future<String?> getDownloadUrl(String remotePath) async => null;
  @override
  Future<String?> getRemoteFileHash(String remotePath) async => null;

  @override
  Future<List<CloudFileItem>> listFiles(String remoteDirectory) async => [];

  @override
  Future<dynamic> readFile(String remotePath) async => files[remotePath];

  @override
  Future<bool> uploadFile(String localPath, String remotePath) async => true;

  @override
  Future<bool> writeFile(String remotePath, dynamic data) async {
    files[remotePath] = data;
    return true;
  }
}

class _MockReadingHistorySyncAdapter implements SyncDataAdapter<Map<String, dynamic>> {
  List<Map<String, dynamic>> records = [
    {'id': 'book_01', 'title': 'Deep Learning', 'progress': 0.85},
    {'id': 'book_02', 'title': 'CRISPR Guide', 'progress': 0.32},
  ];

  @override
  String get moduleId => 'reading_history';

  @override
  Future<List<Map<String, dynamic>>> readAll() async => records;

  @override
  Future<void> overwriteAll(List<dynamic> items) async {
    records = items.map((e) => Map<String, dynamic>.from(e as Map)).toList();
  }

  @override
  Future<void> upsert(Map<String, dynamic> item) async {
    final idx = records.indexWhere((e) => e['id'] == item['id']);
    if (idx >= 0) {
      records[idx] = item;
    } else {
      records.add(item);
    }
  }

  @override
  Stream<Map<String, dynamic>> watchChanges() => const Stream.empty();

  @override
  Map<String, dynamic> toJson(Map<String, dynamic> item) => item;

  @override
  Map<String, dynamic> fromJson(Map<String, dynamic> json) => json;
}

void main() {
  group('全新 packages/clouddrive 架构：宿主上下文注入与 Shadow Account 智能物理隔离测试', () {
    late _MockMemoryCloudDriveAdapter mockDrive;

    setUp(() {
      mockDrive = _MockMemoryCloudDriveAdapter();
      CloudDriveHub.instance.register(mockDrive);
      CloudDriveHub.instance.setActiveProvider(_MockMemoryCloudDriveAdapter);

      SyncHub.instance.register(_MockReadingHistorySyncAdapter());
    });

    tearDown(() {
      CloudDriveHub.instance.clear();
      SyncHub.instance.clear();
    });

    test('1. 验证主 App 统一注入宿主上下文后，全流程自动智能合成隔离路径', () {
      // 主 App 注入自身的应用名称（例如 PyroMagma）
      CloudDriveHub.instance.configureHostContext(appName: 'PyroMagma');

      final defaultPath = IncrementalSyncManager.computeRemoteFolder();
      expect(defaultPath, equals('/PyroMagma'));

      // 切换当前活跃影子身份
      CloudDriveHub.instance.updateActiveAccount('FCBA32DE');
      final accountAlphaPath = IncrementalSyncManager.computeRemoteFolder();
      expect(accountAlphaPath, equals('/PyroMagma/FCBA32DE'));

      // 切换到另一个宿主应用（如 PyroNovel）
      CloudDriveHub.instance.configureHostContext(appName: 'PyroNovel', activeAccountId: 'NOVEL_USER_01');
      final novelPath = IncrementalSyncManager.computeRemoteFolder();
      expect(novelPath, equals('/PyroNovel/NOVEL_USER_01'));

      // 验证通用 Package 内彻底无写死
      expect(novelPath.contains('YourCallYourRule'), isFalse);
      expect(novelPath.contains('AuraBackup'), isFalse);
    });

    test('2. 验证多 Shadow Account 同步数据至各自独立的物理子目录中', () async {
      CloudDriveHub.instance.configureHostContext(appName: 'PyroMagma');
      final syncManager = IncrementalSyncManager();

      // 同步 Account A
      CloudDriveHub.instance.updateActiveAccount('ACCOUNT_A');
      await syncManager.syncModule('reading_history');

      // 同步 Account B
      CloudDriveHub.instance.updateActiveAccount('ACCOUNT_B');
      await syncManager.syncModule('reading_history');

      expect(mockDrive.files.containsKey('/PyroMagma/ACCOUNT_A/reading_history.json'), isTrue);
      expect(mockDrive.files.containsKey('/PyroMagma/ACCOUNT_B/reading_history.json'), isTrue);

      final contentA = jsonDecode(mockDrive.files['/PyroMagma/ACCOUNT_A/reading_history.json']);
      expect(contentA, isList);
      expect(contentA.length, equals(2));
    });

    test('3. 验证影子账户禁用云同步时能够精准前置拦截', () async {
      CloudDriveHub.instance.configureHostContext(appName: 'PyroMagma', activeAccountId: 'DISABLED_ACCOUNT');
      final syncManager = IncrementalSyncManager();

      final result = await syncManager.syncModule(
        'reading_history',
        isSyncEnabled: false,
      );

      expect(result, isFalse);
      expect(mockDrive.files.containsKey('/PyroMagma/DISABLED_ACCOUNT/reading_history.json'), isFalse);
    });

    test('4. 验证 BackupRestoreService 自动消费宿主上下文写入隔离子目录', () async {
      CloudDriveHub.instance.configureHostContext(appName: 'PyroMagma', activeAccountId: 'ACCOUNT_VIP');
      final backupService = BackupRestoreService(hub: CloudDriveHub.instance);

      final version = await backupService.createBackup(
        driverToken: _MockMemoryCloudDriveAdapter,
        data: {'key': 'isar_full_snapshot', 'plugin_count': 5},
        deviceId: 'device_01',
        deviceName: 'Pixel 9 Pro',
        encrypt: false,
      );

      expect(version.remotePath.startsWith('PyroMagma/ACCOUNT_VIP/backups/'), isTrue);
      expect(mockDrive.files.containsKey(version.remotePath), isTrue);

      // 验证还原
      final restored = await backupService.restoreBackup(
        driverToken: _MockMemoryCloudDriveAdapter,
        remotePath: version.remotePath,
      );
      expect(restored['key'], equals('isar_full_snapshot'));
      expect(restored['plugin_count'], equals(5));
    });
  });
}
