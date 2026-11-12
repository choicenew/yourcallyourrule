import 'package:yourcallyourrule/features/config/data/repositories/config_repository.dart';

const String _smsFilterEnabledKey = 'config_sms_filter_enabled';

abstract class SmsFilterConfigRepository {
  Future<bool> getIsEnabled();
  Future<void> setIsEnabled(bool enabled);
}

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
