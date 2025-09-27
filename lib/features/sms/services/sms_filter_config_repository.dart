import 'package:yourcallyourrule/data/repositories/config/config_repository.dart';

const String _smsFilterEnabledKey = 'config_sms_filter_enabled';

/// SMS 过滤器配置仓库的抽象接口
abstract class SmsFilterConfigRepository {
  Future<bool> getIsEnabled();
  Future<void> setIsEnabled(bool enabled);
}

/// SmsFilterConfigRepository 的 SharedPreferences 实现
class SharedPreferencesSmsFilterConfigRepository implements SmsFilterConfigRepository {
  SharedPreferencesSmsFilterConfigRepository(this._configRepository);

  final ConfigRepository _configRepository;

  @override
  Future<bool> getIsEnabled() async {
    final config = await _configRepository.getConfig(_smsFilterEnabledKey);
    return config?['enabled'] as bool? ?? false;
  }

  @override
  Future<void> setIsEnabled(bool enabled) async {
    await _configRepository.saveConfig(_smsFilterEnabledKey, {'enabled': enabled});
  }
}