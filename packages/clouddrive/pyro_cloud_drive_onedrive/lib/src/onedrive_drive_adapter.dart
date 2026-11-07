import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';

import 'package:material_ui/material_ui.dart';
import 'package:pyro_cloud_drive_protocol/pyro_cloud_drive_protocol.dart';

class OneDriveDriveAdapter implements CloudDriveAdapter {
  static const uiConfig = CloudServiceUIConfig(
    driverToken: OneDriveDriveAdapter,
    defaultDisplayName: 'Microsoft OneDrive',
    icon: Icons.cloud,
    themeColor: Color(0xFF0078D4),
    usesOAuth: true,
    fields: [
      CloudConfigField(key: 'folder_name', label: 'Sync Folder', hint: 'Optional custom root folder'),
    ],
  );
  String? _accessToken;
  final Dio _dio = Dio();
  static const String _graphBaseUrl = 'https://graph.microsoft.com/v1.0/me/drive';

  @override
  Type get driverToken => OneDriveDriveAdapter;

  @override
  String getTitle(BuildContext context) => 'Microsoft OneDrive';

  @override
  Future<bool> isConnected() async => _accessToken != null && _accessToken!.isNotEmpty;

  @override
  Future<bool> connect(Map<String, dynamic> credentials) async {
    final token = credentials['accessToken']?.toString() ??
        credentials['access_token']?.toString();
    if (token != null && token.isNotEmpty) {
      _accessToken = token;
      return true;
    }
    return false;
  }

  @override
  Future<bool> disconnect() async {
    _accessToken = null;
    return true;
  }

  Map<String, String> get _headers => {
        'Authorization': 'Bearer $_accessToken',
        'Content-Type': 'application/json',
      };

  String _formatPath(String remotePath) {
    var path = remotePath.replaceAll(r'\', '/');
    if (path.startsWith('/')) path = path.substring(1);
    return path;
  }

  @override
  Future<List<CloudFileItem>> listFiles(String remoteDirectory) async {
    if (!await isConnected()) return [];
    try {
      final path = _formatPath(remoteDirectory);
      final url = path.isEmpty
          ? '$_graphBaseUrl/root/children'
          : '$_graphBaseUrl/root:/$path:/children';

      final response = await _dio.get(url, options: Options(headers: _headers));
      if (response.statusCode == 200) {
        final List value = response.data['value'] ?? [];
        return value.map((item) {
          return CloudFileItem(
            name: item['name'] ?? '',
            path: item['parentReference']?['path'] != null
                ? '${item['parentReference']['path']}/${item['name']}'
                : item['name'] ?? '',
            size: item['size'] ?? 0,
            lastModified: item['lastModifiedDateTime'] != null
                ? DateTime.tryParse(item['lastModifiedDateTime']) ?? DateTime.now()
                : DateTime.now(),
            isDirectory: item.containsKey('folder'),
            hash: item['file']?['hashes']?['quickXorHash'] ??
                item['file']?['hashes']?['sha1Hash'],
          );
        }).toList();
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  @override
  Future<bool> uploadFile(String localPath, String remotePath) async {
    if (!await isConnected()) return false;
    try {
      final file = File(localPath);
      if (!file.existsSync()) return false;
      final bytes = await file.readAsBytes();
      final path = _formatPath(remotePath);
      final url = '$_graphBaseUrl/root:/$path:/content';

      final response = await _dio.put(
        url,
        data: bytes,
        options: Options(headers: {
          'Authorization': 'Bearer $_accessToken',
          'Content-Type': 'application/octet-stream',
        }),
      );
      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> downloadFile(String remotePath, String localPath) async {
    if (!await isConnected()) return false;
    try {
      final path = _formatPath(remotePath);
      final url = '$_graphBaseUrl/root:/$path:/content';
      final file = File(localPath);
      await file.parent.create(recursive: true);

      final response = await _dio.download(
        url,
        localPath,
        options: Options(headers: {'Authorization': 'Bearer $_accessToken'}),
      );
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<dynamic> readFile(String remotePath) async {
    if (!await isConnected()) return null;
    try {
      final path = _formatPath(remotePath);
      final url = '$_graphBaseUrl/root:/$path:/content';
      final response = await _dio.get(
        url,
        options: Options(
          headers: {'Authorization': 'Bearer $_accessToken'},
          responseType: ResponseType.plain,
        ),
      );
      return response.data;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<bool> writeFile(String remotePath, dynamic data) async {
    if (!await isConnected()) return false;
    try {
      final path = _formatPath(remotePath);
      final url = '$_graphBaseUrl/root:/$path:/content';
      final dynamic body = data is String ? data : jsonEncode(data);

      final response = await _dio.put(
        url,
        data: body,
        options: Options(headers: {
          'Authorization': 'Bearer $_accessToken',
          'Content-Type': 'application/octet-stream',
        }),
      );
      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> fileExists(String remotePath) async {
    if (!await isConnected()) return false;
    try {
      final path = _formatPath(remotePath);
      final url = '$_graphBaseUrl/root:/$path';
      final response = await _dio.get(url, options: Options(headers: _headers));
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> deleteFile(String remotePath) async {
    if (!await isConnected()) return false;
    try {
      final path = _formatPath(remotePath);
      final url = '$_graphBaseUrl/root:/$path';
      final response = await _dio.delete(url, options: Options(headers: _headers));
      return response.statusCode == 204 || response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<String?> getRemoteFileHash(String remotePath) async {
    if (!await isConnected()) return null;
    try {
      final path = _formatPath(remotePath);
      final url = '$_graphBaseUrl/root:/$path';
      final response = await _dio.get(url, options: Options(headers: _headers));
      if (response.statusCode == 200) {
        return response.data['file']?['hashes']?['quickXorHash'] ??
            response.data['file']?['hashes']?['sha1Hash'];
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<String?> getDownloadUrl(String remotePath) async {
    if (!await isConnected()) return null;
    try {
      final path = _formatPath(remotePath);
      final url = '$_graphBaseUrl/root:/$path';
      final response = await _dio.get(url, options: Options(headers: _headers));
      if (response.statusCode == 200) {
        return response.data['@microsoft.graph.downloadUrl'];
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
