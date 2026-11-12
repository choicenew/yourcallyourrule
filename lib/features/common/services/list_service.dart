import '../base/base_service.dart';

/// 列表服务基类
abstract class ListService<T, ID> extends BaseService<T, ID> {
  const ListService();

  Future<T> addEntry(T entry) => save(entry);
  Future<List<T>> addEntries(List<T> entries) => saveAll(entries);
  Future<bool> removeEntry(T entry) => delete(entry);
  Future<bool> removeEntryById(ID id) => deleteById(id);
  Future<bool> removeEntries(List<T> entries) => deleteAll(entries);
  Future<bool> containsEntry(ID id) => exists(id);
  Future<List<T>> getAllEntries() => getAll();

  Future<List<T>> filterEntries(bool Function(T) predicate) async {
    final entries = await getAll();
    return entries.where(predicate).toList();
  }

  Future<List<T>> searchEntries(String query) async {
    final entries = await getAll();
    return entries.where((entry) => _matchesSearch(entry, query)).toList();
  }

  bool _matchesSearch(T entry, String query) {
    return entry.toString().toLowerCase().contains(query.toLowerCase());
  }
}
