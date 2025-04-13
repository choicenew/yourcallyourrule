import 'package:collection/collection.dart';

/// 列表服务基类
/// 提供列表数据的通用操作，如分页、排序和过滤
class BaseListService<T> {
  /// 对列表进行分页
  /// [items] 原始列表
  /// [page] 页码，从1开始
  /// [pageSize] 每页大小
  List<T> paginate(List<T> items, int page, int pageSize) {
    if (items.isEmpty) return [];
    if (page < 1) page = 1;
    
    final startIndex = (page - 1) * pageSize;
    if (startIndex >= items.length) return [];
    
    final endIndex = startIndex + pageSize > items.length 
        ? items.length 
        : startIndex + pageSize;
    
    return items.sublist(startIndex, endIndex);
  }
  
  /// 对列表进行排序
  /// [items] 原始列表
  /// [compare] 比较函数
  /// [descending] 是否降序排列
  List<T> sort(List<T> items, int Function(T a, T b) compare, {bool descending = false}) {
    final result = List<T>.from(items);
    result.sort((a, b) => descending ? compare(b, a) : compare(a, b));
    return result;
  }
  
  /// 对列表进行过滤
  /// [items] 原始列表
  /// [test] 过滤条件
  List<T> filter(List<T> items, bool Function(T item) test) {
    return items.where(test).toList();
  }
  
  /// 对列表进行分组
  /// [items] 原始列表
  /// [key] 分组键函数
  Map<K, List<T>> groupBy<K>(List<T> items, K Function(T item) key) {
    return groupByToMap(items, key);
  }
  
  /// 计算列表总页数
  /// [totalItems] 总项目数
  /// [pageSize] 每页大小
  int getTotalPages(int totalItems, int pageSize) {
    if (pageSize <= 0) return 0;
    return (totalItems / pageSize).ceil();
  }
}