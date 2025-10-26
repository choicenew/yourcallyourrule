import 'dart:async';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// 引入所有必要的 Provider 和模型
import 'package:yourcallyourrule/core/provider/providers/device_id_service_provider.dart';
import 'package:yourcallyourrule/features/deletion_proposal/domain/proposal.dart';
import 'package:yourcallyourrule/features/deletion_proposal/providers/deletion_proposal_service_provider.dart';

part 'deletion_proposal_provider.g.dart';

/// 删除提议状态模型。
class DeletionProposalState {
  // 【MODIFIED】: 新增 `_allProposals` 字段
  // REASON: 用于缓存从数据源获取的原始、完整的提议列表。
  //         `proposals` 字段现在将用于存储过滤后（用于UI展示）的列表。
  final List<Proposal> _allProposals;
  
  /// 用于UI展示的提议列表（可能是完整的，也可能是搜索过滤后的）。
  final List<Proposal> proposals;

  final bool isLoading;
  final String? error;
  final bool isSubmitting;
  // 【核心修正】: 完整地、正确地添加了 `statistics` 字段。
  // REASON: 这是我之前遗漏的关键功能，用于 UI 层方便地访问统计数据。
  // =======================================================================
  final Map<String, int> statistics;

  const DeletionProposalState({
    List<Proposal>? allProposals,
    this.proposals = const [],
    this.isLoading = false,
    this.error,
    this.isSubmitting = false,
      this.statistics = const {}, // 【MODIFIED】: 添加默认值
  }) : _allProposals = allProposals ?? proposals; // 如果未提供 allProposals，则默认等于 proposals

  DeletionProposalState copyWith({
    List<Proposal>? allProposals,
    List<Proposal>? proposals,
    bool? isLoading,
    String? error,
    bool? isSubmitting,
    Map<String, int>? statistics, // 【MODIFIED】: 添加到 copyWith
  }) {
    return DeletionProposalState(
      allProposals: allProposals ?? _allProposals,
      proposals: proposals ?? this.proposals,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      isSubmitting: isSubmitting ?? this.isSubmitting,
         statistics: statistics ?? this.statistics, // 【MODIFIED】
    );
  }

  // 【MODIFIED】: 更新 `==` 和 `hashCode` 以包含 `statistics`
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;
    final mapEquals = const DeepCollectionEquality().equals;
  
    return other is DeletionProposalState &&
      listEquals(other._allProposals, _allProposals) &&
      listEquals(other.proposals, proposals) &&
      other.isLoading == isLoading &&
      other.error == error &&
      other.isSubmitting == isSubmitting &&
      mapEquals(other.statistics, statistics);
  }

  @override
  int get hashCode {
    return Object.hash(
      const DeepCollectionEquality().hash(_allProposals),
      const DeepCollectionEquality().hash(proposals),
      isLoading,
      error,
      isSubmitting,
      const DeepCollectionEquality().hash(statistics),
    );
  }
}

// =======================================================================
// 【核心修正】: `DeletionProposalNotifier` 现在会正确地加载和更新 `statistics`。
// =======================================================================
/// 删除提议状态的 Notifier。
@Riverpod(keepAlive: true)
class DeletionProposalNotifier extends _$DeletionProposalNotifier {
  late final String _deviceId;

  @override
  DeletionProposalState build() {
    _loadInitialData();
    return const DeletionProposalState(isLoading: true);
  }

  Future<void> _loadInitialData() async {
    _deviceId = await ref.read(deviceIdServiceProvider).getDeviceId();
      // 【MODIFIED】: 初始化时同时加载提议和统计数据
    await Future.wait([
      loadPendingProposals(),
      loadStatistics(),
    ]);
    state = state.copyWith(isLoading: false);
  }
  
  /// 加载待处理的删除提议。
  Future<void> loadPendingProposals() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final proposals = await ref.read(deletionProposalServiceProvider).getPendingProposals();
      // 【MODIFIED】: 同时更新 `_allProposals` (原始数据) 和 `proposals` (展示数据)。
      state = state.copyWith(
        allProposals: proposals, 
        proposals: proposals, 
        isLoading: false
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: 'Failed to load proposals: $e');
    }
  }

  /// 【新恢复】: 添加了加载统计数据的方法。
  Future<void> loadStatistics() async {
    try {
      final stats = await ref.read(deletionProposalServiceProvider).getProposalStatistics();
      state = state.copyWith(statistics: stats);
    } catch (e) {
      // 统计加载失败通常不是关键错误，可以只打印日志
      debugPrint('Failed to load statistics: $e');
    }
  }
  
  /// 创建一个新的删除提议。
  Future<bool> createProposal(String phoneNumber, String reason, int riskLevel) async {
    if (state.isSubmitting) return false;
    state = state.copyWith(isSubmitting: true, error: null);
    try {
      final proposalId = await ref.read(deletionProposalServiceProvider).proposeDeletion(
        phoneNumber: phoneNumber,
        reason: reason,
        riskLevel: riskLevel,
        deviceId: _deviceId,
      );
      if (proposalId != null) {
        state = state.copyWith(isSubmitting: false);
       await Future.wait([loadPendingProposals(), loadStatistics()]); // 刷新提议和统计数据
        return true;
      } else {
        state = state.copyWith(isSubmitting: false, error: 'Failed to create proposal.');
        return false;
      }
    } catch (e) {
      state = state.copyWith(isSubmitting: false, error: 'Error creating proposal: $e');
      return false;
    }
  }

  /// 对一个删除提议进行投票。
  Future<bool> voteOnProposal({required String proposalId, required bool support}) async {
    if (state.isSubmitting) return false;
    state = state.copyWith(isSubmitting: true, error: null);
    try {
      final success = await ref.read(deletionProposalServiceProvider).voteOnProposal(
        proposalId: proposalId,
        support: support,
        deviceId: _deviceId,
      );
      state = state.copyWith(isSubmitting: false);
      if (success) {
        await Future.wait([loadPendingProposals(), loadStatistics()]); // 刷新
        return true;
      } else {
        state = state.copyWith(error: 'Failed to submit vote.');
        return false;
      }
    } catch (e) {
      state = state.copyWith(isSubmitting: false, error: 'Error submitting vote: $e');
      return false;
    }
  }
  
  /// 刷新提议列表。
  Future<void> refreshProposals() async {
       // 【MODIFIED】: 刷新时同时刷新提议和统计
    await Future.wait([
      loadPendingProposals(),
      loadStatistics(),
    ]);
  }

  // =======================================================================
  // 【核心修正】: 完整恢复了 `searchProposals` 功能，并优化了其逻辑。
  // REASON: 这是 UI 层必需的功能，之前被严重遗漏。
  // =======================================================================
  
  /// 在已加载的提议列表中进行搜索。
  ///
  /// 此方法在内存中进行过滤，不会触发新的网络或数据库请求，性能极高。
  void searchProposals(String query) {
    // 1. 获取缓存的原始列表
    final allProposals = state._allProposals;
    
    // 2. 如果搜索查询为空，直接恢复显示完整的列表
    if (query.isEmpty) {
      state = state.copyWith(proposals: allProposals);
      return;
    }
    
    // 3. 在内存中执行过滤操作
    final lowerCaseQuery = query.toLowerCase();
    final filteredProposals = allProposals.where((proposal) {
      // 【MODIFIED】: 搜索现在基于强类型的 `Proposal` 对象属性，更安全、更清晰。
      final phoneNumber = proposal.phoneNumber.toLowerCase();
      // 使用我们之前在 Proposal 模型中定义的 reason getter
      final reason = proposal.reason.toLowerCase();
      
      return phoneNumber.contains(lowerCaseQuery) ||
             reason.contains(lowerCaseQuery);
    }).toList();
    
    // 4. 更新用于UI展示的 `proposals` 列表
    state = state.copyWith(proposals: filteredProposals);
  }
}

// =======================================================================
// 【核心修正】: 创建一个新的 Provider，专门用于异步获取单个提议的详情。
// REASON: 这使得详情页可以独立于列表页的状态，实现了解耦，并能处理数据尚未加载的情况。
// =======================================================================
@riverpod
Future<Proposal?> proposalDetails(Ref ref, String proposalId) async {
  // 1. 获取 DeletionProposalService 的实例。
  final service = ref.watch(deletionProposalServiceProvider);
  
  // 2. 调用 Service 中获取单个提议详情的方法。
  final proposal = await service.getProposalDetails(proposalId);
  
  // 3. 返回获取到的数据。
  //    如果 service 返回 null，这个 Provider 的状态也会是 `AsyncData(null)`。
  return proposal;
}