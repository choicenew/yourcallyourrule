import 'package:yourcallyourrule/data/repositories/config/config_repository.dart';

class FraudAlertConfig {
  bool isEnabled;
  bool isVibrationEnabled;

  FraudAlertConfig({
    this.isEnabled = true,
    this.isVibrationEnabled = true,
  });

  factory FraudAlertConfig.fromJson(Map<String, dynamic> json) {
    return FraudAlertConfig(
      isEnabled: json['isEnabled'] as bool? ?? true,
      isVibrationEnabled: json['isVibrationEnabled'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isEnabled': isEnabled,
      'isVibrationEnabled': isVibrationEnabled,
    };
  }
}

class FraudAlertConfigService {
  final ConfigRepository _configRepository;
  static const String _configKey = 'config_fraud_alert';

  FraudAlertConfigService(this._configRepository);

  Future<FraudAlertConfig> getConfig() async {
    final json = await _configRepository.getConfig(_configKey);
    if (json != null) {
      return FraudAlertConfig.fromJson(json);
    }
    return FraudAlertConfig();
  }

  Future<void> saveConfig(FraudAlertConfig config) async {
    await _configRepository.saveConfig(_configKey, config.toJson());
  }
}