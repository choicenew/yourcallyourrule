import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

// 服务类
class Service {
  final String name;
  final Duration defaultInterval;
  const Service(this.name, this.defaultInterval);
}

// 服务名称和默认更新时间间隔的映射
const defaultServices = {
  'SubscriptionModel': Duration(days: 1),
  'SmsSubscriptionModel': Duration(days: 1),
  'ContactSubscription': Duration(days: 1),
  'AutoBackup': Duration(days: 1),
  'PluginUpdate': Duration(days: 7),
  'RecordBackup': Duration(days: 1),
};

// 检查对象是否需要更新
extension ShouldUpdate on dynamic {
  Future<bool> shouldUpdate(String objectName,
      {Duration? updateInterval}) async {
    final SharedPreferencesAsync asyncPrefs = SharedPreferencesAsync();

    // 获取用户自定义的更新间隔（以天为单位），如果没有则使用默认值
    final userIntervalDays =
        await asyncPrefs.getInt('userInterval_$objectName');
    final defaultInterval = defaultServices[objectName] ?? Duration(days: 1);
    final interval = userIntervalDays != null
        ? Duration(days: userIntervalDays)
        : (updateInterval ?? defaultInterval);

    // 获取上次更新时间
    final lastUpdatedString =
        await asyncPrefs.getString('lastUpdated_$objectName');
    final lastUpdated =
        lastUpdatedString != null ? DateTime.parse(lastUpdatedString) : null;

    // 检查是否已超过更新间隔
    final durationSinceLastUpdate =
        DateTime.now().difference(lastUpdated ?? DateTime.now());
    return durationSinceLastUpdate >= interval;
  }

  // 更新服务
  void updateService(String objectName) async {
final SharedPreferencesAsync asyncPrefs = SharedPreferencesAsync();
    await asyncPrefs.setString(
        'lastUpdated_$objectName', DateTime.now().toString());
  }
}

// 设置用户自定义更新间隔（以天为单位）
Future<void> setUserInterval(String objectName, int days) async {
final SharedPreferencesAsync asyncPrefs = SharedPreferencesAsync();
  await asyncPrefs.setInt('userInterval_$objectName', days);
}

// 获取用户自定义更新间隔
Future<Duration> getUserInterval(String objectName) async {
final SharedPreferencesAsync asyncPrefs = SharedPreferencesAsync();
  final userIntervalDays = await  asyncPrefs.getInt('userInterval_$objectName');
  return userIntervalDays != null
      ? Duration(days: userIntervalDays)
      : defaultServices[objectName] ?? Duration(days: 1);
}


