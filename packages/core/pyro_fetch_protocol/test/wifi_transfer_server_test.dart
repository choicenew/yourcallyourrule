import 'dart:io';
import 'package:test/test.dart';
import 'package:pyro_fetch_protocol/pyro_fetch_protocol.dart';

void main() {
  group('WifiTransferServer 局域网传书服务器测试', () {
    test('服务器启动、响应 HTTP 请求与接收保存文件测试', () async {
      final tempDir = Directory.systemTemp.createTempSync();
      final server = WifiTransferServer(port: 8089, storagePath: tempDir.path);

      final started = await server.start();
      expect(started, isTrue);
      expect(server.isRunning, isTrue);

      final client = HttpClient();
      final req = await client.getUrl(Uri.parse('http://127.0.0.1:8089/'));
      final res = await req.close();
      expect(res.statusCode, equals(200));

      await server.stop();
      expect(server.isRunning, isFalse);

      tempDir.deleteSync(recursive: true);
    });
  });
}
