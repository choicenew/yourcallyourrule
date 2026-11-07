import 'dart:typed_data';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pyro_cloud_drive_protocol/pyro_cloud_drive_protocol.dart';
import 'package:pyro_cloud_drive_hub/pyro_cloud_drive_hub.dart';

class MockAdapter implements CloudDriveAdapter {
  final String _name;
  MockAdapter([this._name = 'Mock Drive']);

  @override
  Type get driverToken => MockAdapter;
  @override
  String getTitle(BuildContext context) => _name;
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

class SecondaryMockAdapter extends MockAdapter {
  SecondaryMockAdapter() : super('Secondary Mock Drive');
  @override
  Type get driverToken => SecondaryMockAdapter;
}

void main() {
  setUp(() {
    CloudDriveHub.instance.clear();
  });

  group('CloudDriveHub Tests', () {
    test('Register and retrieve driver instance', () {
      final adapter = MockAdapter('WebDAV');
      CloudDriveHub.instance.register(adapter);

      expect(CloudDriveHub.instance.availableProviders, contains(MockAdapter));
      expect(CloudDriveHub.instance.getDriver<MockAdapter>(), equals(adapter));
    });

    test('Register and lazily build driver from builder', () {
      CloudDriveHub.instance.registerBuilder(SecondaryMockAdapter, () => SecondaryMockAdapter());

      expect(CloudDriveHub.instance.availableProviders, contains(SecondaryMockAdapter));
      final driver = CloudDriveHub.instance.getDriver<SecondaryMockAdapter>();
      expect(driver, isNotNull);
      expect(driver!.driverToken, SecondaryMockAdapter);
    });

    test('Active provider switching', () {
      final primary = MockAdapter('Primary');
      final secondary = SecondaryMockAdapter();
      CloudDriveHub.instance.register(primary);
      CloudDriveHub.instance.register(secondary);

      CloudDriveHub.instance.setActiveProvider(SecondaryMockAdapter);
      expect(CloudDriveHub.instance.currentDriver, equals(secondary));
    });
  });
}
