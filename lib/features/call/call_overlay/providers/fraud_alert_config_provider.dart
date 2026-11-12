import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yourcallyourrule/features/call/call_overlay/configuration/fraud_alert_config.dart';
import 'package:yourcallyourrule/features/call/call_overlay/services/fraud_alert_config_service.dart';

part 'fraud_alert_config_provider.g.dart';

@riverpod
class FraudAlertConfigNotifier extends _$FraudAlertConfigNotifier {
  @override
  Future<FraudAlertConfig> build() async {
    return await FraudAlertConfigService.getConfig();
  }

  Future<void> updateConfig(FraudAlertConfig newConfig) async {
    await FraudAlertConfigService.saveConfig(newConfig);
    state = AsyncValue.data(newConfig);
  }
}
