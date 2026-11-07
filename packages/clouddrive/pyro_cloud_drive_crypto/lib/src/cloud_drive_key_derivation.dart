import 'dart:convert';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';

/// Key derivation logic for CloudDrive master passwords.
class CloudDriveKeyDerivation {
  static const List<int> defaultSalt = [
    0x50, 0x79, 0x72, 0x6f, 0x43, 0x6c, 0x6f, 0x75,
    0x64, 0x44, 0x72, 0x69, 0x76, 0x65, 0x32, 0x36
  ]; // "PyroCloudDrive26"

  /// Derive a 32-byte AES key and 16-byte IV from a user password.
  static DerivedKeys deriveKeys(String password, {List<int>? salt}) {
    final activeSalt = salt ?? defaultSalt;
    final hmac = Hmac(sha256, activeSalt);
    final keyMaterial = hmac.convert(utf8.encode(password)).bytes;
    final keyBytes = Uint8List.fromList(keyMaterial);
    final ivBytes = keyBytes.sublist(0, 16);

    return DerivedKeys(
      keyBytes: keyBytes,
      ivBytes: ivBytes,
      keyBase64: base64.encode(keyBytes),
      ivBase64: base64.encode(ivBytes),
    );
  }
}

class DerivedKeys {
  final Uint8List keyBytes;
  final Uint8List ivBytes;
  final String keyBase64;
  final String ivBase64;

  const DerivedKeys({
    required this.keyBytes,
    required this.ivBytes,
    required this.keyBase64,
    required this.ivBase64,
  });
}
