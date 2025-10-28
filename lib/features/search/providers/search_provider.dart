import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yourcallyourrule/features/search/services/search_service.dart';

part 'search_provider.g.dart';

/// 一个 AsyncNotifier，用于管理搜索页面的状态。
/// 它封装了执行搜索、管理加载状态和持有搜索结果的全部逻辑。
@riverpod
class Search extends _$Search {
  Timer? _debounce;

  @override
  Future<List<SearchResult>> build() async {
    // [修正]: 使用 ref.onDispose 来正确管理 Timer 的生命周期。
    // 当 Notifier 被销毁时，这个回调会被触发。
    ref.onDispose(() {
      _debounce?.cancel();
    });
    
    // 初始状态为空列表。
    return [];
  }

  /// 立即执行搜索的方法。
  /// 它会自动处理加载状态和错误状态。
  Future<void> search(String query) async {
    if (query.isEmpty) {
      state = const AsyncValue.data([]);
      return;
    }
    
    state = const AsyncValue.loading();
    
    state = await AsyncValue.guard(() async {
      final searchService = ref.read(searchServiceProvider);
      return searchService.searchPhoneNumber(query);
    });
  }

  /// 带防抖功能的搜索方法。
  /// 在用户停止输入500毫秒后才执行搜索。
  void searchWithDebounce(String query) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      // 当定时器触发时，调用立即搜索的方法。
      search(query);
    });
  }

  /// 清除搜索结果，将状态重置为初始状态。
  void clear() {
    state = const AsyncValue.data([]);
  }

  // [修正]: 移除 `dispose` 方法，因为它不存在于父类中。
  // @override
  // void dispose() {
  //   _debounce?.cancel();
  //   super.dispose();
  // }
}