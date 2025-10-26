import 'dart:convert';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';
import 'package:yourcallyourrule/data/database/database_manager.dart';
import 'package:yourcallyourrule/features/deletion_proposal/data/proposal_datasource.dart';
import 'package:yourcallyourrule/features/deletion_proposal/domain/proposal.dart';
import 'package:yourcallyourrule/features/deletion_proposal/domain/proposal_status.dart';

class ProposalDataSourceImpl implements ProposalDataSource {
  final RemoteDatabaseManager _databaseManager;
  static const String _pendingOperationsTable = 'pending_operations';
  static const String _activeProposalsTable = 'active_deletion_proposals';

  ProposalDataSourceImpl(this._databaseManager);

  // --- 核心提议状态管理 (`active_deletion_proposals` 表) ---
  // (这部分是新的逻辑，用于管理本地状态，保持不变)
  @override
  Future<void> upsertDeletionProposal({
    required String phoneNumber,
    required String riskLevel,
    required bool isOwner,
    String? verificationReportJson,
  }) async {
    final db = await _databaseManager.database;
    final now = DateTime.now().toIso8601String();
    await db.transaction((txn) async {
      final existing = await txn.query(
        _activeProposalsTable,
        where: 'phoneNumber = ?',
        whereArgs: [phoneNumber],
        limit: 1,
      );
      if (existing.isEmpty) {
        await txn.insert(_activeProposalsTable, {
          'phoneNumber': phoneNumber,
          'proposal_start_time': now,
          'status': ProposalStatus.pending.name,
          'highest_risk_level': riskLevel,
          'proposal_count': 1,
          'verified_owner_count': isOwner ? 1 : 0,
          'last_updated': now,
          'verificationReportJson': verificationReportJson,
        });
      } else {
        final current = existing.first;
        final currentRiskLevel = current['highest_risk_level'] as String;
        final currentProposalCount = current['proposal_count'] as int;
        final currentOwnerCount = current['verified_owner_count'] as int;
        String newRiskLevel = currentRiskLevel;
        if (riskLevel == 'Verified' || currentRiskLevel == 'Verified') {
          newRiskLevel = 'Verified';
        } else if (riskLevel == 'Low' && currentRiskLevel != 'Verified') {
          newRiskLevel = 'Low';
        }
        await txn.update(
          _activeProposalsTable,
          {
            'proposal_count': currentProposalCount + 1,
            'verified_owner_count': currentOwnerCount + (isOwner ? 1 : 0),
            'highest_risk_level': newRiskLevel,
            'last_updated': now,
            'verificationReportJson':
                verificationReportJson ?? current['verificationReportJson'],
          },
          where: 'phoneNumber = ?',
          whereArgs: [phoneNumber],
        );
      }
    });
  }

  @override
  Future<List<Proposal>> getActiveDeletionProposals() async {
    final db = await _databaseManager.database;
    final maps = await db.query(
      _activeProposalsTable,
      where: 'status = ?',
      whereArgs: [ProposalStatus.pending.name],
      orderBy: 'proposal_start_time ASC',
    );
    return maps.map((map) => Proposal.fromMap(map)).toList();
  }

  @override
  Future<List<Proposal>> getExpiredDeletionProposals(Duration timeout) async {
    final db = await _databaseManager.database;
    final cutoffTime = DateTime.now().subtract(timeout).toIso8601String();
    final maps = await db.query(
      _activeProposalsTable,
      where: 'status = ? AND proposal_start_time < ?',
      whereArgs: [ProposalStatus.pending.name, cutoffTime],
    );
    return maps.map((map) => Proposal.fromMap(map)).toList();
  }

  @override
  Future<void> updateDeletionProposalStatus(
    String phoneNumber,
    String status,
  ) async {
    final db = await _databaseManager.database;
    final validStatus = ProposalStatus.fromString(status);
    await db.update(
      _activeProposalsTable,
      {
        'status': validStatus.name,
        'last_updated': DateTime.now().toIso8601String(),
      },
      where: 'phoneNumber = ?',
      whereArgs: [phoneNumber],
    );
  }

  @override
  Future<void> deleteDeletionProposal(String phoneNumber) async {
    final db = await _databaseManager.database;
    await db.delete(
      _activeProposalsTable,
      where: 'phoneNumber = ?',
      whereArgs: [phoneNumber],
    );
  }

  @override
  Future<bool> hasActiveDeletionProposal(String phoneNumber) async {
    final db = await _databaseManager.database;
    final result = await db.query(
      _activeProposalsTable,
      where: 'phoneNumber = ? AND status = ?',
      whereArgs: [phoneNumber, ProposalStatus.pending.name],
      limit: 1,
    );
    return result.isNotEmpty;
  }

  @override
  Future<List<Proposal>> getActivePendingDeletionProposals() async {
    return getActiveDeletionProposals();
  }

  @override
  Future<void> cleanupCompletedDeletionProposals(
    Duration retentionPeriod,
  ) async {
    final db = await _databaseManager.database;
    final cutoffTime =
        DateTime.now().subtract(retentionPeriod).toIso8601String();
    await db.delete(
      _activeProposalsTable,
      where: 'status != ? AND last_updated < ?',
      whereArgs: [ProposalStatus.pending.name, cutoffTime],
    );
  }

  // --- 日志管理 (proposal_submissions, proposal_votes 表) ---
  @override
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

  @override
  Future<int> countRecentProposals(String proposerId, DateTime since) async {
    final db = await _databaseManager.database;
    final result = await db.rawQuery(
      'SELECT COUNT(*) FROM proposal_submissions WHERE proposer_id = ? AND submission_time >= ?',
      [proposerId, since.toIso8601String()],
    );
    return Sqflite.firstIntValue(result) ?? 0;
  }

  @override
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

  @override
  Future<int> countUnconsumedVotes(String voterId) async {
    final db = await _databaseManager.database;
    final result = await db.rawQuery(
      'SELECT COUNT(*) FROM proposal_votes WHERE voter_id = ? AND is_consumed = 0',
      [voterId],
    );
    return Sqflite.firstIntValue(result) ?? 0;
  }

  @override
  Future<void> consumeVotes(String voterId, int count) async {
    final db = await _databaseManager.database;
    final votes = await db.query(
      'proposal_votes',
      where: 'voter_id = ? AND is_consumed = 0',
      whereArgs: [voterId],
      orderBy: 'vote_time ASC',
      limit: count,
    );
    if (votes.length < count) throw Exception('Not enough unconsumed votes');
    if (votes.isEmpty) return;
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

  // =======================================================================
  // 【核心修正】: 使用【原始函数名】完整地、无损地迁移了所有同步相关功能。
  // REASON: 这是对之前错误的彻底纠正，确保100%功能保留和可对照性。
  // =======================================================================

  // --- 操作日志与同步管理 (`pending_operations` 表) ---

  @override
  Future<void> logCustomOperation({
    required String operation,
    required String phoneNumber,
    Map<String, dynamic>? payload,
  }) async {
    final db = await _databaseManager.database;
    await db.insert(_pendingOperationsTable, {
      'id': const Uuid().v4(),
      'entityId': phoneNumber,
      'operation': operation,
      'payload': payload != null ? jsonEncode(payload) : null,
      'timestamp': DateTime.now().toIso8601String(),
    });
  }

  @override
  Future<void> proposeDeletion({
    required String phoneNumber,
    required Map<String, dynamic> report,
  }) async {
    await logCustomOperation(
      operation: 'PROPOSE_DELETION',
      phoneNumber: phoneNumber,
      payload: {
        'report': report,
        'timestamp': DateTime.now().toIso8601String(),
      },
    );
  }

  @override
  Future<void> voteOnDeletionProposal({
    required String phoneNumber,
    required String voteType,
    Map<String, dynamic>? additionalData,
  }) async {
    await logCustomOperation(
      operation: 'VOTE_DELETION',
      phoneNumber: phoneNumber,
      payload: {
        'voteType': voteType,
        'additionalData': additionalData,
        'timestamp': DateTime.now().toIso8601String(),
      },
    );
  }

  // 【注意】: 这个 getActivePendingDeletionProposals 与 核心状态管理中的同名方法有本质区别。
  // 这个版本查询的是 `pending_operations` 表，返回的是 `Map`，用于同步。
  // 为了区分，我们将其重命名为 `getPendingDeletionProposalOperations`。
  @override
  Future<List<Map<String, dynamic>>>
  getPendingDeletionProposalOperations() async {
    final db = await _databaseManager.database;
    return await db.query(
      _pendingOperationsTable,
      where: 'operation = ?',
      whereArgs: ['PROPOSE_DELETION'],
      orderBy: 'timestamp ASC',
    );
  }

  @override
  Future<List<Map<String, dynamic>>> getPendingDeletionVotes() async {
    final db = await _databaseManager.database;
    return await db.query(
      _pendingOperationsTable,
      where: 'operation = ?',
      whereArgs: ['VOTE_DELETION'],
      orderBy: 'timestamp ASC',
    );
  }

  @override
  Future<bool> hasPendingDeletionProposal(String phoneNumber) async {
    final db = await _databaseManager.database;
    final result = await db.query(
      _pendingOperationsTable,
      where: 'operation = ? AND entityId = ?',
      whereArgs: ['PROPOSE_DELETION', phoneNumber],
      limit: 1,
    );
    return result.isNotEmpty;
  }

  @override
  Future<void> clearDeletionOperations(String phoneNumber) async {
    final db = await _databaseManager.database;
    await db.delete(
      _pendingOperationsTable,
      where: 'entityId = ? AND (operation = ? OR operation = ?)',
      whereArgs: [phoneNumber, 'PROPOSE_DELETION', 'VOTE_DELETION'],
    );
  }


  // =======================================================================
  // 【核心修正】: `getProposalInfo` 的实现现在正确地查询 `active_deletion_proposals` 并返回 `Proposal` 对象。
  // =======================================================================
  @override
  Future<Proposal?> getProposalInfo(String phoneNumber) async {
    final db = await _databaseManager.database;
    final result = await db.query(
      _activeProposalsTable,
      where: 'phoneNumber = ?',
      whereArgs: [phoneNumber],
     
    );
    // 正确返回 Future<Proposal?>
    return result.isNotEmpty ? Proposal.fromMap(result.first) : null;
  }

  // =======================================================================
  // 【核心修正】: `getPendingProposalOperationInfo` 实现了原来查询 `pending_operations` 的逻辑。
  // REASON: 职责清晰，这个方法只为内部同步逻辑服务，不应该暴露给 Service 层。
  // =======================================================================
  @override
  Future<Map<String, dynamic>?> getPendingProposalOperationInfo(String phoneNumber) async {
    try {
      final db = await _databaseManager.database;
      final List<Map<String, dynamic>> proposals = await db.query(
        _pendingOperationsTable,
        where: 'entityId = ? AND operation = ?',
        whereArgs: [phoneNumber, 'PROPOSE_DELETION'],
      );

      if (proposals.isNotEmpty) {
        final proposal = proposals.first;
        final String? payloadStr = proposal['payload'] as String?;
        if (payloadStr != null) {
          return jsonDecode(payloadStr);
        }
      }
      return null;
    } catch (e) {
      print('ProposalDataSource: Error getting proposal info: $e');
      return null;
    }
  }
}
