// 【核心修正】: 不再需要导入 Riverpod
// import 'package:riverpod_annotation/riverpod_annotation.dart';
// import 'package:yourcallyourrule/core/provider/providers/config_repository_provider.dart';

// 导入底层仓库的实现
import 'package:yourcallyourrule/data/repositories/config/config_repository.dart';
// 导入配置模型
import 'package:yourcallyourrule/features/call/caller_id/configuration/fraud_alert_config.dart';

// 【核心修正】: 移除所有 @Riverpod 注解和 part 文件指令

/// 诈骗提醒配置服务
/// 【最终方案】: 这是一个纯粹的服务类，提供静态方法来读写配置。
/// 它不依赖 Riverpod，可以在应用的任何地方被直接调用。
class FraudAlertConfigService {
  // 定义用于持久化存储的唯一键
  static const String _configKey = 'config_fraud_alert';

  // 【最终方案】: getConfig 方法变为静态方法。
  // 它在内部手动创建它所需要的依赖（ConfigRepository）。
  static Future<FraudAlertConfig> getConfig() async {
    // 直接创建底层的仓库实例
    final configRepository = SharedPreferencesConfigRepository();
    final json = await configRepository.getConfig(_configKey);
    if (json != null) {
      return FraudAlertConfig.fromJson(json);
    }
    // 如果没有保存的配置，返回默认配置
    return FraudAlertConfig();
  }

  // 【最终方案】: saveConfig 方法也变为静态方法。
  static Future<void> saveConfig(FraudAlertConfig config) async {
    final configRepository = SharedPreferencesConfigRepository();
    await configRepository.saveConfig(_configKey, config.toJson());
  }
}