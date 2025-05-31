import 'package:flutter/material.dart';
import 'package:yourcallyourrule/features/search/services/search_service.dart';
import 'package:yourcallyourrule/features/search/utils/search_result_type_utils.dart';

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

  // 使用工具类获取图标和颜色

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: SearchResultTypeUtils.getColorForType(result.type),
          child: Icon(
            SearchResultTypeUtils.getIconForType(result.type),
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
                  color: SearchResultTypeUtils.getColorForType(result.type),
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