import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static const urlKey = 'webdav_url';
  static const usernameKey = 'webdav_username';
  static const passwordKey = 'webdav_password';

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<String?> read(String key) async {
    try {
      final value = await _storage.read(key: key);
      return value;
    } catch (e) {
      // print('Error reading from secure storage: $e');
      return null;
    }
  }

  Future<void> write(String key, String value) async {
    try {
      await _storage.write(key: key, value: value);
    } catch (e) {
      //print('Error writing to secure storage: $e');
    }
  }
}
