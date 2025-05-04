import 'dart:convert';
import 'dart:io';


import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';




/// Implementation of the backup encryption service
class BackupEncryptionService {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  bool _isInitialized = false;
  
  // Secure storage keys
  static const String _encryptionEnabledKey = 'backup_encryption_enabled';
  static const String _encryptionKeyKey = 'backup_encryption_key';
  static const String _encryptionIvKey = 'backup_encryption_iv';
  
  // Default values
  bool _encryptionEnabled = false;
  String? _encryptionKey;
  String? _encryptionIv;
  
  Future<void> initialize() async {
    if (_isInitialized) return;
    
    // Load encryption settings from secure storage
    final encryptionEnabledStr = await _secureStorage.read(key: _encryptionEnabledKey);
    _encryptionEnabled = encryptionEnabledStr == 'true';
    
    // Load encryption key and IV if available
    _encryptionKey = await _secureStorage.read(key: _encryptionKeyKey);
    _encryptionIv = await _secureStorage.read(key: _encryptionIvKey);
    
    _isInitialized = true;
  }
  

  Future<bool> isEncryptionEnabled() async {
    await _ensureInitialized();
    return _encryptionEnabled;
  }
  

  Future<void> setEncryptionEnabled(bool enabled) async {
    await _ensureInitialized();
    
    // If enabling encryption and no key exists, generate one
    if (enabled && (_encryptionKey == null || _encryptionIv == null)) {
      await _generateEncryptionKey();
    }
    
    _encryptionEnabled = enabled;
    await _secureStorage.write(key: _encryptionEnabledKey, value: enabled.toString());
  }
  

  Future<void> setEncryptionPassword(String password) async {
    await _ensureInitialized();
    
    // Generate key and IV from password using a simpler approach
    final salt = List<int>.filled(16, 0); // Use a fixed salt for simplicity
    
    // Use HMAC-SHA256 for key derivation
    final keyMaterial = await compute(
      (message) {
        final hmac = Hmac(sha256, message['salt'] as List<int>);
        return hmac.convert(utf8.encode(message['password'] as String)).bytes;
      },
      {'password': password, 'salt': salt},
    );
    
    // Generate a 32-byte key for AES-256
    final keyBytes = Uint8List.fromList(keyMaterial);
    // Use first 16 bytes as IV
    final ivBytes = keyBytes.sublist(0, 16);
    
    // Store the derived key and IV
    _encryptionKey = base64.encode(keyBytes);
    _encryptionIv = base64.encode(ivBytes);
    
    await _secureStorage.write(key: _encryptionKeyKey, value: _encryptionKey);
    await _secureStorage.write(key: _encryptionIvKey, value: _encryptionIv);
    
    // Enable encryption
    if (!_encryptionEnabled) {
      await setEncryptionEnabled(true);
    }
  }
  

  Future<bool> validatePassword(String password) async {
    await _ensureInitialized();
    
    if (_encryptionKey == null || _encryptionIv == null) {
      return false;
    }
    
    // Generate key from password using the same approach as in setEncryptionPassword
    final salt = List<int>.filled(16, 0); // Use the same fixed salt
    
    // Use HMAC-SHA256 for key derivation
    final keyMaterial = await compute(
      (message) {
        final hmac = Hmac(sha256, message['salt'] as List<int>);
        return hmac.convert(utf8.encode(message['password'] as String)).bytes;
      },
      {'password': password, 'salt': salt},
    );
    
    // Generate a 32-byte key for AES-256
    final keyBytes = Uint8List.fromList(keyMaterial);
    final derivedKeyBase64 = base64.encode(keyBytes);
    
    return derivedKeyBase64 == _encryptionKey;
  }
  
  Future<Uint8List> encryptData(Uint8List data) async {
    await _ensureInitialized();
    
    if (!_encryptionEnabled || _encryptionKey == null || _encryptionIv == null) {
      throw Exception('Encryption is not enabled or properly configured');
    }
    
    final keyBytes = base64.decode(_encryptionKey!);
    final ivBytes = base64.decode(_encryptionIv!);
    
    final encrypter = encrypt.Encrypter(encrypt.AES(
      encrypt.Key(keyBytes),
      mode: encrypt.AESMode.cbc,
    ));
    
    final iv = encrypt.IV(ivBytes);
    
    // Add a version byte and checksum for verification during decryption
    final checksumBytes = sha256.convert(data).bytes;
    final versionByte = [1]; // Version 1 of our encryption format
    
    // Combine version, checksum, and data
    final dataWithMetadata = Uint8List.fromList([
      ...versionByte,
      ...checksumBytes.sublist(0, 8), // Use first 8 bytes of checksum
      ...data,
    ]);
    
    // Encrypt the data
    final encrypted = encrypter.encryptBytes(dataWithMetadata, iv: iv);
    
    // Return the encrypted data with IV prepended
    return Uint8List.fromList([...ivBytes, ...encrypted.bytes]);
  }
  

  Future<Uint8List> decryptData(Uint8List encryptedData) async {
    await _ensureInitialized();
    
    if (!_encryptionEnabled || _encryptionKey == null) {
      throw Exception('Encryption is not enabled or properly configured');
    }
    
    final keyBytes = base64.decode(_encryptionKey!);
    
    // Extract IV from the first 16 bytes
    final ivBytes = encryptedData.sublist(0, 16);
    final encryptedBytes = encryptedData.sublist(16);
    
    final encrypter = encrypt.Encrypter(encrypt.AES(
      encrypt.Key(keyBytes),
      mode: encrypt.AESMode.cbc,
    ));
    
    final iv = encrypt.IV(ivBytes);
    
    try {
      // Decrypt the data
      final decryptedWithMetadata = Uint8List.fromList(
        encrypter.decryptBytes(encrypt.Encrypted(encryptedBytes), iv: iv),
      );
      
      // Extract version, checksum and actual data
      final version = decryptedWithMetadata[0];
      if (version != 1) {
        throw Exception('Unsupported encryption version: $version');
      }
      
      final storedChecksum = decryptedWithMetadata.sublist(1, 9);
      final decryptedData = decryptedWithMetadata.sublist(9);
      
      // Verify checksum
      final calculatedChecksumFull = sha256.convert(decryptedData).bytes;
      final calculatedChecksum = calculatedChecksumFull.sublist(0, 8);
      
      for (int i = 0; i < 8; i++) {
        if (storedChecksum[i] != calculatedChecksum[i]) {
          throw Exception('Checksum verification failed. Data may be corrupted or tampered with.');
        }
      }
      
      return decryptedData;
    } catch (e) {
      throw Exception('Failed to decrypt data: ${e.toString()}');
    }
  }
  

  Future<File> encryptFile(File sourceFile, String destinationPath) async {
    final data = await sourceFile.readAsBytes();
    final encryptedData = await encryptData(data);
    
    final destinationFile = File(destinationPath);
    await destinationFile.writeAsBytes(encryptedData);
    
    return destinationFile;
  }
  

  Future<File> decryptFile(File sourceFile, String destinationPath) async {
    final encryptedData = await sourceFile.readAsBytes();
    final decryptedData = await decryptData(encryptedData);
    
    final destinationFile = File(destinationPath);
    await destinationFile.writeAsBytes(decryptedData);
    
    return destinationFile;
  }
  
  Future<void> _ensureInitialized() async {
    if (!_isInitialized) {
      await initialize();
    }
  }
  
  Future<void> _generateEncryptionKey() async {
    // Generate a random encryption key and IV
    final key = encrypt.Key.fromSecureRandom(32);
    final iv = encrypt.IV.fromSecureRandom(16);
    
    _encryptionKey = base64.encode(key.bytes);
    _encryptionIv = base64.encode(iv.bytes);
    
    await _secureStorage.write(key: _encryptionKeyKey, value: _encryptionKey);
    await _secureStorage.write(key: _encryptionIvKey, value: _encryptionIv);
  }
  

  Future<void> clearEncryptionSettings() async {
    await _ensureInitialized();
    
    await _secureStorage.delete(key: _encryptionEnabledKey);
    await _secureStorage.delete(key: _encryptionKeyKey);
    await _secureStorage.delete(key: _encryptionIvKey);
    
    _encryptionEnabled = false;
    _encryptionKey = null;
    _encryptionIv = null;
  }
}