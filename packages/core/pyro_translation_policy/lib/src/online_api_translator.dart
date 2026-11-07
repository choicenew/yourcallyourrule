import 'package:flutter/foundation.dart';
import 'package:pyro_api_translate/pyro_api_translate.dart';

/// 在线 API 多渠道翻译引擎
/// 对接 [pyro_api_translate]，基于调度器与自动故障转移机制调度 Google / Bing / DeepLX / Lingva / Yandex 等服务。
class OnlineApiTranslator {
  late final TranslationService _service;

  OnlineApiTranslator() {
    _service = TranslationService.instance;
  }

  /// 获取当前所有可用且已注册的在线翻译 Provider 列表
  List<String> get availableProviders => _service.availableProviders;

  /// 执行在线翻译，支持指定 Provider 或全局调度器自动均衡与容灾，内置长文本智能分块 (Chunking) 算法消灭 500 字限制
  Future<String> translate(
    String text, {
    required String targetLanguage,
    String sourceLanguage = 'auto',
    String? useProvider,
  }) async {
    final cleanText = text.trim();
    if (cleanText.isEmpty) return text;

    try {
      if (cleanText.length <= 350) {
        return await _service.translate(
          cleanText,
          targetLanguage: targetLanguage,
          sourceLanguage: sourceLanguage,
          useProvider: useProvider,
        );
      }

      // 长文本分块处理 (Chunking)
      final chunks = _splitIntoChunks(cleanText, maxChunkSize: 350);
      final translatedChunks = <String>[];

      for (final chunk in chunks) {
        if (chunk.trim().isEmpty) continue;
        final res = await _service.translate(
          chunk.trim(),
          targetLanguage: targetLanguage,
          sourceLanguage: sourceLanguage,
          useProvider: useProvider,
        );
        translatedChunks.add(res);
      }

      return translatedChunks.join('\n\n');
    } catch (e, stack) {
      debugPrint('❌ [OnlineApiTranslator] 在线翻译请求失败: $e\n$stack');
      rethrow;
    }
  }

  /// 智能句法分块算法
  List<String> _splitIntoChunks(String text, {required int maxChunkSize}) {
    final paragraphs = text.split(RegExp(r'\n+'));
    final List<String> chunks = [];
    String currentChunk = '';

    for (final p in paragraphs) {
      if (p.length <= maxChunkSize) {
        if ((currentChunk.length + p.length + 1) <= maxChunkSize) {
          currentChunk = currentChunk.isEmpty ? p : '$currentChunk\n$p';
        } else {
          if (currentChunk.isNotEmpty) chunks.add(currentChunk);
          currentChunk = p;
        }
      } else {
        // 段落内部按句子拆分
        final sentences = p.split(RegExp(r'(?<=[.!?。！？;；])\s+'));
        for (final s in sentences) {
          if ((currentChunk.length + s.length + 1) <= maxChunkSize) {
            currentChunk = currentChunk.isEmpty ? s : '$currentChunk $s';
          } else {
            if (currentChunk.isNotEmpty) chunks.add(currentChunk);
            if (s.length > maxChunkSize) {
              // 极端超长句硬切
              for (var i = 0; i < s.length; i += maxChunkSize) {
                final end = (i + maxChunkSize < s.length) ? i + maxChunkSize : s.length;
                chunks.add(s.substring(i, end));
              }
              currentChunk = '';
            } else {
              currentChunk = s;
            }
          }
        }
      }
    }

    if (currentChunk.isNotEmpty) {
      chunks.add(currentChunk);
    }

    return chunks.isNotEmpty ? chunks : [text];
  }
}
