import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:yourcallyourrule/data/database/database_manager.dart';
import '../../../data/datasources/remote/remote_number_datasource.dart';
import '../../../data/datasources/remote/proposal_datasource.dart';


/// 删除提议服务
/// 处理众包删除审核系统的业务逻辑
class DeletionProposalService {
  final RemoteNumberDataSource _remoteDataSource;
  final RemoteDatabaseManager _databaseManager;
  final ProposalDataSource _proposalDataSource;
  
  DeletionProposalService({
    required RemoteNumberDataSource remoteDataSource,
    required RemoteDatabaseManager databaseManager,
    required ProposalDataSource proposalDataSource,
  }) : _remoteDataSource = remoteDataSource,
       _databaseManager = databaseManager,
       _proposalDataSource = proposalDataSource;

  /// 提议删除号码
  /// [phoneNumber] 要删除的电话号码
  /// [reason] 删除原因
  /// [riskLevel] 风险等级 (1-5)
  /// [deviceId] 设备ID
  /// [userId] 用户ID (可选)
  /// 返回提议ID，如果失败返回null
  Future<String?> proposeDeletion({
    required String phoneNumber,
    required String reason,
    required int riskLevel,
    required String deviceId,
    String? userId,
  }) async {
    try {
      // 验证输入参数
      if (phoneNumber.isEmpty || reason.isEmpty) {
        debugPrint('DeletionProposalService: Invalid input parameters');
        return null;
      }
      
      if (riskLevel < 1 || riskLevel > 5) {
        debugPrint('DeletionProposalService: Invalid risk level: $riskLevel');
        return null;
      }

      // 检查是否已存在活跃的删除提议
      final hasActive = await _proposalDataSource.hasActiveDeletionProposal(phoneNumber);
      if (hasActive) {
        debugPrint('DeletionProposalService: Active deletion proposal already exists for $phoneNumber');
        return null;
      }

      // 检查号码是否存在
      final existingNumber = await _databaseManager.queryByPhoneNumber('remote_numbers', phoneNumber);
      if (existingNumber == null) {
        debugPrint('DeletionProposalService: Phone number not found: $phoneNumber');
        return null;
      }

      // 创建删除提议
      await _remoteDataSource.proposeDeletion(
        phoneNumber,
        {
          'reason': reason,
          'riskLevel': riskLevel,
          'deviceId': deviceId,
          'userId': userId,
        },
      );

      final proposalId = phoneNumber; // Use phoneNumber as proposalId
      debugPrint('DeletionProposalService: Created deletion proposal $proposalId for $phoneNumber');

      return proposalId;
    } catch (e) {
      debugPrint('DeletionProposalService: Error proposing deletion: $e');
      return null;
    }
  }

  /// 对删除提议投票
  /// [proposalId] 提议ID
  /// [support] 是否支持删除
  /// [deviceId] 设备ID
  /// [userId] 用户ID (可选)
  Future<bool> voteOnProposal({
    required String proposalId,
    required bool support,
    required String deviceId,
    String? userId,
  }) async {
    try {
      await _remoteDataSource.voteOnDeletionProposal(
        proposalId,
        support ? 'support' : 'oppose',
        {'deviceId': deviceId, 'userId': userId},
      );
      final success = true;

      if (success) {
        debugPrint('DeletionProposalService: Voted on proposal $proposalId: support=$support');
      }

      return success;
    } catch (e) {
      debugPrint('DeletionProposalService: Error voting on proposal: $e');
      return false;
    }
  }

  /// 获取待处理的删除提议列表（从远程数据源）
  /// [limit] 限制返回数量
  Future<List<Map<String, dynamic>>> _getPendingProposalsFromRemote({int limit = 50}) async {
    try {
      final allProposals = await _remoteDataSource.getPendingDeletionProposals();
      final proposals = allProposals.take(limit).toList();
      debugPrint('DeletionProposalService: Retrieved ${proposals.length} pending proposals from remote');
      return proposals;
    } catch (e) {
      debugPrint('DeletionProposalService: Error getting pending proposals from remote: $e');
      return [];
    }
  }

  /// 获取用户的待处理投票
  /// [deviceId] 设备ID
  /// [userId] 用户ID (可选)
  Future<List<Map<String, dynamic>>> getPendingVotes({
    required String deviceId,
    String? userId,
  }) async {
    try {
      final votes = await _remoteDataSource.getPendingDeletionVotes();
      debugPrint('DeletionProposalService: Retrieved ${votes.length} pending votes');
      return votes;
    } catch (e) {
      debugPrint('DeletionProposalService: Error getting pending votes: $e');
      return [];
    }
  }

  /// 检查号码是否有待处理的删除提议
  /// [phoneNumber] 电话号码
  Future<bool> hasPendingProposal(String phoneNumber) async {
    try {
      return await _remoteDataSource.hasPendingDeletionProposal(phoneNumber);
    } catch (e) {
      debugPrint('DeletionProposalService: Error checking pending proposal: $e');
      return false;
    }
  }

  /// 获取特定删除提议的详细信息
  /// [phoneNumber] 电话号码
  Future<Map<String, dynamic>?> getProposalDetails(String phoneNumber) async {
    try {
      return await _proposalDataSource.getProposalInfo(phoneNumber);
    } catch (e) {
      debugPrint('DeletionProposalService: Error getting proposal details: $e');
      return null;
    }
  }

  /// 清理已完成的删除操作
  /// 清理本地缓存的已处理提议和投票
  Future<void> cleanupCompletedOperations([String? phoneNumber]) async {
    try {
      if (phoneNumber != null) {
        await _remoteDataSource.clearDeletionOperations(phoneNumber);
      }
      await _proposalDataSource.cleanupCompletedDeletionProposals(const Duration(days: 30));
      debugPrint('DeletionProposalService: Cleaned up completed operations');
    } catch (e) {
      debugPrint('DeletionProposalService: Error cleaning up operations: $e');
    }
  }

  /// 获取所有删除提议
  /// 返回提议列表
  Future<List<Map<String, dynamic>>> getProposals() async {
    try {
      return await getPendingProposals();
    } catch (e) {
      debugPrint('DeletionProposalService: Error getting proposals: $e');
      return [];
    }
  }

  /// 获取待处理的删除提议
  /// 返回待处理提议列表
  Future<List<Map<String, dynamic>>> getPendingProposals() async {
    try {
      final proposals = await _proposalDataSource.getPendingDeletionProposals();
      debugPrint('DeletionProposalService: Retrieved ${proposals.length} pending proposals');
      return proposals;
    } catch (e) {
      debugPrint('DeletionProposalService: Error getting pending proposals: $e');
      return [];
    }
  }

  /// 获取删除提议统计信息
  /// 返回包含各种统计数据的Map
  Future<Map<String, int>> getProposalStatistics() async {
    try {
      final pendingProposals = await getPendingProposals();
      final statistics = <String, int>{
        'totalPending': pendingProposals.length,
        'highRisk': pendingProposals.where((p) => (p['risk_level'] as int?) == 5).length,
        'mediumRisk': pendingProposals.where((p) {
          final risk = p['risk_level'] as int?;
          return risk != null && risk >= 3 && risk <= 4;
        }).length,
        'lowRisk': pendingProposals.where((p) {
          final risk = p['risk_level'] as int?;
          return risk != null && risk >= 1 && risk <= 2;
        }).length,
      };
      
      debugPrint('DeletionProposalService: Statistics - $statistics');
      return statistics;
    } catch (e) {
      debugPrint('DeletionProposalService: Error getting statistics: $e');
      return {
        'totalPending': 0,
        'highRisk': 0,
        'mediumRisk': 0,
        'lowRisk': 0,
      };
    }
  }

  /// 验证删除提议的有效性
  /// [phoneNumber] 电话号码
  /// [reason] 删除原因
  /// [riskLevel] 风险等级
  bool validateProposal({
    required String phoneNumber,
    required String reason,
    required int riskLevel,
  }) {
    // 验证电话号码格式
    if (phoneNumber.isEmpty || phoneNumber.length < 7) {
      return false;
    }

    // 验证删除原因
    if (reason.isEmpty || reason.length < 10) {
      return false;
    }

    // 验证风险等级
    if (riskLevel < 1 || riskLevel > 5) {
      return false;
    }

    return true;
  }

  /// 获取风险等级描述
  /// [riskLevel] 风险等级 (1-5)
  String getRiskLevelDescription(int riskLevel) {
    switch (riskLevel) {
      case 1:
        return 'Very Low Risk';
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

  /// 释放资源
  void dispose() {
    // 清理任何需要释放的资源
    debugPrint('DeletionProposalService: Service disposed');
  }
}