import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pyro_cloud_drive_hub/pyro_cloud_drive_hub.dart';
import 'package:pyro_cloud_drive_database/pyro_cloud_drive_database.dart';

class MockMemoryAdapter implements CloudDriveAdapter {
  final Map<String, Uint8List> storage = {};
  @override
  Type get driverToken => MockMemoryAdapter;
  @override
  String getTitle(BuildContext context) => 'Mock Memory Drive';
  @override
  Future<bool> isConnected() async => true;
  @override
  Future<bool> connect(Map<String, dynamic> credentials) async => true;
  @override
  Future<bool> disconnect() async { storage.clear(); return true; }
  @override
  Future<List<CloudFileItem>> listFiles(String remoteDirectory) async => [];
  @override
  Future<bool> uploadFile(String localPath, String remotePath) async => true;
  @override
  Future<bool> downloadFile(String remotePath, String localPath) async => true;
  @override
  Future<dynamic> readFile(String remotePath) async {
    final data = storage[remotePath];
    if (data == null) throw Exception('File not found: $remotePath');
    return data;
  }
  @override
  Future<bool> writeFile(String remotePath, dynamic data) async {
    if (data is Uint8List) {
      storage[remotePath] = data;
    } else if (data is List<int>) {
      storage[remotePath] = Uint8List.fromList(data);
    } else if (data is String) {
      storage[remotePath] = Uint8List.fromList(utf8.encode(data));
    }
    return true;
  }
  @override
  Future<bool> fileExists(String remotePath) async => storage.containsKey(remotePath);
  @override
  Future<bool> deleteFile(String remotePath) async { storage.remove(remotePath); return true; }
  @override
  Future<String?> getRemoteFileHash(String remotePath) async => null;
  @override
  Future<String?> getDownloadUrl(String remotePath) async => null;
}

void main() {
  group('PyroCloudDriveDatabase Full Integration Tests', () {
    late MockMemoryAdapter mockAdapter;

    setUp(() {
      mockAdapter = MockMemoryAdapter();
      CloudDriveHub.instance.register(mockAdapter);
    });

    test('Backup creation and restore verification', () async {
      final service = BackupRestoreService();
      final originalData = {
        'version': 1,
        'tables': {
          'favorites': [{'id': 'fav_1', 'title': 'Solo Leveling'}],
        }
      };

      final backup = await service.createBackup(
        driverToken: MockMemoryAdapter,
        data: originalData,
        deviceId: 'dev_01',
        deviceName: 'Pixel 9 Pro',
        encrypt: false,
      );
      expect(backup.isEncrypted, isFalse);

      final restored = await service.restoreBackup(
        driverToken: MockMemoryAdapter,
        remotePath: backup.remotePath,
        isEncrypted: false,
      );
      expect(restored['version'], equals(1));
    });

    test('Device registration and retrieval works across sync cycles', () async {
      final deviceService = DeviceManagementServiceImpl();
      final dev1 = DeviceEntity(
        deviceId: 'dev_123',
        deviceName: 'My MacBook',
        platform: 'macos',
        lastActiveAt: DateTime.now(),
        appVersion: '2.0.0',
        isCurrentDevice: true,
      );

      await deviceService.registerDevice(device: dev1, driverToken: MockMemoryAdapter);
      final devices = await deviceService.getDevices(driverToken: MockMemoryAdapter);

      expect(devices.length, 1);
      expect(devices.first.deviceName, 'My MacBook');
      expect(devices.first.platform, 'macos');

      await deviceService.removeDevice(deviceId: 'dev_123', driverToken: MockMemoryAdapter);
      final afterRemove = await deviceService.getDevices(driverToken: MockMemoryAdapter);
      expect(afterRemove.isEmpty, isTrue);
    });
  });
}
