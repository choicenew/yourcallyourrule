
import 'package:flutter/material.dart';
import 'package:yourcallyourrule/features/search/services/search_service.dart';

/// 搜索结果类型工具类
/// 提供获取搜索结果类型对应的图标和颜色的方法
class SearchResultTypeUtils {
  /// 获取结果类型对应的图标
  static IconData getIconForType(SearchResultType type) {
    switch (type) {
      case SearchResultType.contact:
        return Icons.person;
      case SearchResultType.label:
        return Icons.label;
      case SearchResultType.block:
        return Icons.block;
      case SearchResultType.allow:
        return Icons.check_circle;
      case SearchResultType.silence:
        return Icons.volume_mute_outlined;
      case SearchResultType.none:
        return Icons.cancel_outlined;
      case SearchResultType.remoteNumber:
        return Icons.cloud;
      case SearchResultType.notFound:
        return Icons.help_outline;
    }
  }

  /// 获取结果类型对应的颜色
  static Color getColorForType(SearchResultType type) {
    switch (type) {
      case SearchResultType.contact:
        return Colors.blue;
      case SearchResultType.label:
        return Colors.purple;
      case SearchResultType.block:
        return Colors.red;
      case SearchResultType.allow:
        return Colors.green;
      case SearchResultType.silence:
        return Colors.teal;
      case SearchResultType.none:
        return Colors.orange;
      case SearchResultType.remoteNumber:
        return Colors.indigo;
      case SearchResultType.notFound:
        return Colors.grey;
    }
  }
}