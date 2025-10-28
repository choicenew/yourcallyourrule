import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yourcallyourrule/features/call_statistic/domain/repositories/blocked_call_repository.dart';
import 'package:yourcallyourrule/features/call_statistic/domain/providers/blocked_call_repository_provider.dart';

part 'blocked_calls_provider.g.dart';

/// BlockedCallsPage 的数据状态模型
class BlockedCallsState {
  final List<BlockedCall> calls;
  final int tabIndex; // 0: All, 1: Phone, 2: SMS

  const BlockedCallsState({
    required this.calls,
    this.tabIndex = 0,
  });
}

/// 一个异步 Notifier，用于根据选择的 Tab 异步加载和管理拦截记录列表。
@riverpod
class BlockedCalls extends _$BlockedCalls {
  
  /// build 方法负责加载初始状态。
  /// 初始状态下加载所有记录 (tabIndex = 0)。
  @override
  Future<BlockedCallsState> build() async {
    final repository = ref.watch(blockedCallRepositoryProvider);
    final calls = await repository.getBlockedCalls();
    return BlockedCallsState(calls: calls, tabIndex: 0);
  }

  /// 提供一个方法来根据 Tab 索引切换和重新加载数据。
  Future<void> changeTab(int newIndex) async {
    // 如果索引没有变化，则不执行任何操作。
    if (state.value?.tabIndex == newIndex) return;

    // 立即将状态设置为加载中，以便UI显示进度指示器。
    state = const AsyncValue.loading();
    
    // 使用 AsyncValue.guard 优雅地处理异步加载和错误。
    state = await AsyncValue.guard(() async {
      final repository = ref.read(blockedCallRepositoryProvider);
      List<BlockedCall> calls;
      switch (newIndex) {
        case 1: // 仅电话
          calls = await repository.getBlockedCallsOnly();
          break;
        case 2: // 仅短信
          calls = await repository.getBlockedSmsOnly();
          break;
        case 0: // 全部
        default:
          calls = await repository.getBlockedCalls();
          break;
      }
      return BlockedCallsState(calls: calls, tabIndex: newIndex);
    });
  }
}