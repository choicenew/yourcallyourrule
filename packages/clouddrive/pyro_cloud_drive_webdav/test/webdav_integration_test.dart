import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_test/flutter_test.dart';
import 'package:pyro_cloud_drive_webdav/src/webdav_drive_adapter.dart';

void main() {
  test('WebDAV Integration Test with dlp-test.com', () async {
    final adapter = WebDAVDriveAdapter();
    
    // 1. 尝试连接 (使用用户提供的凭据)
    print('🚀 正在尝试连接 WebDAV 服务器...');
    final connected = await adapter.connect({
      'server_url': 'https://www.dlp-test.com/webdav',
      'username': r'www.dlp-test.com\WebDAV',
      'password': 'WebDAV',
    });
    
    expect(connected, isTrue, reason: '应该能够成功连接到测试服务器');
    print('✅ 连接成功！');

    // 2. 列出文件
    print('📂 正在获取文件列表...');
    final files = await adapter.listFiles('/');
    print('📦 发现 ${files.length} 个文件/目录');
    for (var f in files.take(5)) {
      print('  - ${f.name} (IsDir: ${f.isDirectory})');
    }
    
    // 3. 尝试上传一个测试文件
    print('📤 正在执行上传测试...');
    final testFile = File('webdav_test_upload.txt');
    await testFile.writeAsString('Pyro Governance WebDAV Test - ${DateTime.now()}');
    
    final uploaded = await adapter.uploadFile(testFile.path, 'pyro_test_${DateTime.now().millisecondsSinceEpoch}.txt');
    
    expect(uploaded, isTrue, reason: '应该能够成功上传文件');
    print('✅ 上传测试通过！');
    
    // 清理本地测试文件
    if (await testFile.exists()) await testFile.delete();
  });
}
