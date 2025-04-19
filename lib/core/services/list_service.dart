// 列表服务基类，用于黑白名单等列表功能

import '../base/base_entity.dart';
import '../base/base_service.dart';

/// 列表服务基类
/// [T] 是实体类型
/// [ID] 是实体ID类型，默认为String
abstract class ListService<T extends BaseEntity, ID> extends BaseService<T, ID> {
  const ListService(super.repository);

  /// 添加条目到列表
  Future<T> addEntry(T entry) => save(entry);

  /// 批量添加条目到列表
  Future<List<T>> addEntries(List<T> entries) => saveAll(entries);

  /// 从列表中移除条目
  Future<bool> removeEntry(T entry) => delete(entry);

  /// 从列表中移除条目（通过ID）
  Future<bool> removeEntryById(ID id) => deleteById(id);

  /// 批量从列表中移除条目
  Future<bool> removeEntries(List<T> entries) => deleteAll(entries);

  /// 检查条目是否在列表中
  Future<bool> containsEntry(ID id) => exists(id);

  /// 获取列表中的所有条目
  Future<List<T>> getAllEntries() => getAll();

  /// 根据条件筛选列表条目
  Future<List<T>> filterEntries(bool Function(T) predicate) async {
    final entries = await getAll();
    return entries.where(predicate).toList();
  }

  /// 搜索列表条目
  Future<List<T>> searchEntries(String query) async {
    // 默认实现，子类可以覆盖此方法提供更高效的搜索
    final entries = await getAll();
    return entries.where((entry) => _matchesSearch(entry, query)).toList();
  }

  /// 判断条目是否匹配搜索查询
  /// 子类应该覆盖此方法以提供特定的搜索逻辑
  bool _matchesSearch(T entry, String query) {
    // 默认实现，简单地检查toString是否包含查询字符串
    return entry.toString().toLowerCase().contains(query.toLowerCase());
  }
}