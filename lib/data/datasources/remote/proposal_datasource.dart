import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';
import 'package:yourcallyourrule/data/database/database_manager.dart';

/// 提议数据源类，负责处理与删除提议相关的数据操作
class ProposalDataSource {
  final RemoteDatabaseManager _databaseManager;

  ProposalDataSource(this._databaseManager);

  /// 创建或更新删除提议
  Future<void> upsertDeletionProposal({
    required String phoneNumber,
    required String riskLevel,
    required bool isOwner,
  }) async {
    final db = await _databaseManager.database;
    final now = DateTime.now().toIso8601String();
    
    await db.transaction((txn) async {
      final existing = await txn.query(
        'active_deletion_proposals',
        where: 'phoneNumber = ?',
        whereArgs: [phoneNumber],
        limit: 1,
      );
      
      if (existing.isEmpty) {
        // 创建新的删除提议
        await txn.insert('active_deletion_proposals', {
          'phoneNumber': phoneNumber,
          'proposal_start_time': now,
          'status': 'pending',
          'highest_risk_level': riskLevel,
          'proposal_count': 1,
          'verified_owner_count': isOwner ? 1 : 0,
          'last_updated': now,
        });
      } else {
        // 更新现有的删除提议
        final current = existing.first;
        final currentRiskLevel = current['highest_risk_level'] as String;
        final currentProposalCount = current['proposal_count'] as int;
        final currentOwnerCount = current['verified_owner_count'] as int;
        
        // 确定最高风险等级
        String newRiskLevel = currentRiskLevel;
        if (riskLevel == 'Verified' || currentRiskLevel == 'Verified') {
          newRiskLevel = 'Verified';
        } else if (riskLevel == 'Low' && currentRiskLevel != 'Verified') {
          newRiskLevel = 'Low';
        }
        
        await txn.update(
          'active_deletion_proposals',
          {
            'proposal_count': currentProposalCount + 1,
            'verified_owner_count': currentOwnerCount + (isOwner ? 1 : 0),
            'highest_risk_level': newRiskLevel,
            'last_updated': now,
          },
          where: 'phoneNumber = ?',
          whereArgs: [phoneNumber],
        );
      }
    });
  }

  /// 获取所有待处理的删除提议
  Future<List<Map<String, dynamic>>> getActiveDeletionProposals() async {
    final db = await _databaseManager.database;
    return await db.query(
      'active_deletion_proposals',
      where: 'status = ?',
      whereArgs: ['pending'],
      orderBy: 'proposal_start_time ASC',
    );
  }

  /// 获取过期的删除提议
  Future<List<Map<String, dynamic>>> getExpiredDeletionProposals(Duration timeout) async {
    final db = await _databaseManager.database;
    final cutoffTime = DateTime.now().subtract(timeout).toIso8601String();
    
    return await db.query(
      'active_deletion_proposals',
      where: 'status = ? AND proposal_start_time < ?',
      whereArgs: ['pending', cutoffTime],
      orderBy: 'proposal_start_time ASC',
    );
  }

  /// 更新删除提议状态
  Future<void> updateDeletionProposalStatus(String phoneNumber, String status) async {
    final db = await _databaseManager.database;
    await db.update(
      'active_deletion_proposals',
      {
        'status': status,
        'last_updated': DateTime.now().toIso8601String(),
      },
      where: 'phoneNumber = ?',
      whereArgs: [phoneNumber],
    );
  }

  /// 删除删除提议记录
  Future<void> deleteDeletionProposal(String phoneNumber) async {
    final db = await _databaseManager.database;
    await db.delete(
      'active_deletion_proposals',
      where: 'phoneNumber = ?',
      whereArgs: [phoneNumber],
    );
  }

  /// 检查号码是否有活跃的删除提议
  Future<bool> hasActiveDeletionProposal(String phoneNumber) async {
    try {
      final db = await _databaseManager.database;
      final result = await db.query(
        'active_deletion_proposals',
        where: 'phoneNumber = ? AND status = ?',
        whereArgs: [phoneNumber, 'pending'],
        limit: 1,
      );
      return result.isNotEmpty;
    } catch (e) {
      print('ProposalDataSource: Error checking active deletion proposal: $e');
      return false;
    }
  }

  /// 获取所有待处理的删除提议
  Future<List<Map<String, dynamic>>> getPendingDeletionProposals() async {
    try {
      final db = await _databaseManager.database;
      final activeProposals = await getActiveDeletionProposals();
      
      return activeProposals.map((row) {
        // 处理验证报告数据
        dynamic verificationReport;
        if (row.containsKey('verificationReportJson') && row['verificationReportJson'] != null) {
          try {
            verificationReport = row['verificationReportJson'];
          } catch (e) {
            print('ProposalDataSource: Error handling verification report: $e');
            verificationReport = null;
          }
        }
        
        return {
          'phoneNumber': row['phoneNumber'],
          'reason': 'Unknown',
          'risk_level': row['highest_risk_level'] == 'Verified' ? 5 : 3,
          'created_at': row['proposal_start_time'],
          'support_count': row['proposal_count'] ?? 0,
          'oppose_count': 0,
          'status': row['status'],
          'proposalId': row['phoneNumber'],
          'verification_report': verificationReport,
        };
      }).toList();
    } catch (e) {
      print('ProposalDataSource: Error getting pending deletion proposals: $e');
      return [];
    }
  }

  /// 获取提议信息，包括验证报告
  Future<Map<String, dynamic>?> getProposalInfo(String phoneNumber) async {
    try {
      final db = await _databaseManager.database;
      final result = await db.query(
        'active_deletion_proposals',
        where: 'phoneNumber = ?',
        whereArgs: [phoneNumber],
        limit: 1,
      );
      
      if (result.isNotEmpty) {
        return result.first;
      }
      return null;
    } catch (e) {
      print('ProposalDataSource: Error getting proposal info: $e');
      return null;
    }
  }

  /// 清理已完成的删除提议
  Future<void> cleanupCompletedDeletionProposals(Duration retentionPeriod) async {
    try {
      final db = await _databaseManager.database;
      final cutoffTime = DateTime.now().subtract(retentionPeriod).toIso8601String();
      
      await db.delete(
        'active_deletion_proposals',
        where: 'status != ? AND last_updated < ?',
        whereArgs: ['pending', cutoffTime],
      );
    } catch (e) {
      print('ProposalDataSource: Error cleaning up completed proposals: $e');
    }
  }

  // --- 新增方法，用于处理提议提交和投票日志 ---

  /// 记录提议提交
  Future<void> recordProposalSubmission({
    required String proposerId,
    required String phoneNumber,
  }) async {
    final db = await _databaseManager.database;
    await db.insert('proposal_submissions', {
      'id': const Uuid().v4(),
      'proposer_id': proposerId,
      'phone_number': phoneNumber,
      'submission_time': DateTime.now().toIso8601String(),
    });
  }

  /// 记录投票
  Future<void> recordVote({
    required String voterId,
    required String proposalId,
  }) async {
    final db = await _databaseManager.database;
    await db.insert('proposal_votes', {
      'id': const Uuid().v4(),
      'voter_id': voterId,
      'proposal_id': proposalId,
      'vote_time': DateTime.now().toIso8601String(),
      'is_consumed': 0,
    });
  }

  /// 统计用户最近的提议数量
  Future<int> countRecentProposals(String proposerId, DateTime since) async {
    final db = await _databaseManager.database;
    final result = await db.rawQuery(
      'SELECT COUNT(*) FROM proposal_submissions WHERE proposer_id = ? AND submission_time >= ?',
      [proposerId, since.toIso8601String()],
    );
    return Sqflite.firstIntValue(result) ?? 0;
  }

  /// 统计用户未消费的投票数
  Future<int> countUnconsumedVotes(String voterId) async {
    final db = await _databaseManager.database;
    final result = await db.rawQuery(
      'SELECT COUNT(*) FROM proposal_votes WHERE voter_id = ? AND is_consumed = 0',
      [voterId],
    );
    return Sqflite.firstIntValue(result) ?? 0;
  }

  /// 消费投票（将投票标记为已消费）
  Future<void> consumeVotes(String voterId, int count) async {
    final db = await _databaseManager.database;
    
    // 获取未消费的投票
    final votes = await db.query(
      'proposal_votes',
      where: 'voter_id = ? AND is_consumed = 0',
      whereArgs: [voterId],
      orderBy: 'vote_time ASC',
      limit: count,
    );
    
    if (votes.length < count) {
      throw Exception('Not enough unconsumed votes'); // This error message will be handled by the service layer
    }
    
    // 批量更新投票状态
    final batch = db.batch();
    for (final vote in votes) {
      batch.update(
        'proposal_votes',
        {'is_consumed': 1},
        where: 'id = ?',
        whereArgs: [vote['id']],
      );
    }
    
    await batch.commit(noResult: true);
  }
}