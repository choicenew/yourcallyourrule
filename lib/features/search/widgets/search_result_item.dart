import 'package:flutter/material.dart';
import 'package:yourcallyourrule/features/search/services/search_service.dart';

/// 搜索结果项组件
/// 用于显示搜索结果的单个项目
class SearchResultItem extends StatelessWidget {
  final SearchResult result;
  final VoidCallback onTap;

  const SearchResultItem({
    super.key,
    required this.result,
    required this.onTap,
  });

  /// 获取结果类型对应的图标
  IconData _getIconForType(SearchResultType type) {
    switch (type) {
      case SearchResultType.contact:
        return Icons.person;
      case SearchResultType.label:
        return Icons.label;
      case SearchResultType.blacklist:
        return Icons.block;
      case SearchResultType.whitelist:
        return Icons.check_circle;
      case SearchResultType.allowed:
        return Icons.check_circle_outline;
      case SearchResultType.blocked:
        return Icons.cancel_outlined;
      case SearchResultType.remoteNumber:
        return Icons.cloud;
      case SearchResultType.notFound:
        return Icons.help_outline;
    }
  }

  /// 获取结果类型对应的颜色
  Color _getColorForType(SearchResultType type) {
    switch (type) {
      case SearchResultType.contact:
        return Colors.blue;
      case SearchResultType.label:
        return Colors.purple;
      case SearchResultType.blacklist:
        return Colors.red;
      case SearchResultType.whitelist:
        return Colors.green;
      case SearchResultType.allowed:
        return Colors.teal;
      case SearchResultType.blocked:
        return Colors.orange;
      case SearchResultType.remoteNumber:
        return Colors.indigo;
      case SearchResultType.notFound:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _getColorForType(result.type),
          child: Icon(
            _getIconForType(result.type),
            color: Colors.white,
          ),
        ),
        title: Text(
          result.name ?? result.phoneNumber,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(result.phoneNumber),
            if (result.description != null)
              Text(
                result.description!,
                style: TextStyle(
                  color: _getColorForType(result.type),
                  fontSize: 12,
                ),
              ),
          ],
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}