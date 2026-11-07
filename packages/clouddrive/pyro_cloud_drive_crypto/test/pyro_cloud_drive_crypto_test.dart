import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter_test/flutter_test.dart';
import 'package:pyro_cloud_drive_crypto/pyro_cloud_drive_crypto.dart';

void main() {
  group('PyroCloudDriveCrypto Tests', () {
    test('Key derivation produces consistent 32-byte key and 16-byte IV', () {
      final derived1 = CloudDriveKeyDerivation.deriveKeys('MySecretPassword123');
      final derived2 = CloudDriveKeyDerivation.deriveKeys('MySecretPassword123');

      expect(derived1.keyBytes.length, 32);
      expect(derived1.ivBytes.length, 16);
      expect(derived1.keyBase64, derived2.keyBase64);
      expect(derived1.ivBase64, derived2.ivBase64);
    });

    test('Encrypt and decrypt payload maintains 100% integrity', () {
      final derived = CloudDriveKeyDerivation.deriveKeys('StrongSyncPassword');
      final cipher = CloudDriveCipher(
        keyBytes: derived.keyBytes,
        ivBytes: derived.ivBytes,
      );

      final originalText = '{"version": 1, "tables": {"bookmarks": [{"id": "1", "name": "Manga Chapter"}]}}';
      final originalBytes = Uint8List.fromList(utf8.encode(originalText));

      final encrypted = cipher.encryptBytes(originalBytes);
      expect(encrypted.length, greaterThan(originalBytes.length));

      final decryptedBytes = cipher.decryptBytes(encrypted);
      final decryptedText = utf8.decode(decryptedBytes);

      expect(decryptedText, equals(originalText));
    });

    test('Decryption fails when payload is tampered with', () {
      final derived = CloudDriveKeyDerivation.deriveKeys('SecurityPass');
      final cipher = CloudDriveCipher(
        keyBytes: derived.keyBytes,
        ivBytes: derived.ivBytes,
      );

      final originalBytes = Uint8List.fromList(utf8.encode('Sensitive Backup Data'));
      final encrypted = cipher.encryptBytes(originalBytes);

      // Tamper one byte in the encrypted ciphertext
      encrypted[encrypted.length - 1] ^= 0xFF;

      expect(() => cipher.decryptBytes(encrypted), throwsA(isA<FormatException>()));
    });
  });
}
