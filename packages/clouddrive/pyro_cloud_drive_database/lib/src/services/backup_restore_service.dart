import 'dart:convert';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';
import 'package:pyro_cloud_drive_hub/pyro_cloud_drive_hub.dart';
import 'package:pyro_cloud_drive_crypto/pyro_cloud_drive_crypto.dart';
import '../models/backup_version_entity.dart';
import '../sync_logic/incremental_sync_manager.dart';

class BackupRestoreService {
  final CloudDriveHub _hub;
  final CloudDriveSecureStorage _secureStorage;

  BackupRestoreService({
    CloudDriveHub? hub,
    CloudDriveSecureStorage? secureStorage,
  })  : _hub = hub ?? CloudDriveHub.instance,
        _secureStorage = secureStorage ?? CloudDriveSecureStorage();

  /// Export and upload a full JSON backup snapshot with optional E2EE encryption.
  /// 路径由 CloudDriveHub 统一合成（格式: {appName}/{accountId}/backups/...）
  Future<BackupVersionEntity> createBackup({
    Type? driverToken,
    required Map<String, dynamic> data,
    required String deviceId,
    required String deviceName,
    String? appName,
    String? accountId,
    String? customFolder,
    bool? encrypt,
  }) async {
    final adapter = _hub.getDriver(driverToken) ?? _hub.currentDriver;
    if (adapter == null) {
      throw StateError('Drive driver is not registered.');
    }

    final timestamp = DateTime.now();
    final backupId = 'backup_${timestamp.millisecondsSinceEpoch}';
    final jsonString = json.encode(data);
    var bytes = Uint8List.fromList(utf8.encode(jsonString));
    final checksum = sha256.convert(bytes).toString();

    final shouldEncrypt = encrypt ?? await _secureStorage.isEncryptionEnabled();
    if (shouldEncrypt) {
      final cipher = await _secureStorage.getActiveCipher();
      if (cipher != null) {
        bytes = cipher.encryptBytes(bytes);
      }
    }

    final folder = customFolder ?? IncrementalSyncManager.computeRemoteFolder(appName: appName, accountId: accountId);
    final cleanFolder = folder.startsWith('/') ? folder.substring(1) : folder;
    final remotePath = '$cleanFolder/backups/$backupId${shouldEncrypt ? '.enc.json' : '.json'}';
    await adapter.writeFile(remotePath, bytes);

    return BackupVersionEntity(
      id: backupId,
      driveType: adapter.driverToken.toString(),
      remotePath: remotePath,
      createdAt: timestamp,
      sizeBytes: bytes.length,
      deviceId: deviceId,
      deviceName: deviceName,
      isEncrypted: shouldEncrypt,
      checksum: checksum,
    );
  }

  /// Download and restore a JSON backup snapshot with automatic decryption.
  Future<Map<String, dynamic>> restoreBackup({
    Type? driverToken,
    required String remotePath,
    bool isEncrypted = false,
  }) async {
    final adapter = _hub.getDriver(driverToken) ?? _hub.currentDriver;
    if (adapter == null) {
      throw StateError('Drive driver is not registered.');
    }

    var bytes = await adapter.readFile(remotePath);

    if (isEncrypted || remotePath.endsWith('.enc.json')) {
      final cipher = await _secureStorage.getActiveCipher();
      if (cipher == null) {
        throw StateError('Encrypted backup detected, but encryption password is not configured.');
      }
      bytes = cipher.decryptBytes(bytes);
    }

    final jsonString = utf8.decode(bytes);
    return json.decode(jsonString) as Map<String, dynamic>;
  }
}
