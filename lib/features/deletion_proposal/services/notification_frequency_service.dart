import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yourcallyourrule/core/provider/providers/config_repository_provider.dart';
import 'package:yourcallyourrule/data/repositories/config/config_repository.dart';

part 'notification_frequency_service.g.dart';

@riverpod
NotificationFrequencyService notificationFrequencyService(Ref ref) {
  return NotificationFrequencyService(ref.watch(configRepositoryProvider));
}

class NotificationFrequencyService {
  NotificationFrequencyService(this._configRepository);

  final ConfigRepository _configRepository;

  static const _configKey = 'config_notification_frequency';
  static const _lastShownTimestampKey = 'last_shown_timestamp';
  static const _frequencyHoursKey = 'frequency_hours';

  Future<void> setNotificationFrequency(int hours) async {
    final config = await _configRepository.getConfig(_configKey) ?? {};
    config[_frequencyHoursKey] = hours;
    await _configRepository.saveConfig(_configKey, config);
  }

  Future<int> getNotificationFrequency() async {
    final config = await _configRepository.getConfig(_configKey);
    return config?[_frequencyHoursKey] as int? ?? 24; // Default to 24 hours
  }

  Future<void> recordNotificationShown() async {
    final config = await _configRepository.getConfig(_configKey) ?? {};
    config[_lastShownTimestampKey] = DateTime.now().millisecondsSinceEpoch;
    await _configRepository.saveConfig(_configKey, config);
  }

  Future<bool> canShowNotification() async {
    final config = await _configRepository.getConfig(_configKey);
    final lastShown = config?[_lastShownTimestampKey] as int?;
    if (lastShown == null) {
      return true;
    }
    final frequency = await getNotificationFrequency();
    final nextShowTime = DateTime.fromMillisecondsSinceEpoch(lastShown).add(Duration(hours: frequency));
    return DateTime.now().isAfter(nextShowTime);
  }
}