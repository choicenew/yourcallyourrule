import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/provider/datasource/remote_number_data_source_provider.dart';
import 'package:yourcallyourrule/features/deletion_proposal/providers/deletion_proposal_service_provider.dart';
import '../services/deletion_proposal_service.dart';

import '../../../data/datasources/remote/remote_number_datasource.dart';
import '../../../data/database/remote/remote_database_manager.dart';

/// 删除提议状态
class DeletionProposalState {
  final List<Map<String, dynamic>> pendingProposals;
  final List<Map<String, dynamic>> pendingVotes;
  final Map<String, int> statistics;
  final bool isLoading;
  final String? error;
  final bool isSubmitting;
  final String? lastProposalId;

  const DeletionProposalState({
    this.pendingProposals = const [],
    this.pendingVotes = const [],
    this.statistics = const {},
    this.isLoading = false,
    this.error,
    this.isSubmitting = false,
    this.lastProposalId,
  });

  // 添加 proposals getter 以兼容页面中的调用
  List<Map<String, dynamic>> get proposals => pendingProposals;

  DeletionProposalState copyWith({
    List<Map<String, dynamic>>? pendingProposals,
    List<Map<String, dynamic>>? pendingVotes,
    Map<String, int>? statistics,
    bool? isLoading,
    String? error,
    bool? isSubmitting,
    String? lastProposalId,
  }) {
    return DeletionProposalState(
      pendingProposals: pendingProposals ?? this.pendingProposals,
      pendingVotes: pendingVotes ?? this.pendingVotes,
      statistics: statistics ?? this.statistics,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      lastProposalId: lastProposalId ?? this.lastProposalId,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is DeletionProposalState &&
        listEquals(other.pendingProposals, pendingProposals) &&
        listEquals(other.pendingVotes, pendingVotes) &&
        mapEquals(other.statistics, statistics) &&
        other.isLoading == isLoading &&
        other.error == error &&
        other.isSubmitting == isSubmitting &&
        other.lastProposalId == lastProposalId;
  }

  @override
  int get hashCode {
    return Object.hash(
      pendingProposals,
      pendingVotes,
      statistics,
      isLoading,
      error,
      isSubmitting,
      lastProposalId,
    );
  }
}



/// 删除提议状态通知器
class DeletionProposalNotifier extends Notifier<DeletionProposalState> {
  late final DeletionProposalService _service;
  late final String _deviceId;
  late final String? _userId;

  @override
  DeletionProposalState build() {
    _service = ref.watch(deletionProposalServiceProvider);
    // 这里应该从设备信息或用户配置中获取实际的设备ID和用户ID
    _deviceId = 'default_device_id'; // 实际应用中需要获取真实设备ID
    _userId = null; // 可选的用户ID
    
    return const DeletionProposalState();
  }

  /// 初始化数据
  Future<void> initialize() async {
    if (state.isLoading) return;
    
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      await Future.wait([
        loadPendingProposals(),
        loadPendingVotes(),
        loadStatistics(),
      ]);
      
      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to initialize: $e',
      );
    }
  }

  /// 加载待处理的删除提议
  Future<void> loadPendingProposals() async {
    try {
      final proposals = await _service.getPendingProposals();
      state = state.copyWith(pendingProposals: proposals, error: null);
    } catch (e) {
      state = state.copyWith(error: 'Failed to load proposals: $e');
    }
  }

  /// 加载待处理的投票
  Future<void> loadPendingVotes() async {
    try {
      final votes = await _service.getPendingVotes(
        deviceId: _deviceId,
        userId: _userId,
      );
      state = state.copyWith(pendingVotes: votes, error: null);
    } catch (e) {
      state = state.copyWith(error: 'Failed to load votes: $e');
    }
  }

  /// 加载统计信息
  Future<void> loadStatistics() async {
    try {
      final statistics = await _service.getProposalStatistics();
      state = state.copyWith(statistics: statistics, error: null);
    } catch (e) {
      state = state.copyWith(error: 'Failed to load statistics: $e');
    }
  }

  /// 提议删除号码
  Future<bool> proposeDeletion({
    required String phoneNumber,
    required String reason,
    required int riskLevel,
  }) async {
    if (state.isSubmitting) return false;
    
    // 验证输入
    if (!_service.validateProposal(
      phoneNumber: phoneNumber,
      reason: reason,
      riskLevel: riskLevel,
    )) {
      state = state.copyWith(error: 'Invalid proposal data');
      return false;
    }

    state = state.copyWith(isSubmitting: true, error: null);
    
    try {
      final proposalId = await _service.proposeDeletion(
        phoneNumber: phoneNumber,
        reason: reason,
        riskLevel: riskLevel,
        deviceId: _deviceId,
        userId: _userId,
      );
      
      if (proposalId != null) {
        state = state.copyWith(
          isSubmitting: false,
          lastProposalId: proposalId,
        );
        
        // 刷新数据
        await Future.wait([
          loadPendingProposals(),
          loadStatistics(),
        ]);
        
        return true;
      } else {
        state = state.copyWith(
          isSubmitting: false,
          error: 'Failed to create proposal',
        );
        return false;
      }
    } catch (e) {
      state = state.copyWith(
        isSubmitting: false,
        error: 'Error creating proposal: $e',
      );
      return false;
    }
  }
  
  /// 创建提案 - 为页面提供的简化方法
  Future<bool> createProposal(
    String phoneNumber,
    String reason,
    int riskLevel,
  ) async {
    return proposeDeletion(
      phoneNumber: phoneNumber,
      reason: reason,
      riskLevel: riskLevel,
    );
  }

  /// 对删除提议投票
  Future<bool> voteOnProposal({
    required String proposalId,
    required bool support,
  }) async {
    if (state.isSubmitting) return false;
    
    state = state.copyWith(isSubmitting: true, error: null);
    
    try {
      final success = await _service.voteOnProposal(
        proposalId: proposalId,
        support: support,
        deviceId: _deviceId,
        userId: _userId,
      );
      
      state = state.copyWith(isSubmitting: false);
      
      if (success) {
        // 刷新数据
        await Future.wait([
          loadPendingProposals(),
          loadPendingVotes(),
          loadStatistics(),
        ]);
        return true;
      } else {
        state = state.copyWith(error: 'Failed to submit vote');
        return false;
      }
    } catch (e) {
      state = state.copyWith(
        isSubmitting: false,
        error: 'Error submitting vote: $e',
      );
      return false;
    }
  }

  /// 检查号码是否有待处理的删除提议
  Future<bool> hasPendingProposal(String phoneNumber) async {
    try {
      return await _service.hasPendingProposal(phoneNumber);
    } catch (e) {
      debugPrint('Error checking pending proposal: $e');
      return false;
    }
  }

  /// 获取提议详情
  Future<Map<String, dynamic>?> getProposalDetails(String proposalId) async {
    try {
      return await _service.getProposalDetails(proposalId);
    } catch (e) {
      state = state.copyWith(error: 'Failed to get proposal details: $e');
      return null;
    }
  }

  /// 刷新所有数据
  Future<void> refresh() async {
    await initialize();
  }
  
  /// 刷新提议列表
  Future<void> refreshProposals() async {
    await loadPendingProposals();
  }
  
  /// 搜索提议
  Future<void> searchProposals(String query) async {
    if (query.isEmpty) {
      await loadPendingProposals();
      return;
    }
    
    try {
      final allProposals = await _service.getPendingProposals();
      final filteredProposals = allProposals.where((proposal) {
        final phoneNumber = proposal['phoneNumber']?.toString() ?? '';
        final reason = proposal['reason']?.toString() ?? '';
        final proposalId = proposal['proposalId']?.toString() ?? '';
        
        return phoneNumber.toLowerCase().contains(query.toLowerCase()) ||
               reason.toLowerCase().contains(query.toLowerCase()) ||
               proposalId.toLowerCase().contains(query.toLowerCase());
      }).toList();
      
      state = state.copyWith(pendingProposals: filteredProposals, error: null);
    } catch (e) {
      state = state.copyWith(error: 'Failed to search proposals: $e');
    }
  }

  /// 清理已完成的操作
  Future<void> cleanupCompleted() async {
    try {
      await _service.cleanupCompletedOperations();
      await refresh();
    } catch (e) {
      state = state.copyWith(error: 'Failed to cleanup: $e');
    }
  }

  /// 清除错误状态
  void clearError() {
    state = state.copyWith(error: null);
  }

  /// 获取风险等级描述
  String getRiskLevelDescription(int riskLevel) {
    return _service.getRiskLevelDescription(riskLevel);
  }

  // 移除 dispose 方法，因为 Notifier 类中没有定义此方法
  // 在 Riverpod 3.0 中，资源清理应该在 build 方法中使用 ref.onDispose
  // 或者在 Notifier 类中使用自定义方法
}

/// 删除提议状态提供者
final deletionProposalProvider = NotifierProvider<DeletionProposalNotifier, DeletionProposalState>(
  DeletionProposalNotifier.new,
);

/// 待处理提议数量提供者
final pendingProposalsCountProvider = Provider<int>((ref) {
  final state = ref.watch(deletionProposalProvider);
  return state.pendingProposals.length;
});

/// 待处理投票数量提供者
final pendingVotesCountProvider = Provider<int>((ref) {
  final state = ref.watch(deletionProposalProvider);
  return state.pendingVotes.length;
});

/// 高风险提议数量提供者
final highRiskProposalsCountProvider = Provider<int>((ref) {
  final state = ref.watch(deletionProposalProvider);
  return state.statistics['highRisk'] ?? 0;
});

/// 是否有待处理操作提供者
final hasPendingOperationsProvider = Provider<bool>((ref) {
  final state = ref.watch(deletionProposalProvider);
  return state.pendingProposals.isNotEmpty || state.pendingVotes.isNotEmpty;
});

/// 特定号码的删除提议检查提供者
final phoneNumberProposalProvider = FutureProvider.family<bool, String>((ref, phoneNumber) async {
  final notifier = ref.read(deletionProposalProvider.notifier);
  return await notifier.hasPendingProposal(phoneNumber);
});

/// 提议详情提供者
final proposalDetailsProvider = FutureProvider.family<Map<String, dynamic>?, String>((ref, proposalId) async {
  final notifier = ref.read(deletionProposalProvider.notifier);
  return await notifier.getProposalDetails(proposalId);
});