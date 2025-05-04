import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/entities/list/list_entry.dart';
import 'package:yourcallyourrule/core/repositories/base_repository.dart';
import 'providers.dart';

/// 列表仓库接口
abstract class ListRepository extends BaseRepository<ListEntry, String> {
  /// 根据名称获取列表
  Future<ListEntry?> getByName(String name);
  
  /// 根据类型获取列表
  Future<List<ListEntry>> getByType(String type);
  
  /// 检查列表名称是否已存在
  Future<bool> nameExists(String name);
  
  /// 获取所有启用的列表
  Future<List<ListEntry>> getAllEnabled();
  
  /// 获取用户创建的列表
  Future<List<ListEntry>> getUserCreatedLists();
  
  /// 获取系统列表
  Future<List<ListEntry>> getSystemLists();
}

/// 列表数据状态的Notifier类
class ListsNotifier extends AsyncNotifier<List<ListEntry>> {
  late final ListRepository _listRepository;

  @override
  Future<List<ListEntry>> build() async {
    // 初始化仓库
    _initRepository();
    // 加载所有列表
    return _loadLists();
  }

  void _initRepository() {
    // 获取仓库实例
    _listRepository = ref.read(listRepositoryProvider);
  }

  Future<List<ListEntry>> _loadLists() async {
    try {
      // 获取所有列表
      return await _listRepository.getAll();
    } catch (e) {
      // 错误处理
      state = AsyncValue.error(e, StackTrace.current);
      return [];
    }
  }

  /// 添加列表
  Future<void> addList(ListEntry list) async {
    state = const AsyncValue.loading();
    try {
      await _listRepository.save(list);
      state = AsyncValue.data(await _loadLists());
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  /// 更新列表
  Future<void> updateList(ListEntry list) async {
    state = const AsyncValue.loading();
    try {
      await _listRepository.update(list);
      state = AsyncValue.data(await _loadLists());
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  /// 删除列表
  Future<void> deleteList(String listId) async {
    state = const AsyncValue.loading();
    try {
      await _listRepository.deleteById(listId);
      state = AsyncValue.data(await _loadLists());
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
  
  /// 获取启用的列表
  Future<List<ListEntry>> getEnabledLists() async {
    try {
      return await _listRepository.getAllEnabled();
    } catch (e) {
      return [];
    }
  }
  
  /// 获取用户创建的列表
  Future<List<ListEntry>> getUserLists() async {
    try {
      return await _listRepository.getUserCreatedLists();
    } catch (e) {
      return [];
    }
  }
  
  /// 获取系统列表
  Future<List<ListEntry>> getSystemLists() async {
    try {
      return await _listRepository.getSystemLists();
    } catch (e) {
      return [];
    }
  }
}

/// 列表数据提供者
final listsProvider = AsyncNotifierProvider<ListsNotifier, List<ListEntry>>(() {
  return ListsNotifier();
});