import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:pyro_translation_cache/pyro_translation_cache.dart';
import 'edge_ai_translator.dart';
import 'online_api_translator.dart';
import 'translation_policy.dart';

/// 专职翻译策略决策与降级调度引擎
/// 负责依据 [TranslationPolicy] 智能调配端侧 AI 大模型离线翻译与多渠道在线 API 翻译，并集成双级持久化缓存。
class PyroTranslationPolicyEngine {
  static final PyroTranslationPolicyEngine instance = PyroTranslationPolicyEngine._();

  final PyroTranslationCacheEngine _cacheEngine =
      PyroTranslationCacheEngine.instance;

  final EdgeAiTranslator edgeAiTranslator = EdgeAiTranslator();
  final OnlineApiTranslator onlineApiTranslator = OnlineApiTranslator();

  TranslationPolicy _policy = TranslationPolicy.smartAuto;
  String? _forcedProvider;
  String? _defaultTargetLang;

  PyroTranslationPolicyEngine._();

  TranslationPolicy get currentPolicy => _policy;

  /// 用户配置的默认目标语言（若用户未配置，自动退回系统当前语言）
  String get defaultTargetLang => _defaultTargetLang ?? systemTargetLang;

  /// 动态获取系统当前语言代码，坚决不硬编码固定语言
  String get systemTargetLang {
    try {
      final code = PlatformDispatcher.instance.locale.languageCode;
      if (code.isNotEmpty) return code;
    } catch (_) {}
    return 'zh';
  }

  /// 预热双级缓存与端侧 AI 模型
  Future<void> warmup() async {
    await _cacheEngine.initialize();
    unawaited(edgeAiTranslator.initialize());
  }

  /// 策略开关调整
  void setPolicy(TranslationPolicy policy) {
    _policy = policy;
    debugPrint('🔄 [PyroTranslationPolicyEngine] 翻译策略切换为: $policy');
  }

  void setDefaultTargetLang(String? lang) {
    if (lang != null && lang.isNotEmpty) {
      _defaultTargetLang = lang;
    }
  }

  void setForcedProvider(String? provider) {
    _forcedProvider = provider;
  }

  /// 依据策略分支与缓存池调配翻译
  Future<String> translate(
    String text, {
    String? targetLang,
    String sourceLang = 'auto',
  }) async {
    final effectiveTargetLang = (targetLang == null || targetLang.isEmpty)
        ? (_defaultTargetLang ?? systemTargetLang)
        : targetLang;

    final trimmed = text.trim();
    if (trimmed.isEmpty) return text;

    return _cacheEngine.getOrFetch(
      trimmed,
      (textToFetch, {required targetLang, required sourceLang}) async {
        return _dispatchTranslate(
          textToFetch,
          targetLang: targetLang,
          sourceLang: sourceLang,
        );
      },
      targetLang: effectiveTargetLang,
      sourceLang: sourceLang,
      priority: PreTranslationPriority.high,
    );
  }

  /// 底层路由派发逻辑：自动处理 smartAuto / edgeAiOnly / preferOnlineApi / onlineApiOnly
  Future<String> _dispatchTranslate(
    String textToFetch, {
    required String targetLang,
    required String sourceLang,
  }) async {
    switch (_policy) {
      case TranslationPolicy.smartAuto:
        // 智能自动：优先端侧离线 AI 翻译（短文本且模型可用），遇异常/模型未下载/超长段落时无缝降级至在线 API
        if (textToFetch.length <= 500 && await edgeAiTranslator.isModelAvailable()) {
          try {
            return await edgeAiTranslator.translate(
              textToFetch,
              targetLanguage: targetLang,
              sourceLanguage: sourceLang,
            );
          } catch (e) {
            debugPrint('⚠️ [PyroTranslationPolicyEngine] 端侧离线 AI 翻译异常，自动降级至在线 API: $e');
          }
        }
        return await onlineApiTranslator.translate(
          textToFetch,
          targetLanguage: targetLang,
          sourceLanguage: sourceLang,
          useProvider: _forcedProvider,
        );

      case TranslationPolicy.edgeAiOnly:
        return await edgeAiTranslator.translate(
          textToFetch,
          targetLanguage: targetLang,
          sourceLanguage: sourceLang,
        );

      case TranslationPolicy.preferOnlineApi:
        try {
          return await onlineApiTranslator.translate(
            textToFetch,
            targetLanguage: targetLang,
            sourceLanguage: sourceLang,
            useProvider: _forcedProvider,
          );
        } catch (e) {
          debugPrint('⚠️ [PyroTranslationPolicyEngine] 在线 API 翻译异常，降级至端侧离线 AI: $e');
          if (await edgeAiTranslator.isModelAvailable()) {
            return await edgeAiTranslator.translate(
              textToFetch,
              targetLanguage: targetLang,
              sourceLanguage: sourceLang,
            );
          }
          rethrow;
        }

      case TranslationPolicy.onlineApiOnly:
        return await onlineApiTranslator.translate(
          textToFetch,
          targetLanguage: targetLang,
          sourceLanguage: sourceLang,
          useProvider: _forcedProvider,
        );
    }
  }

  /// 批量预翻译
  Future<List<String>> preTranslateBatch(
    List<String> texts, {
    String? targetLang,
    String sourceLang = 'auto',
    PreTranslationPriority priority = PreTranslationPriority.low,
  }) async {
    final effectiveTargetLang = (targetLang == null || targetLang.isEmpty)
        ? (_defaultTargetLang ?? systemTargetLang)
        : targetLang;

    return _cacheEngine.enqueuePreTranslate(
      texts,
      (textToFetch, {required targetLang, required sourceLang}) async {
        try {
          return await _dispatchTranslate(
            textToFetch,
            targetLang: targetLang,
            sourceLang: sourceLang,
          );
        } catch (e) {
          return textToFetch;
        }
      },
      targetLang: effectiveTargetLang,
      sourceLang: sourceLang,
      priority: priority,
    );
  }

  TranslationCacheStats cacheStats() => _cacheEngine.stats();

  Future<void> clearCache() async => _cacheEngine.clear();
}
