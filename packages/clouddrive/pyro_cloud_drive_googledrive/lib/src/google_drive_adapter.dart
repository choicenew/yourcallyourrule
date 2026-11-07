import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:path/path.dart' as p;

import 'package:google_sign_in/google_sign_in.dart';
import 'package:material_ui/material_ui.dart';
import 'package:pyro_cloud_drive_protocol/pyro_cloud_drive_protocol.dart';
import 'googledrive_config.dart';

class GoogleDriveAdapter implements CloudDriveAdapter {
  static const uiConfig = CloudServiceUIConfig(
    driverToken: GoogleDriveAdapter,
    defaultDisplayName: 'Google Drive',
    icon: Icons.add_to_drive_outlined,
    themeColor: Color(0xFF34A853),
    usesOAuth: true,
    fields: [
      CloudConfigField(key: 'folder_name', label: 'Sync Folder', hint: 'Optional custom root folder'),
    ],
  );
  drive.DriveApi? _driveApi;

  @override
  Type get driverToken => GoogleDriveAdapter;

  @override
  String getTitle(BuildContext context) => 'Google Drive';


  @override
  Future<bool> isConnected() async => _driveApi != null;

  @override
  Future<bool> connect(Map<String, dynamic> credentials) async {
    var token = credentials['accessToken']?.toString() ??
        credentials['access_token']?.toString();

    if ((token == null || token.isEmpty) && credentials['interactive'] == true) {
      try {
        final serverClientId = credentials['serverClientId']?.toString() ??
            GoogleDriveConfig.defaultServerClientId;
        await GoogleSignIn.instance.initialize(serverClientId: serverClientId);
        final account = await GoogleSignIn.instance.authenticate();
        if (account != null) {
          final auth = await account.authorizationClient.authorizeScopes([drive.DriveApi.driveFileScope]);
          token = auth.accessToken;
        }
      } catch (e) {
        debugPrint('GoogleDriveAdapter interactive sign-in failed: $e');
      }
    }

    if (token != null && token.isNotEmpty) {
      final client = _AuthenticatedClient(token);
      _driveApi = drive.DriveApi(client);
      return true;
    }
    return false;
  }

  @override
  Future<bool> disconnect() async {
    _driveApi = null;
    return true;
  }

  @override
  Future<List<CloudFileItem>> listFiles(String remoteDirectory) async {
    if (_driveApi == null) return [];
    try {
      final fileList = await _driveApi!.files.list(
        q: "trashed = false",
        $fields: "files(id, name, size, modifiedTime, mimeType, md5Checksum)",
      );
      final files = fileList.files ?? [];
      return files.map((f) {
        return CloudFileItem(
          name: f.name ?? '',
          path: f.id ?? '',
          size: int.tryParse(f.size ?? '0') ?? 0,
          lastModified: f.modifiedTime ?? DateTime.now(),
          isDirectory: f.mimeType == 'application/vnd.google-apps.folder',
          hash: f.md5Checksum,
          mimeType: f.mimeType,
        );
      }).toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<bool> uploadFile(String localPath, String remotePath) async {
    if (_driveApi == null) return false;
    try {
      final file = File(localPath);
      if (!file.existsSync()) return false;
      final media = drive.Media(file.openRead(), file.lengthSync());
      final driveFile = drive.File()..name = p.basename(remotePath);
      await _driveApi!.files.create(driveFile, uploadMedia: media);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> downloadFile(String remotePath, String localPath) async {
    if (_driveApi == null) return false;
    try {
      // Find file by name or id
      final fileList = await _driveApi!.files.list(
        q: "name = '${p.basename(remotePath)}' and trashed = false",
        $fields: "files(id, name)",
      );
      final fileId = fileList.files?.firstOrNull?.id;
      if (fileId == null) return false;

      final media = await _driveApi!.files.get(
        fileId,
        downloadOptions: drive.DownloadOptions.fullMedia,
      ) as drive.Media;

      final target = File(localPath);
      await target.parent.create(recursive: true);
      final sink = target.openWrite();
      await media.stream.pipe(sink);
      await sink.flush();
      await sink.close();
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<dynamic> readFile(String remotePath) async {
    if (_driveApi == null) return null;
    try {
      final fileList = await _driveApi!.files.list(
        q: "name = '${p.basename(remotePath)}' and trashed = false",
        $fields: "files(id, name)",
      );
      final fileId = fileList.files?.firstOrNull?.id;
      if (fileId == null) return null;

      final media = await _driveApi!.files.get(
        fileId,
        downloadOptions: drive.DownloadOptions.fullMedia,
      ) as drive.Media;

      final bytes = await media.stream.fold<List<int>>([], (prev, element) => prev..addAll(element));
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
    if (_driveApi == null) return false;
    try {
      List<int> bytes;
      if (data is String) {
        bytes = utf8.encode(data);
      } else if (data is List<int>) {
        bytes = data;
      } else {
        bytes = utf8.encode(jsonEncode(data));
      }
      final media = drive.Media(Stream.value(bytes), bytes.length);
      final driveFile = drive.File()..name = p.basename(remotePath);
      await _driveApi!.files.create(driveFile, uploadMedia: media);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> fileExists(String remotePath) async {
    if (_driveApi == null) return false;
    try {
      final fileList = await _driveApi!.files.list(
        q: "name = '${p.basename(remotePath)}' and trashed = false",
        $fields: "files(id, name)",
      );
      return fileList.files?.isNotEmpty == true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> deleteFile(String remotePath) async {
    if (_driveApi == null) return false;
    try {
      final fileList = await _driveApi!.files.list(
        q: "name = '${p.basename(remotePath)}' and trashed = false",
        $fields: "files(id, name)",
      );
      final fileId = fileList.files?.firstOrNull?.id;
      if (fileId == null) return false;
      await _driveApi!.files.delete(fileId);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<String?> getRemoteFileHash(String remotePath) async {
    if (_driveApi == null) return null;
    try {
      final fileList = await _driveApi!.files.list(
        q: "name = '${p.basename(remotePath)}' and trashed = false",
        $fields: "files(id, md5Checksum)",
      );
      return fileList.files?.firstOrNull?.md5Checksum;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<String?> getDownloadUrl(String remotePath) async => null;
}

class _AuthenticatedClient extends http.BaseClient {
  final String _token;
  final http.Client _client = http.Client();

  _AuthenticatedClient(this._token);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers['Authorization'] = 'Bearer $_token';
    return _client.send(request);
  }
}
