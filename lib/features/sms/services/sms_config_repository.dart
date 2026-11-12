import 'package:yourcallyourrule/features/config/data/repositories/config_repository.dart';

const String _smsLocalNotificationKey = 'config_sms_local_notification';
const String _smsCancelLocalNotificationKey = 'config_sms_cancel_local_notification';

abstract class SmsConfigRepository {
  Future<bool> getUseLocalNotification();
  Future<void> setUseLocalNotification(bool value);

  Future<bool> getCancelLocalNotification();
  Future<void> setCancelLocalNotification(bool value);
}

class SharedPreferencesSmsConfigRepository implements SmsConfigRepository {
  SharedPreferencesSmsConfigRepository(this._configRepository);

  final ConfigRepository _configRepository;

  @override
  Future<bool> getUseLocalNotification() async {
    final config = await _configRepository.getConfig(_smsLocalNotificationKey);
    return config?['value'] as bool? ?? false;
  }

  @override
  Future<void> setUseLocalNotification(bool value) async {
    await _configRepository.saveConfig(_smsLocalNotificationKey, {'value': value});
  }

  @override
  Future<bool> getCancelLocalNotification() async {
    final config = await _configRepository.getConfig(_smsCancelLocalNotificationKey);
    return config?['value'] as bool? ?? false;
  }

  @override
  Future<void> setCancelLocalNotification(bool value) async {
    await _configRepository.saveConfig(_smsCancelLocalNotificationKey, {'value': value});
  }
}
