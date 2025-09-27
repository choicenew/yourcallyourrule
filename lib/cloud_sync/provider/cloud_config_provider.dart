import 'package:flutter_riverpod/flutter_riverpod.dart';

// 1. 定义一个通用的、可复用的 Notifier 类
//    这个类包含了管理配置 Map 的所有逻辑。
class ConfigNotifier extends Notifier<Map<String, String>> {
  @override
  Map<String, String> build() {
    // 初始状态为空 Map
    return {};
  }

  /// 更新 Map 中的一个字段。
  void updateField(String key, String value) {
    // 创建一个新的 Map 副本以确保状态的不变性 (immutability)。
    final newConfig = Map<String, String>.from(state);
    newConfig[key] = value;
    // 更新状态，这将通知所有监听者。
    state = newConfig;
  }
}

// 2. 为每种配置类型创建独立的 provider 实例。
//    它们都使用同一个 Notifier 类，但各自管理着完全独立的状态。

/// Provider for managing WebDAV configuration form state.
final webdavConfigProvider =
    NotifierProvider<ConfigNotifier, Map<String, String>>(
  ConfigNotifier.new,
);

/// Provider for managing OneDrive configuration form state.
final oneDriveConfigProvider =
    NotifierProvider<ConfigNotifier, Map<String, String>>(
  ConfigNotifier.new,
);

/// Provider for managing Google Drive configuration form state.
final googleDriveConfigProvider =
    NotifierProvider<ConfigNotifier, Map<String, String>>(
  ConfigNotifier.new,
);