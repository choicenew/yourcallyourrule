import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/setup_config.dart';
import '../services/initial_setup_service.dart';

// 注意：这里的 URL 是一个占位符。未来可以通过环境变量或 Remote Config 注入。
// 目前使用一个占位地址，你可以随时在云端部署该 json。
const _defaultConfigUrl = 'https://raw.githubusercontent.com/your-org/your-repo/main/app_setup_config.json';

/// 服务提供者
final initialSetupServiceProvider = Provider<InitialSetupService>((ref) {
  // TODO: 后期可替换为动态读取环境变量的 URL
  return InitialSetupService(_defaultConfigUrl);
});

/// 状态提供者，管理拉取配置的异步状态
final setupConfigProvider = FutureProvider.autoDispose<SetupConfig>((ref) async {
  final service = ref.watch(initialSetupServiceProvider);
  return await service.fetchConfig();
});
