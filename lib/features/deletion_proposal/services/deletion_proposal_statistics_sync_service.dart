import 'dart:async';

import 'package:yourcallyourrule/features/deletion_proposal/services/deletion_proposal_statistics_service.dart';

/// 删除提议统计同步服务类
/// 负责监听删除提议数据并记录投票统计
/// 参考LabelMarkStatisticsSyncService的实现模式
class DeletionProposalStatisticsSyncService {
  final DeletionProposalStatisticsService _statisticsService;
  StreamSubscription<dynamic>? _dataSubscription;

  DeletionProposalStatisticsSyncService(
    this._statisticsService,
  );

  /// 开始监听删除提议流并记录投票统计
  void startSync(Stream<Map<String, dynamic>> proposalStream) {
    _dataSubscription?.cancel();
    
    _dataSubscription = proposalStream.listen(_handleProposalData);
  }

  /// 处理单个提议数据并记录投票统计
  Future<void> syncSingleProposal(Map<String, dynamic> proposal, bool support) async {
    await _handleProposalVote(proposal, support);
  }

  /// 处理提议数据并记录投票统计
  Future<void> _handleProposalData(Map<String, dynamic> proposal) async {
    // 这里只是监听提议数据，实际的投票记录由用户操作触发
    // 可以在这里添加其他同步逻辑，比如状态更新等
  }

  /// 处理提议投票并记录统计
  Future<void> _handleProposalVote(Map<String, dynamic> proposal, bool support) async {
    // 获取电话号码
    final phoneNumber = proposal['phoneNumber'] as String?;
    
    if (phoneNumber != null) {
      await _statisticsService.recordVote(phoneNumber, support);
    }
  }

  /// 停止同步
  void stopSync() {
    _dataSubscription?.cancel();
    _dataSubscription = null;
  }

  /// 释放资源
  void dispose() {
    stopSync();
  }
}