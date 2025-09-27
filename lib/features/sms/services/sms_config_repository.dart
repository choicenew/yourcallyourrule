import 'package:yourcallyourrule/data/repositories/config/config_repository.dart';

// 定义 SMS 配置的键名
const String _smsLocalNotificationKey = 'config_sms_local_notification';
const String _smsCancelLocalNotificationKey = 'config_sms_cancel_local_notification';

/// SMS 配置仓库的抽象接口
/// 封装了与 SMS 功能相关的配置的读取和写入逻辑。
abstract class SmsConfigRepository {
  Future<bool> getUseLocalNotification();
  Future<void> setUseLocalNotification(bool value);

  Future<bool> getCancelLocalNotification();
  Future<void> setCancelLocalNotification(bool value);
}

/// SmsConfigRepository 的 SharedPreferences 实现
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