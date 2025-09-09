import 'dart:io' show Platform;

import 'package:device_info_plus/device_info_plus.dart';
import 'package:uuid/uuid.dart';
import 'package:yourcallyourrule/data/repositories/config/config_repository.dart';

/// A dedicated service to manage the persistent unique identifier for this device.
/// Its sole responsibility is to provide a stable device ID across app sessions and reinstalls.
class DeviceIdService {
  final ConfigRepository _configRepository;

  static const String _configKey = 'config_device_id';
  static const String _idKey = 'config_id';

  const DeviceIdService(this._configRepository);

  /// Retrieves the persistent unique device ID.
  ///
  /// The logic is as follows:
  /// 1. Check for a value in the config repository.
  /// 2. If not found, generate a new ID based on the platform.
  /// 3. Save the new ID to the config repository.
  Future<String> getDeviceId() async {
    final config = await _configRepository.getConfig(_configKey);
    final deviceId = config?[_idKey] as String?;

    if (deviceId != null && deviceId.isNotEmpty) {
      return deviceId;
    }

    final deviceInfo = DeviceInfoPlugin();
    final String newId;
    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      newId = androidInfo.id;
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      newId = iosInfo.identifierForVendor ?? const Uuid().v4(); // Use const Uuid()
    } else {
      newId = const Uuid().v4();
    }

    await _configRepository.saveConfig(_configKey, {_idKey: newId});
    return newId;
  }
}