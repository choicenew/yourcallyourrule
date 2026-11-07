import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:material_ui/material_ui.dart';
import 'package:path/path.dart' as p;
import 'package:pyro_cloud_drive_protocol/pyro_cloud_drive_protocol.dart';
import 'package:webdav_client_plus/webdav_client_plus.dart' as webdav;

class WebDAVDriveAdapter implements CloudDriveAdapter {
  static const uiConfig = CloudServiceUIConfig(
    driverToken: WebDAVDriveAdapter,
    defaultDisplayName: 'WebDAV',
    icon: Icons.cloud_queue,
    themeColor: Color(0xFF2196F3),
    usesOAuth: false,
    fields: [
      CloudConfigField(
        key: 'server_url',
        label: 'Server URL',
        hint: 'https://dav.jianguoyun.com/dav/',
      ),
      CloudConfigField(key: 'username', label: 'Username'),
      CloudConfigField(
        key: 'password',
        label: 'Password',
        type: CloudConfigFieldType.password,
      ),
      CloudConfigField(
        key: 'folder_name',
        label: 'Sync Folder',
        hint: 'Optional custom root folder',
      ),
    ],
  );
  webdav.WebdavClient? _client;
  String? _serverUrl;
  String? _rootFolder;

  @override
  Type get driverToken => WebDAVDriveAdapter;

  @override
  String getTitle(BuildContext context) => 'WebDAV';

  @override
  Future<bool> isConnected() async {
    if (_client == null) return false;
    try {
      return await _client!.exists('/');
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> connect(Map<String, dynamic> credentials) async {
    try {
      final serverUrl =
          credentials['serverUrl']?.toString() ??
          credentials['server_url']?.toString() ??
          '';
      final username = credentials['username']?.toString() ?? '';
      final password = credentials['password']?.toString() ?? '';
      _rootFolder =
          credentials['folderName']?.toString() ??
          credentials['folder_name']?.toString() ??
          '';

      if (serverUrl.isEmpty || username.isEmpty) return false;
      _serverUrl = serverUrl;

      _client = webdav.WebdavClient.basicAuth(
        url: serverUrl,
        user: username,
        pwd: password,
      );

      return await isConnected();
    } catch (e) {
      _client = null;
      return false;
    }
  }

  @override
  Future<bool> disconnect() async {
    _client = null;
    return true;
  }

  String _normalizePath(String remotePath) {
    var path = remotePath.replaceAll(r'\\', '/');
    if (_rootFolder != null && _rootFolder!.isNotEmpty) {
      if (!path.startsWith('/\$_rootFolder') &&
          !path.startsWith(_rootFolder!)) {
        path = p.posix.join(_rootFolder!, path);
      }
    }
    if (!path.startsWith('/')) {
      path = '/$path';
    }
    return path;
  }

  @override
  Future<List<CloudFileItem>> listFiles(String remoteDirectory) async {
    if (_client == null) return [];
    try {
      final path = _normalizePath(remoteDirectory);
      if (!await _client!.exists(path)) return [];
      final files = await _client!.readDir(path);
      return files.map((f) {
        return CloudFileItem(
          name: f.name,
          path: f.path,
          size: f.size ?? 0,
          lastModified: f.modified ?? DateTime.now(),
          isDirectory: f.isDir,
          hash: f.eTag,
        );
      }).toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<bool> uploadFile(String localPath, String remotePath) async {
    if (_client == null) return false;
    try {
      final file = File(localPath);
      if (!file.existsSync()) return false;
      final bytes = await file.readAsBytes();
      final path = _normalizePath(remotePath);
      final dir = p.posix.dirname(path);
      if (dir.isNotEmpty && dir != '/' && !await _client!.exists(dir)) {
        await _client!.mkdir(dir);
      }
      await _client!.write(path, bytes);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> downloadFile(String remotePath, String localPath) async {
    if (_client == null) return false;
    try {
      final path = _normalizePath(remotePath);
      if (!await _client!.exists(path)) return false;
      final content = await _client!.read(path);
      final file = File(localPath);
      await file.parent.create(recursive: true);
      await file.writeAsBytes(content);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<dynamic> readFile(String remotePath) async {
    if (_client == null) return null;
    try {
      final path = _normalizePath(remotePath);
      if (!await _client!.exists(path)) return null;
      final bytes = await _client!.read(path);
      try {
        return utf8.decode(bytes);
      } catch (_) {
        return bytes;
      }
    } catch (e) {
      return null;
    }
  }

  @override
  Future<bool> writeFile(String remotePath, dynamic data) async {
    if (_client == null) return false;
    try {
      final path = _normalizePath(remotePath);
      final dir = p.posix.dirname(path);
      if (dir.isNotEmpty && dir != '/' && !await _client!.exists(dir)) {
        await _client!.mkdir(dir);
      }
      List<int> bytes;
      if (data is String) {
        bytes = utf8.encode(data);
      } else if (data is List<int>) {
        bytes = data;
      } else {
        bytes = utf8.encode(jsonEncode(data));
      }
      await _client!.write(
        path,
        bytes is Uint8List ? bytes : Uint8List.fromList(bytes),
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> fileExists(String remotePath) async {
    if (_client == null) return false;
    try {
      final path = _normalizePath(remotePath);
      return await _client!.exists(path);
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> deleteFile(String remotePath) async {
    if (_client == null) return false;
    try {
      final path = _normalizePath(remotePath);
      await _client!.remove(path);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<String?> getRemoteFileHash(String remotePath) async {
    if (_client == null) return null;
    try {
      final path = _normalizePath(remotePath);
      if (!await _client!.exists(path)) return null;
      final resources = await _client!.readDir(path);
      return resources.firstOrNull?.eTag;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<String?> getDownloadUrl(String remotePath) async {
    if (_serverUrl == null) return null;
    final path = _normalizePath(remotePath);
    return '$_serverUrl$path';
  }
}
