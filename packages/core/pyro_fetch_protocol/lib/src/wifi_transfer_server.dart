import 'dart:async';
import 'dart:io';

/// 无线传书服务器日志回调
typedef TransferLogCallback = void Function(String clientIp, String fileName, int bytesReceived);

/// 迁移自 readest 的局域网 HTTP/WebDAV 无线传书服务器逻辑
class WifiTransferServer {
  HttpServer? _server;
  final int port;
  final String storagePath;
  TransferLogCallback? onFileReceived;

  WifiTransferServer({
    this.port = 8080,
    required this.storagePath,
  });

  bool get isRunning => _server != null;
  String? get serverUrl => _server != null ? 'http://${_server!.address.host}:${_server!.port}' : null;

  /// 启动局域网无线传书服务器
  Future<bool> start() async {
    if (_server != null) return true;
    try {
      _server = await HttpServer.bind(InternetAddress.anyIPv4, port);
      _server!.listen(_handleRequest);
      return true;
    } catch (_) {
      return false;
    }
  }

  /// 停止服务器
  Future<void> stop() async {
    await _server?.close(force: true);
    _server = null;
  }

  /// 处理文件上传与 Web 页面响应
  void _handleRequest(HttpRequest request) async {
    final response = request.response;
    response.headers.add('Access-Control-Allow-Origin', '*');

    if (request.method == 'GET') {
      response.headers.contentType = ContentType.html;
      response.write('''<!DOCTYPE html>
<html>
<head><title>PyroReader 无线传书</title></head>
<body>
<h2>PyroReader 无线传书服务</h2>
<form action="/upload" method="post" enctype="multipart/form-data">
  <input type="file" name="file" />
  <input type="submit" value="上传图书到阅读器" />
</form>
</body>
</html>''');
      await response.close();
    } else if (request.method == 'POST' && request.uri.path == '/upload') {
      final bytes = await request.fold<List<int>>([], (a, b) => a..addAll(b));
      final clientIp = request.connectionInfo?.remoteAddress.address ?? 'unknown';
      
      final saveFile = File('$storagePath/uploaded_${DateTime.now().millisecondsSinceEpoch}.epub');
      await saveFile.writeAsBytes(bytes);

      if (onFileReceived != null) {
        onFileReceived!(clientIp, saveFile.path, bytes.length);
      }

      response.headers.contentType = ContentType.json;
      response.write('{"status":"success","path":"${saveFile.path}"}');
      await response.close();
    } else {
      response.statusCode = HttpStatus.notFound;
      await response.close();
    }
  }
}
