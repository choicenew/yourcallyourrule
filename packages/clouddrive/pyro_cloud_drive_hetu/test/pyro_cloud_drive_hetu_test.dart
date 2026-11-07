import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pyro_cloud_drive_hub/pyro_cloud_drive_hub.dart';
import 'package:pyro_cloud_drive_hetu/pyro_cloud_drive_hetu.dart';

class MockDriver implements CloudDriveAdapter {
  @override
  Type get driverToken => MockDriver;
  @override
  String getTitle(BuildContext context) => 'Mock';
  @override
  Future<bool> connect(Map<String, dynamic> credentials) async => true;
  @override
  Future<bool> deleteFile(String remotePath) async => true;
  @override
  Future<bool> disconnect() async => true;
  @override
  Future<bool> downloadFile(String remotePath, String localPath) async => true;
  @override
  Future<bool> fileExists(String remotePath) async => remotePath == '/exists.txt';
  @override
  Future<String?> getDownloadUrl(String remotePath) async => 'https://mock/dl';
  @override
  Future<String?> getRemoteFileHash(String remotePath) async => 'hash123';
  @override
  Future<bool> isConnected() async => true;
  @override
  Future<List<CloudFileItem>> listFiles(String remoteDirectory) async => [
        CloudFileItem(name: 'file1.txt', path: '/file1.txt', lastModified: DateTime.now())
      ];
  @override
  Future<dynamic> readFile(String remotePath) async => 'mock content';
  @override
  Future<bool> uploadFile(String localPath, String remotePath) async => true;
  @override
  Future<bool> writeFile(String remotePath, dynamic data) async => true;
}

void main() {
  setUp(() {
    CloudDriveHub.instance.clear();
    CloudDriveHub.instance.register(MockDriver());
  });

  group('CloudDriveHetuBinding Tests', () {
    test('Binding correctly invokes Hub methods', () async {
      final binding = CloudDriveBinding();

      final listFun = binding.memberGet('CloudDrive.list') as Function;
      final files = await listFun(positionalArgs: ['mock', '/dir']);
      expect(files, isA<List>());
      expect(files.length, 1);

      final readFun = binding.memberGet('CloudDrive.read') as Function;
      final content = await readFun(positionalArgs: ['mock', '/test.txt']);
      expect(content, 'mock content');

      final existsFun = binding.memberGet('CloudDrive.exists') as Function;
      expect(await existsFun(positionalArgs: ['mock', '/exists.txt']), isTrue);
      expect(await existsFun(positionalArgs: ['mock', '/not_found.txt']), isFalse);
    });
  });
}
