import 'package:call_log/call_log.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TimeBasedInterceptorConfig {
  Duration duration;
  bool shouldIntercept;

  TimeBasedInterceptorConfig({
    this.duration = const Duration(minutes: 30),
    this.shouldIntercept = true,
  });
}

class TimeBasedInterceptor {
  TimeBasedInterceptorConfig _config;

  TimeBasedInterceptor() : _config = TimeBasedInterceptorConfig();

  Future<bool> shouldIntercept(String phoneNumber) async {
    if (!_config.shouldIntercept) {
      return false;
    }
    DateTime now = DateTime.now();
    DateTime from = now.subtract(_config.duration);

    Iterable<CallLogEntry> entries = await CallLog.query(
      dateFrom: from.millisecondsSinceEpoch,
      dateTo: now.millisecondsSinceEpoch,
      number: phoneNumber,
      type: CallType.incoming, // 只查询来电
    );

    return entries.isNotEmpty;
  }

  // 加载配置
  Future<void> loadConfig() async {
    SharedPreferencesAsync asyncPrefs = SharedPreferencesAsync();
    _config.duration =
        Duration(minutes: await asyncPrefs.getInt('interceptorDuration') ?? 30);
    _config.shouldIntercept =
        await asyncPrefs.getBool('shouldIntercept') ?? false;
  }

  // 保存配置
  Future<void> saveConfig() async {
    SharedPreferencesAsync asyncPrefs = SharedPreferencesAsync();
    await asyncPrefs.setInt('interceptorDuration', _config.duration.inMinutes);
    await asyncPrefs.setBool('shouldIntercept', _config.shouldIntercept);
  }

  // 更新配置
  void updateConfig(Duration duration, bool shouldIntercept) {
    _config.duration = duration;
    _config.shouldIntercept = shouldIntercept;
    saveConfig();
  }

  // 更新 duration
  void updateDuration(Duration duration) {
    _config.duration = duration;
    saveConfig();
  }

  // 更新 shouldIntercept
  void updateShouldIntercept(bool shouldIntercept) {
    _config.shouldIntercept = shouldIntercept;
    saveConfig();
  }

  // 获取配置
  TimeBasedInterceptorConfig get config => _config;
}
