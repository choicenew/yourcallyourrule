import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'cloud_drive_cipher.dart';
import 'cloud_drive_key_derivation.dart';

/// Manages CloudDrive master encryption password, keys, and credentials securely.
class CloudDriveSecureStorage {
  final FlutterSecureStorage _storage;

  static const String _encryptionEnabledKey = 'cloud_drive_encryption_enabled';
  static const String _encryptionKeyKey = 'cloud_drive_encryption_key';
  static const String _encryptionIvKey = 'cloud_drive_encryption_iv';

  CloudDriveSecureStorage({FlutterSecureStorage? storage})
      : _storage = storage ?? const FlutterSecureStorage();

  Future<bool> isEncryptionEnabled() async {
    final val = await _storage.read(key: _encryptionEnabledKey);
    return val == 'true';
  }

  Future<void> setEncryptionEnabled(bool enabled) async {
    await _storage.write(key: _encryptionEnabledKey, value: enabled.toString());
  }

  Future<void> setEncryptionPassword(String password) async {
    final derived = CloudDriveKeyDerivation.deriveKeys(password);
    await _storage.write(key: _encryptionKeyKey, value: derived.keyBase64);
    await _storage.write(key: _encryptionIvKey, value: derived.ivBase64);
    await setEncryptionEnabled(true);
  }

  Future<bool> validatePassword(String password) async {
    final storedKey = await _storage.read(key: _encryptionKeyKey);
    if (storedKey == null) return false;
    final derived = CloudDriveKeyDerivation.deriveKeys(password);
    return derived.keyBase64 == storedKey;
  }

  Future<CloudDriveCipher?> getActiveCipher() async {
    final enabled = await isEncryptionEnabled();
    if (!enabled) return null;
    final keyB64 = await _storage.read(key: _encryptionKeyKey);
    final ivB64 = await _storage.read(key: _encryptionIvKey);
    if (keyB64 == null || ivB64 == null) return null;

    return CloudDriveCipher(
      keyBytes: Uint8List.fromList(base64.decode(keyB64)),
      ivBytes: Uint8List.fromList(base64.decode(ivB64)),
    );
  }

  Future<void> clearEncryptionSettings() async {
    await _storage.delete(key: _encryptionEnabledKey);
    await _storage.delete(key: _encryptionKeyKey);
    await _storage.delete(key: _encryptionIvKey);
  }
}
