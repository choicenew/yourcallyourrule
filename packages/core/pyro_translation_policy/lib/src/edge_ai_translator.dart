import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:pyro_edge_ai_infra/pyro_edge_ai_infra.dart';
import 'package:pyro_edge_ai_translate/pyro_edge_ai_translate.dart';

/// 端侧 Edge AI 离线大模型翻译引擎
/// 对接 [pyro_edge_ai_translate]，提供设备端完全离线、高隐私保护的神经机器翻译。
class EdgeAiTranslator {
  final PyroEdgeTranslateEngine _engine = PyroEdgeTranslateEngine();
  bool _isInitialized = false;

  bool get isReady => _isInitialized;

  /// 解析本地是否存在可用的端侧翻译模型文件
  static Future<String?> resolveAvailableModelPath({
    String? modelsDir,
    String? customModelPath,
  }) async {
    // 1. 若显式指定了文件路径且文件存在且非空
    if (customModelPath != null && customModelPath.isNotEmpty) {
      final file = File(customModelPath);
      if (file.existsSync() && file.lengthSync() > 0) {
        return customModelPath;
      }
    }

    // 2. 收集潜在的模型搜索目录
    final candidateDirs = <String>[];
    if (modelsDir != null && modelsDir.isNotEmpty) {
      candidateDirs.add(modelsDir);
    }

    try {
      final sharedRoot = (await ModelStorage.modelsRoot).path;
      if (!candidateDirs.contains(sharedRoot)) {
        candidateDirs.add(sharedRoot);
      }
    } catch (_) {}

    try {
      final appSupportDir = await getApplicationSupportDirectory();
      final legacyModelsDir = p.join(appSupportDir.path, 'ai_models');
      if (!candidateDirs.contains(legacyModelsDir)) {
        candidateDirs.add(legacyModelsDir);
      }
    } catch (_) {}

    // 3. 常见模型相对路径列表
    final relativeModelPaths = [
      p.join('translate', 'hunyuan', 'model_q4f16.onnx'),
      p.join('llm', 'qwen', 'decoder_model_merged_q4.onnx'),
      p.join('translate', 'qwen', 'decoder_model_merged_q4.onnx'),
      'gemma3_quantized.onnx',
      p.join('models', 'gemma3_quantized.onnx'),
    ];

    for (final dirPath in candidateDirs) {
      // 若 dirPath 本身即为一个存在的 .onnx 文件
      if (dirPath.endsWith('.onnx') && File(dirPath).existsSync()) {
        return dirPath;
      }

      final dir = Directory(dirPath);
      if (!dir.existsSync()) continue;

      for (final rel in relativeModelPaths) {
        final fullPath = p.join(dirPath, rel);
        final f = File(fullPath);
        if (f.existsSync() && f.lengthSync() > 0) {
          return fullPath;
        }
      }

      // 递归扫一眼有没有 .onnx 模型文件
      try {
        final entities = dir.listSync(recursive: true);
        for (final entity in entities) {
          if (entity is File &&
              entity.path.endsWith('.onnx') &&
              entity.lengthSync() > 0) {
            return entity.path;
          }
        }
      } catch (_) {}
    }

    return null;
  }

  /// 检查本地是否有已下载可用的离线模型
  Future<bool> isModelAvailable({String? modelsDir}) async {
    final path = await resolveAvailableModelPath(modelsDir: modelsDir);
    return path != null;
  }

  /// 初始化端侧翻译引擎与模型权重
  Future<void> initialize({
    String? modelsDir,
    TranslateModelConfig? config,
  }) async {
    if (_isInitialized) return;

    final resolvedPath = await resolveAvailableModelPath(
      modelsDir: modelsDir,
      customModelPath: config?.modelPath,
    );

    if (resolvedPath == null) {
      debugPrint('ℹ️ [EdgeAiTranslator] 端侧离线 AI 翻译模型未下载，已安全跳过初始化');
      return;
    }

    try {
      final finalConfig =
          config ?? TranslateModelConfig(modelPath: resolvedPath);
      await _engine.initialize(finalConfig);
      _isInitialized = true;
      debugPrint('🤖 [EdgeAiTranslator] 端侧离线大模型翻译引擎初始化就绪: $resolvedPath');
    } catch (e, stack) {
      debugPrint('⚠️ [EdgeAiTranslator] 端侧离线翻译引擎初始化提示: $e\n$stack');
    }
  }

  /// 执行端侧离线翻译
  Future<String> translate(
    String text, {
    required String targetLanguage,
    String sourceLanguage = 'auto',
  }) async {
    if (!_isInitialized) {
      await initialize();
    }
    if (!_isInitialized) {
      throw StateError('端侧离线 AI 翻译模型未下载或未初始化成功，无法进行端侧翻译。');
    }
    return _engine.translate(
      text,
      sourceLang: sourceLanguage,
      targetLang: targetLanguage,
    );
  }
}
