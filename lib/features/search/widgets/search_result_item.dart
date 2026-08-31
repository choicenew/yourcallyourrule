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
    final typeColor = SearchResultTypeUtils.getColorForType(result.type);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFEDE8DF),
          width: 1.1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: typeColor.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            SearchResultTypeUtils.getIconForType(result.type),
            color: typeColor,
            size: 20,
          ),
        ),
        title: Text(
          result.name ?? result.phoneNumber,
          style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 15, color: Colors.black87),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(result.phoneNumber, style: const TextStyle(fontSize: 12.5, color: Colors.black54)),
            if (result.description != null)
              Text(
                result.description!,
                style: TextStyle(
                  color: typeColor,
                  fontSize: 11.5,
                  fontWeight: FontWeight.w700,
                ),
              ),
          ],
        ),
        trailing: const Icon(Icons.chevron_right_rounded, color: Colors.grey, size: 20),
        onTap: onTap,
      ),
    );
  }
}