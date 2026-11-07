import 'dart:isolate';

import 'core/dispatch/provider_registry.dart';
import 'core/dispatch/scheduler.dart';
import 'models/translation_config.dart';
import 'providers/builtin_providers.dart';
import 'providers/translation_provider.dart';
import 'utils/language_mapper.dart';

class TranslationService {
  static final TranslationService instance = TranslationService();

  final TranslationConfig config;

  // Active instances loaded from registry
  final Map<String, TranslationProvider> _providers = {};

  // The Scheduler handles concurrent dispatch and pool management
  late final TranslationScheduler _scheduler;

  TranslationService({this.config = const TranslationConfig()}) {
    // 自动触发注册所有系统内置 Provider
    registerBuiltinProviders();

    // 动态从注册表解耦加载所有 Provider 实例及语言 CSV Key 映射
    _providers.addAll(TranslationProviderRegistry.createAllInstances());
    final csvKeys = TranslationProviderRegistry.csvKeys;

    // 初始化并发调度与熔断网格
    _scheduler = TranslationScheduler(_providers, csvKeys);
  }

  /// 动态工厂：专门供 Isolate 独立后台线程创建 Provider 实例（零耦合）
  static TranslationProvider createProviderByName(String name) {
    registerBuiltinProviders();
    final provider = TranslationProviderRegistry.createByName(name);
    return provider ?? TranslationProviderRegistry.createByName('Google')!;
  }

  /// Returns a list of available provider names dynamically discovered from registry.
  List<String> get availableProviders => _providers.keys.toList();

  /// Returns all supported target languages dynamically extracted from database.
  Future<List<SupportedLanguage>> getSupportedLanguages() async {
    await LanguageMapper.ensureInitialized();
    return LanguageMapper.getSupportedLanguages();
  }

  /// Gets the human-readable display name for a language code (e.g., 'zh' -> '中文').
  String getLanguageName(String code) {
    return LanguageMapper.getLanguageName(code);
  }

  /// Translates text.
  ///
  /// [targetLanguage] is required.
  /// [sourceLanguage] defaults to 'auto'.
  /// [useProvider] optional. If specified, forces usage of that specific provider.
  Future<String> translate(String text,
      {required String targetLanguage,
      String sourceLanguage = 'auto',
      String? useProvider}) async {
    await LanguageMapper.ensureInitialized();

    // 1. Manual Selection Mode
    if (useProvider != null) {
      if (_providers.containsKey(useProvider)) {
        try {
          final csvKey = TranslationProviderRegistry.csvKeys[useProvider] ?? 'google';
          final mappedTarget = LanguageMapper.getCode(csvKey, targetLanguage);
          final mappedSource = sourceLanguage == 'auto'
              ? 'auto'
              : LanguageMapper.getCode(csvKey, sourceLanguage);

          print(
              'Using specific provider in Isolate: $useProvider ($targetLanguage->$mappedTarget)');

          final providerName = useProvider;
          return await Isolate.run(() async {
            final provider = createProviderByName(providerName);
            return await provider.translate(text,
                targetLanguage: mappedTarget, sourceLanguage: mappedSource);
          });
        } catch (e) {
          throw Exception('Provider $useProvider failed: $e');
        }
      } else {
        throw Exception(
            'Provider $useProvider not found. Available: ${availableProviders.join(", ")}');
      }
    }

    // 2. Auto / Fallback Mode (Managed by Scheduler)
    return _scheduler.schedule(text,
        sourceLanguage: sourceLanguage, targetLanguage: targetLanguage);
  }
}
