import '../../providers/translation_provider.dart';

typedef ProviderCreator = TranslationProvider Function();

/// 自发现 & 解耦式 TranslationProvider 注册中心
class TranslationProviderRegistry {
  static final Map<String, ProviderCreator> _creators = {};
  static final Map<String, String> _csvKeys = {};

  /// 动态注册一个 Provider
  /// 
  /// [name]: Provider 唯一标识，如 'Google', 'Bing', 'Papago', 'Youdao'
  /// [creator]: 工厂闭包函数，供 Scheduler 主线程和 Isolate 后台线程创建独立的 Provider 实例
  /// [csvKey]: 对应 LanguageMapper 中的 CSV 语言表键名（默认 'google'）
  static void register(String name, ProviderCreator creator, {String csvKey = 'google'}) {
    _creators[name] = creator;
    _csvKeys[name] = csvKey;
  }

  /// 获取当前已注册的所有 Provider 名称列表
  static List<String> get registeredNames => _creators.keys.toList();

  /// 获取所有已注册 Provider 的 CSV Key 映射表
  static Map<String, String> get csvKeys => Map.unmodifiable(_csvKeys);

  /// 创建所有已注册 Provider 的实例映射表
  static Map<String, TranslationProvider> createAllInstances() {
    final Map<String, TranslationProvider> instances = {};
    _creators.forEach((name, creator) {
      try {
        instances[name] = creator();
      } catch (e) {
        print('[TranslationProviderRegistry] 无法实例化 Provider "$name": $e');
      }
    });
    return instances;
  }

  /// 根据名称动态创建特定 Provider 实例（支持 Isolate 线程池零依赖动态构建）
  static TranslationProvider? createByName(String name) {
    final creator = _creators[name];
    if (creator != null) {
      return creator();
    }
    return null;
  }

  /// 清空注册表（主要用于单元测试隔离）
  static void clear() {
    _creators.clear();
    _csvKeys.clear();
  }
}
