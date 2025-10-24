// lib/features/call/caller_id/providers/fraud_alert_config_provider.dart

import 'package:riverpod_annotation/riverpod_annotation.dart';
// 【重要】: 确保这里导入的是我们的数据模型
import 'package:yourcallyourrule/features/call/caller_id/configuration/fraud_alert_config.dart';
import 'package:yourcallyourrule/features/call/caller_id/services/fraud_alert_config_service.dart';

part 'fraud_alert_config_provider.g.dart';

// 【核心修正】: 将 Notifier 类重命名为 FraudAlertConfigNotifier
// 这样它就不会和我们的数据模型 FraudAlertConfig 类冲突了
@riverpod
class FraudAlertConfigNotifier extends _$FraudAlertConfigNotifier {
  
  // build 方法的返回类型现在明确是我们的数据模型
  @override
  Future<FraudAlertConfig> build() async {
    return FraudAlertConfigService.getConfig();
  }

  // updateConfig 方法的参数类型也明确是我们的数据模型
  Future<void> updateConfig(FraudAlertConfig newConfig) async {
    state = const AsyncValue.loading();
    try {
      // 现在 newConfig 的类型和 saveConfig 方法期望的参数类型完全匹配！
      await FraudAlertConfigService.saveConfig(newConfig);
      state = AsyncValue.data(newConfig);
    } catch (e, s) {
      state = AsyncValue.error(e, s);
    }
  }
}