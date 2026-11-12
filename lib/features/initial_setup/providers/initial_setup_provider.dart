import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/setup_config.dart';
import 'package:yourcallyourrule/features/initial_setup/services/initial_setup_service.dart';

/// 基础服务提供者
final initialSetupServiceProvider = Provider<InitialSetupService>((ref) {
  return InitialSetupService();
});

/// CDN 切换状态 Notifier
class SetupUseCdnNotifier extends Notifier<bool> {
  @override
  bool build() => false;

  void setUseCdn(bool value) => state = value;
}

final setupUseCdnProvider = NotifierProvider<SetupUseCdnNotifier, bool>(SetupUseCdnNotifier.new);

/// 自定义 URL 状态 Notifier
class SetupCustomUrlNotifier extends Notifier<String?> {
  @override
  String? build() => null;

  void setCustomUrl(String? url) => state = url;
}

final setupCustomUrlProvider = NotifierProvider<SetupCustomUrlNotifier, String?>(SetupCustomUrlNotifier.new);

/// 切换全量规则配置 (app_delta_setup_config.json) 与 插件配置 (app_plugin_setup_config.json)
class SetupIsPluginConfigNotifier extends Notifier<bool> {
  @override
  bool build() => false;

  void setIsPluginConfig(bool value) => state = value;
  void toggle() => state = !state;
}

final setupIsPluginConfigProvider =
    NotifierProvider<SetupIsPluginConfigNotifier, bool>(SetupIsPluginConfigNotifier.new);

/// 核心配置 AsyncNotifier/FutureProvider，当 CDN、CustomURL 或 配置类型改变时自动响应式重新请求并刷新
final setupConfigProvider = FutureProvider.autoDispose<SetupConfig>((ref) async {
  final service = ref.watch(initialSetupServiceProvider);
  final useCdn = ref.watch(setupUseCdnProvider);
  final customUrl = ref.watch(setupCustomUrlProvider);
  final isPluginConfig = ref.watch(setupIsPluginConfigProvider);
  return await service.fetchConfig(
    useCdn: useCdn,
    customUrl: customUrl,
    isPluginConfig: isPluginConfig,
  );
});

/// 自动检测用户国家/地区代码
final detectedCountryCodeProvider = FutureProvider.autoDispose<String?>((ref) async {
  final service = ref.watch(initialSetupServiceProvider);
  return await service.detectUserCountry();
});
