import 'package:flutter/foundation.dart';

import 'dart:async';


// 【MODIFIED】: 引入了新的、统一的 Repository 抽象和强类型领域模型。
// REASON: 这是重构的核心，确保 Service 层与具体的数据实现解耦，并使用类型安全的对象。
import 'package:yourcallyourrule/features/deletion_proposal/domain/repositories/proposal_repository.dart';
import 'package:yourcallyourrule/features/deletion_proposal/domain/proposal.dart';


/// 删除提议服务
///
/// 处理所有与众包删除审核系统相关的核心业务逻辑。
/// 它是 UI 层和数据层（Repository）之间的主要协调者。
class DeletionProposalService {
  // 【MODIFIED】: 依赖关系被简化和统一。
  // REASON: Service 现在只依赖于 ProposalRepository 的抽象，符合整洁架构原则。
  //         它不再需要关心底层的具体数据源是哪个。
  final ProposalRepository _proposalRepository;
  
  DeletionProposalService({
    required ProposalRepository proposalRepository,
  }) : _proposalRepository = proposalRepository;

  /// 提议删除一个号码。
  ///
  /// 此方法负责验证输入，然后调用 Repository 将一个“提议删除”操作记录到待同步队列中。
  ///
  /// [phoneNumber] 要提议删除的电话号码。
  /// [reason] 提议删除的原因。
  /// [riskLevel] 用户评估的风险等级 (1-5)。
  /// [deviceId] 用户的设备ID。
  /// [userId] 用户的可选ID。
  ///
  /// 返回提议ID（即电话号码），如果失败则返回null。
  Future<String?> proposeDeletion({
    required String phoneNumber,
    required String reason,
    required int riskLevel,
    required String deviceId,
    String? userId,
  }) async {
    try {
      // 1. 验证输入参数
      if (!_validateProposalInput(phoneNumber: phoneNumber, reason: reason, riskLevel: riskLevel)) {
        debugPrint('DeletionProposalService: Invalid input parameters.');
        return null;
      }
      
      // 2. 检查此号码是否已有一个待同步的提议操作
      // 【MODIFIED】: 调用了 Repository 中查询 pending_operations 的正确方法。
      final hasPendingOp = await _proposalRepository.hasPendingDeletionProposal(phoneNumber);
      if (hasPendingOp) {
        debugPrint('DeletionProposalService: A pending deletion proposal operation already exists for $phoneNumber');
        return null;
      }

      // 3. 将提议操作记录到待同步队列
      // 【MODIFIED】: 调用了 Repository 中正确的、负责记录操作的方法。
      await _proposalRepository.proposeDeletion(
        phoneNumber: phoneNumber,
        report: {
          'reason': reason,
          'riskLevel': riskLevel,
          'deviceId': deviceId,
          'userId': userId,
        },
      );
      
      // 4. 同时，为了快速反馈给提议限制服务，也在本地日志表中记录一次提交
      await _proposalRepository.recordProposalSubmission(proposerId: deviceId, phoneNumber: phoneNumber);

      final proposalId = phoneNumber;
      debugPrint('DeletionProposalService: Logged PROPOSE_DELETION operation for $proposalId');
      return proposalId;

    } catch (e) {
      debugPrint('DeletionProposalService: Error proposing deletion: $e');
      return null;
    }
  }

  /// 对一个删除提议进行投票。
  ///
  /// 此方法将用户的投票（支持/反对）记录为一个待同步的操作。
  Future<bool> voteOnProposal({
    required String proposalId,
    required bool support,
    required String deviceId,
    String? userId,
  }) async {
    try {
      // 1. 将投票操作记录到待同步队列
      // 【MODIFIED】: 调用了 Repository 中正确的、负责记录投票操作的方法。
      await _proposalRepository.voteOnDeletionProposal(
        phoneNumber: proposalId, // proposalId 就是 phoneNumber
        voteType: support ? 'support' : 'oppose',
        additionalData: {'deviceId': deviceId, 'userId': userId},
      );

      // 2. 同时，为了快速反馈给提议限制服务（用于兑换），也在本地日志表中记录一次投票
      await _proposalRepository.recordVote(voterId: deviceId, proposalId: proposalId);

      debugPrint('DeletionProposalService: Logged VOTE_DELETION operation on proposal $proposalId: support=$support');
      return true;

    } catch (e) {
      debugPrint('DeletionProposalService: Error voting on proposal: $e');
      return false;
    }
  }

  /// 获取待处理的删除提议列表（用于UI展示）。
  ///
  /// 返回一个强类型的 `Proposal` 对象列表。
  // 【MODIFIED】: 返回值从 `List<Map<String, dynamic>>` 变为了强类型的 `List<Proposal>`。
  Future<List<Proposal>> getPendingProposals() async {
    try {
      // 【MODIFIED】: 调用了 Repository 中更清晰命名的 `getActivePendingDeletionProposals` 方法。
      final proposals = await _proposalRepository.getActivePendingDeletionProposals();
      debugPrint('DeletionProposalService: Retrieved ${proposals.length} pending proposals for display.');
      return proposals;
    } catch (e) {
      debugPrint('DeletionProposalService: Error getting pending proposals: $e');
      return [];
    }
  }

  /// 获取特定删除提议的详细信息。
  ///
  /// 返回一个强类型的 `Proposal` 对象。
  // 【MODIFIED】: 返回值从 `Map<String, dynamic>?` 变为了强类型的 `Proposal?`。
  Future<Proposal?> getProposalDetails(String phoneNumber) async {
    try {
      // NOTE: getProposalInfo 查询的是本地 `active_deletion_proposals` 表的状态。
      return await _proposalRepository.getProposalInfo(phoneNumber);
    } catch (e) {
      debugPrint('DeletionProposalService: Error getting proposal details: $e');
      return null;
    }
  }

  /// 清理已完成的删除操作。
  ///
  /// 同时清理本地的状态表和待同步的操作日志。
  Future<void> cleanupCompletedOperations([String? phoneNumber]) async {
    try {
      if (phoneNumber != null) {
        // 清理 pending_operations 表
        await _proposalRepository.clearDeletionOperations(phoneNumber);
      }
      // 清理 active_deletion_proposals 表
      await _proposalRepository.cleanupCompletedDeletionProposals(const Duration(days: 30));
      debugPrint('DeletionProposalService: Cleaned up completed operations.');
    } catch (e) {
      debugPrint('DeletionProposalService: Error cleaning up operations: $e');
    }
  }

  /// 获取删除提议的统计信息。
  ///
  /// 返回一个包含各种统计数据的Map。
  // 【MODIFIED】: 统计逻辑现在基于强类型的 `Proposal` 对象，并且风险等级逻辑已修正。
  Future<Map<String, int>> getProposalStatistics() async {
    try {
      final pendingProposals = await getPendingProposals();
      
      // =======================================================================
      // 【核心逻辑修正】: 彻底纠正了 risk level 的映射关系。
      // REASON: 'Verified' 代表已验证所有者，是【最低风险】。
      // =======================================================================
      int riskLevelToInt(String riskString) {
        switch (riskString.toLowerCase()) {
          case 'high':
            return 5;
          case 'medium':
            return 3;
          case 'low':
            return 2;
          case 'verified': // 已验证，最低风险
            return 1;
          default:
            return 3; // 未知情况默认为中等风险
        }
      }

      final statistics = <String, int>{
        'totalPending': pendingProposals.length,
        'highRisk': pendingProposals.where((p) => riskLevelToInt(p.highestRiskLevel) >= 4).length,
        'mediumRisk': pendingProposals.where((p) => riskLevelToInt(p.highestRiskLevel) == 3).length,
        'lowRisk': pendingProposals.where((p) => riskLevelToInt(p.highestRiskLevel) <= 2).length,
      };
      
      debugPrint('DeletionProposalService: Statistics - $statistics');
      return statistics;
    } catch (e) {
      debugPrint('DeletionProposalService: Error getting statistics: $e');
      return {'totalPending': 0, 'highRisk': 0, 'mediumRisk': 0, 'lowRisk': 0};
    }
  }

  /// 验证删除提议输入的有效性。
  bool _validateProposalInput({
    required String phoneNumber,
    required String reason,
    required int riskLevel,
  }) {
    if (phoneNumber.isEmpty || phoneNumber.length < 7) {
      return false;
    }
    if (reason.isEmpty || reason.length < 10) {
      return false;
    }
    if (riskLevel < 1 || riskLevel > 5) {
      return false;
    }
    return true;
  }

  /// 获取风险等级的文字描述。
  // 【核心逻辑修正】: 这里的描述现在与 `riskLevelToInt` 的逻辑完全匹配。
  String getRiskLevelDescription(int riskLevel) {
    switch (riskLevel) {
      case 1:
        return 'Very Low Risk'; // 1 代表已验证所有者
      case 2:
        return 'Low Risk';
      case 3:
        return 'Medium Risk';
      case 4:
        return 'High Risk';
      case 5:
        return 'Very High Risk';
      default:
        return 'Unknown Risk';
    }
  }

  /// 释放资源。
  void dispose() {
    // 在这个新的架构中，Service是无状态的，通常不需要 dispose。
    // 这个方法可以保留为空，或在未来用于清理可能添加的 StreamSubscription 等。
    debugPrint('DeletionProposalService: Service disposed.');
  }
}