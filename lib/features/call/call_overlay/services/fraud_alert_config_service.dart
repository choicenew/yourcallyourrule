import 'package:yourcallyourrule/features/config/data/repositories/config_repository.dart';
import 'package:yourcallyourrule/features/call/call_overlay/configuration/fraud_alert_config.dart';

/// 诈骗提醒配置服务
class FraudAlertConfigService {
  static const String _configKey = 'config_fraud_alert';

  static Future<FraudAlertConfig> getConfig() async {
    final configRepository = SharedPreferencesConfigRepository();
    final json = await configRepository.getConfig(_configKey);
    if (json != null) {
      return FraudAlertConfig.fromJson(json);
    }
    return FraudAlertConfig();
  }

  static Future<void> saveConfig(FraudAlertConfig config) async {
    final configRepository = SharedPreferencesConfigRepository();
    await configRepository.saveConfig(_configKey, config.toJson());
  }
}
