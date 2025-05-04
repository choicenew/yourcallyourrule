import 'dart:convert';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// 备份加密服务接口
abstract class BackupEncryptionService {
  /// 初始化加密服务
  Future<void> initialize();
  
  /// 检查加密是否已启用
  Future<bool> isEncryptionEnabled();
  
  /// 启用或禁用加密
  Future<void> setEncryptionEnabled(bool enabled);
  
  /// 设置加密密码
  Future<void> setEncryptionPassword(String password);
  
  /// 验证加密密码
  Future<bool> validateEncryptionPassword(String password);
  
  /// 清除加密设置
  Future<void> clearEncryptionSettings();
  
  /// 加密数据
  Future<Uint8List> encryptData(Uint8List data);
  
  /// 解密数据
  Future<Uint8List> decryptData(Uint8List encryptedData);
  
  /// 加密字符串
  Future<String> encryptString(String plainText);
  
  /// 解密字符串
  Future<String> decryptString(String encryptedText);
  
  /// 加密JSON数据
  Future<String> encryptJson(Map<String, dynamic> json);
  
  /// 解密JSON数据
  Future<Map<String, dynamic>> decryptJson(String encryptedJson);
}

/// 备份加密服务实现
class BackupEncryptionServiceImpl implements BackupEncryptionService {
  static const String _encryptionEnabledKey = 'backup_encryption_enabled';
  static const String _encryptionKeyKey = 'backup_encryption_key';
  static const String _encryptionIvKey = 'backup_encryption_iv';
  
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  
  bool _isInitialized = false;
  bool _encryptionEnabled = false;
  encrypt.Key? _encryptionKey;
  encrypt.IV? _encryptionIv;
  
  @override
  Future<void> initialize() async {
    if (_isInitialized) return;
    
    // 检查加密是否已启用
    final encryptionEnabledStr = await _secureStorage.read(key: _encryptionEnabledKey);
    _encryptionEnabled = encryptionEnabledStr == 'true';
    
    if (_encryptionEnabled) {
      // 读取加密密钥和IV
      final keyStr = await _secureStorage.read(key: _encryptionKeyKey);
      final ivStr = await _secureStorage.read(key: _encryptionIvKey);
      
      if (keyStr != null && ivStr != null) {
        _encryptionKey = encrypt.Key.fromBase64(keyStr);
        _encryptionIv = encrypt.IV.fromBase64(ivStr);
      } else {
        // 如果密钥或IV不存在，禁用加密
        await setEncryptionEnabled(false);
      }
    }
    
    _isInitialized = true;
  }
  
  @override
  Future<bool> isEncryptionEnabled() async {
    if (!_isInitialized) await initialize();
    return _encryptionEnabled;
  }
  
  @override
  Future<void> setEncryptionEnabled(bool enabled) async {
    if (!_isInitialized) await initialize();
    
    _encryptionEnabled = enabled;
    await _secureStorage.write(key: _encryptionEnabledKey, value: enabled.toString());
    
    if (!enabled) {
      // 如果禁用加密，清除密钥和IV
      await clearEncryptionSettings();
    }
  }
  
  @override
  Future<void> setEncryptionPassword(String password) async {
    if (!_isInitialized) await initialize();
    
    // 从密码生成密钥和IV
    final passwordBytes = utf8.encode(password);
    // 使用PBKDF2密钥派生算法
    final key = await Pbkdf2(
      iterations: 10000,
      blockLength: 32,
      derivedKeyLength: 32
    ).deriveFromPassword(
      password: password,
      salt: utf8.encode('yourcallyourrule_salt')
    );
    final keyBytes = key.bytes;
    
    // 使用密码的前16个字节作为IV
    // 生成随机IV
    final ivBytes = encrypt.IV.fromSecureRandom(16).bytes;
    
    // 创建加密密钥和IV
    _encryptionKey = encrypt.Key(Uint8List.fromList(keyBytes));
    _encryptionIv = encrypt.IV(Uint8List.fromList(ivBytes));
    
    // 保存密钥和IV
    await _secureStorage.write(key: _encryptionKeyKey, value: _encryptionKey!.base64);
    await _secureStorage.write(key: _encryptionIvKey, value: _encryptionIv!.base64);
    
    // 启用加密
    await setEncryptionEnabled(true);
  }
  
  @override
  Future<bool> validateEncryptionPassword(String password) async {
    if (!_isInitialized) await initialize();
    
    if (!_encryptionEnabled) return false;
    
    // 从密码生成密钥和IV
    final passwordBytes = utf8.encode(password);
    // 使用PBKDF2密钥派生算法
    final key = await Pbkdf2(
      iterations: 10000,
      blockLength: 32,
      derivedKeyLength: 32
    ).deriveFromPassword(
      password: password,
      salt: utf8.encode('yourcallyourrule_salt')
    );
    final keyBytes = key.bytes;
    
    // 使用密码的前16个字节作为IV
    // 生成随机IV
    final ivBytes = encrypt.IV.fromSecureRandom(16).bytes;
    
    // 创建加密密钥和IV
    final testKey = encrypt.Key(Uint8List.fromList(keyBytes));
    final testIv = encrypt.IV(Uint8List.fromList(ivBytes));
    
    // 比较密钥和IV
    return testKey.base64 == _encryptionKey?.base64 && testIv.base64 == _encryptionIv?.base64;
  }
  
  @override
  Future<void> clearEncryptionSettings() async {
    if (!_isInitialized) await initialize();
    
    _encryptionKey = null;
    _encryptionIv = null;
    
    await _secureStorage.delete(key: _encryptionKeyKey);
    await _secureStorage.delete(key: _encryptionIvKey);
    await _secureStorage.write(key: _encryptionEnabledKey, value: 'false');
    
    _encryptionEnabled = false;
  }
  
  @override
  Future<Uint8List> encryptData(Uint8List data) async {
    if (!_isInitialized) await initialize();
    
    if (!_encryptionEnabled || _encryptionKey == null || _encryptionIv == null) {
      // 如果加密未启用，返回原始数据
      return data;
    }
    
    final encrypter = encrypt.Encrypter(encrypt.AES(_encryptionKey!, mode: encrypt.AESMode.cbc));
    final encrypted = encrypter.encryptBytes(data, iv: _encryptionIv!);
    
    return Uint8List.fromList(encrypted.bytes);
  }
  
  @override
  Future<Uint8List> decryptData(Uint8List encryptedData) async {
    if (!_isInitialized) await initialize();
    
    if (!_encryptionEnabled || _encryptionKey == null || _encryptionIv == null) {
      // 如果加密未启用，返回原始数据
      return encryptedData;
    }
    
    final encrypter = encrypt.Encrypter(encrypt.AES(_encryptionKey!, mode: encrypt.AESMode.cbc));
    final decrypted = encrypter.decryptBytes(
      encrypt.Encrypted(encryptedData),
      iv: _encryptionIv!,
    );
    
    return Uint8List.fromList(decrypted);
  }
  
  @override
  Future<String> encryptString(String plainText) async {
    if (!_isInitialized) await initialize();
    
    if (!_encryptionEnabled || _encryptionKey == null || _encryptionIv == null) {
      // 如果加密未启用，返回原始文本
      return plainText;
    }
    
    final encrypter = encrypt.Encrypter(encrypt.AES(_encryptionKey!, mode: encrypt.AESMode.cbc));
    final encrypted = encrypter.encrypt(plainText, iv: _encryptionIv!);
    
    return encrypted.base64;
  }
  
  @override
  Future<String> decryptString(String encryptedText) async {
    if (!_isInitialized) await initialize();
    
    if (!_encryptionEnabled || _encryptionKey == null || _encryptionIv == null) {
      // 如果加密未启用，返回原始文本
      return encryptedText;
    }
    
    try {
      final encrypter = encrypt.Encrypter(encrypt.AES(_encryptionKey!, mode: encrypt.AESMode.cbc));
      final decrypted = encrypter.decrypt(
        encrypt.Encrypted.fromBase64(encryptedText),
        iv: _encryptionIv!,
      );
      
      return decrypted;
    } catch (e) {
      // 解密失败，返回原始文本
      return encryptedText;
    }
  }
  
  @override
  Future<String> encryptJson(Map<String, dynamic> json) async {
    final jsonString = jsonEncode(json);
    return await encryptString(jsonString);
  }
  
  @override
  Future<Map<String, dynamic>> decryptJson(String encryptedJson) async {
    try {
      final jsonString = await decryptString(encryptedJson);
      return jsonDecode(jsonString) as Map<String, dynamic>;
    } catch (e) {
      // 解密或解析失败，返回空Map
      return {};
    }
  }
}