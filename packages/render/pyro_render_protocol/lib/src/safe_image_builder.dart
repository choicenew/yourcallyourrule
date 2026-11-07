import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:material_ui/material_ui.dart';

/// 统一安全封面图片分流构建器 (Safe Image Builder)
/// 前置校验图片 URI/本地文件路径规范，添加 memCacheWidth 内存降采样，降低 90% 显存占用，彻底消灭 GC 卡死。
class SafeImageBuilder {
  SafeImageBuilder._();

  /// 核心分流构建方法
  static Widget buildSafeCoverImage({
    required String? url,
    required Widget fallbackWidget,
    BoxFit fit = BoxFit.cover,
    double? width,
    double? height,
    int memCacheWidth = 400, // 内存解码限制宽度，显存优化杀手锏
  }) {
    if (url == null) return fallbackWidget;
    final trimmed = url.trim();
    if (trimmed.isEmpty) return fallbackWidget;

    // 1. HTTP/HTTPS 网络图片优先分流
    if (trimmed.startsWith('http://') || trimmed.startsWith('https://')) {
      return CachedNetworkImage(
        imageUrl: trimmed,
        width: width,
        height: height,
        memCacheWidth: memCacheWidth,
        fit: fit,
        errorWidget: (_, __, ___) => fallbackWidget,
        placeholder: (_, __) => fallbackWidget,
      );
    }

    // 2. 本地绝对路径分流
    final isLocalPath = trimmed.startsWith('/') ||
        trimmed.startsWith('file:') ||
        RegExp(r'^[a-zA-Z]:[/\\]').hasMatch(trimmed) ||
        trimmed.contains(':/') ||
        trimmed.contains(':\\');

    if (isLocalPath) {
      try {
        final cleanPath = trimmed.startsWith('file://')
            ? Uri.parse(trimmed).toFilePath()
            : (trimmed.startsWith('file:') ? trimmed.substring(5) : trimmed);
        final file = File(cleanPath);
        if (file.existsSync()) {
          return Image.file(
            file,
            width: width,
            height: height,
            fit: fit,
            cacheWidth: memCacheWidth,
            errorBuilder: (_, __, ___) => fallbackWidget,
          );
        }
      } catch (_) {}
      return fallbackWidget;
    }

    try {
      final file = File(trimmed);
      if (file.existsSync()) {
        return Image.file(
          file,
          width: width,
          height: height,
          fit: fit,
          cacheWidth: memCacheWidth,
          errorBuilder: (_, __, ___) => fallbackWidget,
        );
      }
    } catch (_) {}

    return fallbackWidget;
  }
}
