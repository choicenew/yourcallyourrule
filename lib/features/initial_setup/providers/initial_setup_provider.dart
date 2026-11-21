import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/setup_config.dart';
import 'package:yourcallyourrule/features/initial_setup/services/initial_setup_service.dart';

part 'initial_setup_provider.g.dart';

/// 基础服务提供者
@Riverpod(keepAlive: true)
InitialSetupService initialSetupService(Ref ref) {
  return InitialSetupService();
}

/// CDN 切换状态 Notifier
@Riverpod(keepAlive: true)
class SetupUseCdnNotifier extends _$SetupUseCdnNotifier {
  @override
  bool build() => false;

  void setUseCdn(bool value) => state = value;
}

/// 自定义 URL 状态 Notifier
@Riverpod(keepAlive: true)
class SetupCustomUrlNotifier extends _$SetupCustomUrlNotifier {
  @override
  String? build() => null;

  void setCustomUrl(String? url) => state = url;
}

/// 切换全量规则配置 (app_delta_setup_config.json) 与 插件配置 (app_plugin_setup_config.json)
@Riverpod(keepAlive: true)
class SetupIsPluginConfigNotifier extends _$SetupIsPluginConfigNotifier {
  @override
  bool build() => false;

  void setIsPluginConfig(bool value) => state = value;
  void toggle() => state = !state;
}

/// 核心配置 AsyncNotifier/FutureProvider
@riverpod
Future<SetupConfig> setupConfig(Ref ref) async {
  final service = ref.watch(initialSetupServiceProvider);
  final useCdn = ref.watch(setupUseCdnProvider);
  final customUrl = ref.watch(setupCustomUrlProvider);
  final isPluginConfig = ref.watch(setupIsPluginConfigProvider);
  return await service.fetchConfig(
    useCdn: useCdn,
    customUrl: customUrl,
    isPluginConfig: isPluginConfig,
  );
}

/// 自动检测用户国家/地区代码
@riverpod
Future<String?> detectedCountryCode(Ref ref) async {
  final service = ref.watch(initialSetupServiceProvider);
  return await service.detectUserCountry();
}
