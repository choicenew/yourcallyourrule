import 'dart:io';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:pyro_worker_protocol/pyro_worker_protocol.dart';

/// CloudDrive dedicated AES-256-CBC cipher with versioning and SHA256 checksum verification.
class CloudDriveCipher {
  final Uint8List keyBytes;
  final Uint8List ivBytes;
  final encrypt.Encrypter _encrypter;

  CloudDriveCipher({required this.keyBytes, required this.ivBytes})
      : _encrypter = encrypt.Encrypter(encrypt.AES(
          encrypt.Key(keyBytes),
          mode: encrypt.AESMode.cbc,
        ));

  /// Encrypt raw byte payload into [IV(16B) + Encrypted(Version(1B) + Checksum(8B) + Data)].
  Uint8List encryptBytes(Uint8List data) {
    final iv = encrypt.IV(ivBytes);
    final checksumBytes = sha256.convert(data).bytes;
    final versionByte = [1]; // Version 1 format

    final payloadWithMetadata = Uint8List.fromList([
      ...versionByte,
      ...checksumBytes.sublist(0, 8),
      ...data,
    ]);

    final encrypted = _encrypter.encryptBytes(payloadWithMetadata, iv: iv);
    return Uint8List.fromList([...ivBytes, ...encrypted.bytes]);
  }

  /// Decrypt byte payload, verify Version header and SHA256 8-byte checksum.
  Uint8List decryptBytes(Uint8List encryptedPayload) {
    if (encryptedPayload.length < 16 + 9) {
      throw const FormatException('Encrypted payload too short to be valid CloudDrive encrypted data.');
    }

    final payloadIv = encryptedPayload.sublist(0, 16);
    final encryptedData = encryptedPayload.sublist(16);
    final iv = encrypt.IV(payloadIv);

    try {
      final decryptedWithMetadata = Uint8List.fromList(
        _encrypter.decryptBytes(encrypt.Encrypted(encryptedData), iv: iv),
      );

      final version = decryptedWithMetadata[0];
      if (version != 1) {
        throw FormatException('Unsupported CloudDrive encryption format version: $version');
      }

      final storedChecksum = decryptedWithMetadata.sublist(1, 9);
      final actualData = decryptedWithMetadata.sublist(9);

      final computedChecksum = sha256.convert(actualData).bytes.sublist(0, 8);
      for (int i = 0; i < 8; i++) {
        if (storedChecksum[i] != computedChecksum[i]) {
          throw const FormatException('Checksum verification failed! CloudDrive payload is corrupted or tampered with.');
        }
      }

      return actualData;
    } catch (e) {
      if (e is FormatException) rethrow;
      throw FormatException('Failed to decrypt CloudDrive payload: $e');
    }
  }

  /// 异步在副线程中执行加密，彻底解放 UI 线程
  Future<Uint8List> encryptBytesAsync(Uint8List data) async {
    return await WorkerDispatcher.instance.execute(
      _EncryptBytesTask(),
      _CryptoTaskPayload(data: data, keyBytes: keyBytes, ivBytes: ivBytes),
    );
  }

  /// 异步在副线程中执行解密，彻底解放 UI 线程
  Future<Uint8List> decryptBytesAsync(Uint8List encryptedPayload) async {
    return await WorkerDispatcher.instance.execute(
      _DecryptBytesTask(),
      _CryptoTaskPayload(data: encryptedPayload, keyBytes: keyBytes, ivBytes: ivBytes),
    );
  }

  /// Encrypt a local file and write to [destinationPath] in worker isolate.
  Future<File> encryptFile(File sourceFile, String destinationPath) async {
    final bytes = await sourceFile.readAsBytes();
    final encrypted = await encryptBytesAsync(bytes);
    final dest = File(destinationPath);
    await dest.writeAsBytes(encrypted, flush: true);
    return dest;
  }

  /// Decrypt a local file and write to [destinationPath] in worker isolate.
  Future<File> decryptFile(File sourceFile, String destinationPath) async {
    final bytes = await sourceFile.readAsBytes();
    final decrypted = await decryptBytesAsync(bytes);
    final dest = File(destinationPath);
    await dest.writeAsBytes(decrypted, flush: true);
    return dest;
  }
}

class _CryptoTaskPayload {
  final Uint8List data;
  final Uint8List keyBytes;
  final Uint8List ivBytes;
  _CryptoTaskPayload({required this.data, required this.keyBytes, required this.ivBytes});
}

class _EncryptBytesTask extends WorkerTask<_CryptoTaskPayload, Uint8List> {
  _EncryptBytesTask() : super(taskName: 'EncryptBytesTask', priority: TaskPriority.background);

  @override
  Uint8List execute(_CryptoTaskPayload input) {
    final cipher = CloudDriveCipher(keyBytes: input.keyBytes, ivBytes: input.ivBytes);
    return cipher.encryptBytes(input.data);
  }
}

class _DecryptBytesTask extends WorkerTask<_CryptoTaskPayload, Uint8List> {
  _DecryptBytesTask() : super(taskName: 'DecryptBytesTask', priority: TaskPriority.background);

  @override
  Uint8List execute(_CryptoTaskPayload input) {
    final cipher = CloudDriveCipher(keyBytes: input.keyBytes, ivBytes: input.ivBytes);
    return cipher.decryptBytes(input.data);
  }
}
