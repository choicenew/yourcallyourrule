import 'dart:typed_data';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pyro_cloud_drive_protocol/pyro_cloud_drive_protocol.dart';

class MockAdapter implements CloudDriveAdapter {
  @override
  Type get driverToken => MockAdapter;
  @override
  String getTitle(BuildContext context) => 'Mock Drive';
  @override
  Future<bool> isConnected() async => true;
  @override
  Future<bool> connect(Map<String, dynamic> credentials) async => true;
  @override
  Future<bool> disconnect() async => true;
  @override
  Future<List<CloudFileItem>> listFiles(String remoteDirectory) async => [];
  @override
  Future<bool> uploadFile(String localPath, String remotePath) async => true;
  @override
  Future<bool> downloadFile(String remotePath, String localPath) async => true;
  @override
  Future<dynamic> readFile(String remotePath) async => Uint8List(0);
  @override
  Future<bool> writeFile(String remotePath, dynamic data) async => true;
  @override
  Future<bool> fileExists(String remotePath) async => false;
  @override
  Future<bool> deleteFile(String remotePath) async => true;
  @override
  Future<String?> getRemoteFileHash(String remotePath) async => null;
  @override
  Future<String?> getDownloadUrl(String remotePath) async => null;
}

void main() {
  group('CloudDriveProtocol Tests', () {
    test('CloudFileItem serializes and deserializes correctly', () {
      final now = DateTime.now();
      final item = CloudFileItem(
        name: 'test.txt',
        path: '/docs/test.txt',
        size: 1024,
        lastModified: now,
        isDirectory: false,
      );

      final json = item.toJson();
      final restored = CloudFileItem.fromJson(json);

      expect(restored.name, 'test.txt');
      expect(restored.path, '/docs/test.txt');
      expect(restored.size, 1024);
      expect(restored.isDirectory, isFalse);
    });

    test('MockAdapter fulfills CloudDriveAdapter contract', () async {
      final adapter = MockAdapter();
      expect(adapter.driverToken, MockAdapter);
      expect(await adapter.isConnected(), isTrue);
    });
  });
}
