import 'dart:convert';
import 'package:uuid/uuid.dart';
import 'package:drift/drift.dart' hide Column; // hide Column to avoid name clash
import 'package:yourcallyourrule/data/database/remote/remote_database.dart';
import 'package:yourcallyourrule/features/deletion_proposal/data/proposal_datasource.dart';
import 'package:yourcallyourrule/features/deletion_proposal/domain/proposal.dart';
import 'package:yourcallyourrule/features/deletion_proposal/domain/proposal_status.dart';
import 'package:yourcallyourrule/features/deletion_proposal/models/proposal_history_item.dart';

class ProposalDataSourceImpl implements ProposalDataSource {
  final RemoteDatabase _db;

  ProposalDataSourceImpl(this._db);

  // --- 核心提议状态管理 (`active_deletion_proposals` 表) ---
  // (这部分是新的逻辑，用于管理本地状态，保持不变)
  @override
  Future<void> upsertDeletionProposal({
    required String phoneNumber,
    required String riskLevel,
    required bool isOwner,
    String? verificationReportJson,
  }) async {
    final now = DateTime.now().toIso8601String();
    await _db.transaction(() async {
      final existing = await (_db.select(_db.activeDeletionProposals)
            ..where((t) => t.phoneNumber.equals(phoneNumber)))
          .getSingleOrNull();

      if (existing == null) {
        await _db.into(_db.activeDeletionProposals).insert(
          ActiveDeletionProposalsCompanion.insert(
            phoneNumber: phoneNumber,
            proposalStartTime: now,
            highestRiskLevel: riskLevel,
            lastUpdated: now,
            status: Value(ProposalStatus.pending.name),
            proposalCount: const Value(1),
            verifiedOwnerCount: Value(isOwner ? 1 : 0),
            verificationReportJson: Value(verificationReportJson),
          ),
        );
      } else {
        final currentRiskLevel = existing.highestRiskLevel;
        final currentProposalCount = existing.proposalCount;
        final currentOwnerCount = existing.verifiedOwnerCount;

        String newRiskLevel = currentRiskLevel;
        if (riskLevel == 'Verified' || currentRiskLevel == 'Verified') {
          newRiskLevel = 'Verified';
        } else if (riskLevel == 'Low' && currentRiskLevel != 'Verified') {
          newRiskLevel = 'Low';
        }

        await (_db.update(_db.activeDeletionProposals)
              ..where((t) => t.phoneNumber.equals(phoneNumber)))
            .write(
          ActiveDeletionProposalsCompanion(
            proposalCount: Value(currentProposalCount + 1),
            verifiedOwnerCount: Value(currentOwnerCount + (isOwner ? 1 : 0)),
            highestRiskLevel: Value(newRiskLevel),
            lastUpdated: Value(now),
            verificationReportJson: Value(
              verificationReportJson ?? existing.verificationReportJson,
            ),
          ),
        );
      }
    });
  }

  @override
  Future<List<Proposal>> getActiveDeletionProposals() async {
    final rows = await (_db.select(_db.activeDeletionProposals)
          ..where((t) => t.status.equals(ProposalStatus.pending.name))
          ..orderBy([(t) => OrderingTerm.asc(t.proposalStartTime)]))
        .get();
    return rows.map((r) => Proposal.fromMap({
          'phoneNumber': r.phoneNumber,
          'proposalStartTime': r.proposalStartTime,
          'status': r.status,
          'highestRiskLevel': r.highestRiskLevel,
          'proposalCount': r.proposalCount,
          'verifiedOwnerCount': r.verifiedOwnerCount,
          'lastUpdated': r.lastUpdated,
          'verificationReportJson': r.verificationReportJson,
          'labelsJson': null,
        })).toList();
  }

  @override
  Future<List<Proposal>> getExpiredDeletionProposals(Duration timeout) async {
    final cutoffTime = DateTime.now().subtract(timeout).toIso8601String();
    final rows = await (_db.select(_db.activeDeletionProposals)
          ..where((t) => t.status.equals(ProposalStatus.pending.name))
          ..where((t) => t.proposalStartTime.isSmallerThanValue(cutoffTime)))
        .get();
    return rows.map((r) => Proposal.fromMap({
          'phoneNumber': r.phoneNumber,
          'proposalStartTime': r.proposalStartTime,
          'status': r.status,
          'highestRiskLevel': r.highestRiskLevel,
          'proposalCount': r.proposalCount,
          'verifiedOwnerCount': r.verifiedOwnerCount,
          'lastUpdated': r.lastUpdated,
          'verificationReportJson': r.verificationReportJson,
          'labelsJson': null,
        })).toList();
  }

  @override
  Future<void> updateDeletionProposalStatus(
    String phoneNumber,
    String status,
  ) async {
    final validStatus = ProposalStatus.fromString(status);
    await (_db.update(_db.activeDeletionProposals)
          ..where((t) => t.phoneNumber.equals(phoneNumber)))
        .write(
      ActiveDeletionProposalsCompanion(
        status: Value(validStatus.name),
        lastUpdated: Value(DateTime.now().toIso8601String()),
      ),
    );
  }

  @override
  Future<void> deleteDeletionProposal(String phoneNumber) async {
    await (_db.delete(_db.activeDeletionProposals)
          ..where((t) => t.phoneNumber.equals(phoneNumber)))
        .go();
  }

  @override
  Future<bool> hasActiveDeletionProposal(String phoneNumber) async {
    final row = await (_db.select(_db.activeDeletionProposals)
          ..where((t) => t.phoneNumber.equals(phoneNumber))
          ..where((t) => t.status.equals(ProposalStatus.pending.name)))
        .getSingleOrNull();
    return row != null;
  }

  @override
  Future<List<Proposal>> getActivePendingDeletionProposals() async {
    return getActiveDeletionProposals();
  }

  @override
  Future<void> cleanupCompletedDeletionProposals(
    Duration retentionPeriod,
  ) async {
    final cutoffTime =
        DateTime.now().subtract(retentionPeriod).toIso8601String();
    await (_db.delete(_db.activeDeletionProposals)
          ..where((t) => t.status.isNotIn([ProposalStatus.pending.name]))
          ..where((t) => t.lastUpdated.isSmallerThanValue(cutoffTime)))
        .go();
  }

  // --- 日志管理 (proposal_submissions, proposal_votes 表) ---
  @override
  Future<void> recordProposalSubmission({
    required String proposerId,
    required String phoneNumber,
  }) async {
    await _db.into(_db.proposalSubmissions).insert(
      ProposalSubmissionsCompanion.insert(
        id: const Uuid().v4(),
        proposerId: proposerId,
        phoneNumber: phoneNumber,
        submissionTime: DateTime.now().toIso8601String(),
      ),
    );
  }

  @override
  Future<int> countRecentProposals(String proposerId, DateTime since) async {
    final query = await _db.customSelect(
      'SELECT COUNT(*) AS cnt FROM proposal_submissions WHERE proposer_id = ? AND submission_time >= ?',
      variables: [
        Variable<String>(proposerId),
        Variable<String>(since.toIso8601String()),
      ],
      readsFrom: {_db.proposalSubmissions},
    ).getSingle();
    final cnt = query.data['cnt'] as int?;
    return cnt ?? 0;
  }

  @override
  Future<void> recordVote({
    required String voterId,
    required String proposalId,
  }) async {
    await _db.into(_db.proposalVotes).insert(
      ProposalVotesCompanion.insert(
        id: const Uuid().v4(),
        voterId: voterId,
        proposalId: proposalId,
        voteTime: DateTime.now().toIso8601String(),
        isConsumed: const Value(0),
      ),
    );
  }

  @override
  Future<int> countUnconsumedVotes(String voterId) async {
    final query = await _db.customSelect(
      'SELECT COUNT(*) AS cnt FROM proposal_votes WHERE voter_id = ? AND is_consumed = 0',
      variables: [Variable<String>(voterId)],
      readsFrom: {_db.proposalVotes},
    ).getSingle();
    final cnt = query.data['cnt'] as int?;
    return cnt ?? 0;
  }

  @override
  Future<void> consumeVotes(String voterId, int count) async {
    await _db.transaction(() async {
      final votes = await (_db.select(_db.proposalVotes)
            ..where((t) => t.voterId.equals(voterId))
            ..where((t) => t.isConsumed.equals(0))
            ..orderBy([(t) => OrderingTerm.asc(t.voteTime)])
            ..limit(count))
          .get();

      if (votes.length < count) {
        throw Exception('Not enough unconsumed votes');
      }
      if (votes.isEmpty) return;

      for (final v in votes) {
        await (_db.update(_db.proposalVotes)
              ..where((t) => t.id.equals(v.id)))
            .write(
          const ProposalVotesCompanion(
            isConsumed: Value(1),
          ),
        );
      }
    });
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
    await _db.into(_db.pendingOperations).insert(
      PendingOperationsCompanion.insert(
        id: const Uuid().v4(),
        entityId: phoneNumber,
        operation: operation,
        payload: Value(payload != null ? jsonEncode(payload) : null),
        timestamp: DateTime.now().toIso8601String(),
      ),
    );
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
    final rows = await (_db.select(_db.pendingOperations)
          ..where((t) => t.operation.equals('PROPOSE_DELETION'))
          ..orderBy([(t) => OrderingTerm.asc(t.timestamp)]))
        .get();
    return rows
        .map((r) => {
              'id': r.id,
              'entityId': r.entityId,
              'operation': r.operation,
              'payload': r.payload != null ? jsonDecode(r.payload!) : null,
              'timestamp': r.timestamp,
            })
        .toList();
  }

  @override
  Future<List<Map<String, dynamic>>> getPendingDeletionVotes() async {
    final rows = await (_db.select(_db.pendingOperations)
          ..where((t) => t.operation.equals('VOTE_DELETION'))
          ..orderBy([(t) => OrderingTerm.asc(t.timestamp)]))
        .get();
    return rows
        .map((r) => {
              'id': r.id,
              'entityId': r.entityId,
              'operation': r.operation,
              'payload': r.payload != null ? jsonDecode(r.payload!) : null,
              'timestamp': r.timestamp,
            })
        .toList();
  }

  @override
  Future<bool> hasPendingDeletionProposal(String phoneNumber) async {
    final row = await (_db.select(_db.pendingOperations)
          ..where((t) => t.operation.equals('PROPOSE_DELETION'))
          ..where((t) => t.entityId.equals(phoneNumber)))
        .getSingleOrNull();
    return row != null;
  }

  @override
  Future<void> clearDeletionOperations(String phoneNumber) async {
    await (_db.delete(_db.pendingOperations)
          ..where((t) => t.entityId.equals(phoneNumber))
          ..where((t) => t.operation.isIn(['PROPOSE_DELETION', 'VOTE_DELETION'])))
        .go();
  }


  // =======================================================================
  // 【核心修正】: `getProposalInfo` 的实现现在正确地查询 `active_deletion_proposals` 并返回 `Proposal` 对象。
  // =======================================================================
  @override
  Future<Proposal?> getProposalInfo(String phoneNumber) async {
    final r = await (_db.select(_db.activeDeletionProposals)
          ..where((t) => t.phoneNumber.equals(phoneNumber)))
        .getSingleOrNull();
    if (r == null) return null;
    return Proposal.fromMap({
      'phoneNumber': r.phoneNumber,
      'proposalStartTime': r.proposalStartTime,
      'status': r.status,
      'highestRiskLevel': r.highestRiskLevel,
      'proposalCount': r.proposalCount,
      'verifiedOwnerCount': r.verifiedOwnerCount,
      'lastUpdated': r.lastUpdated,
      'verificationReportJson': r.verificationReportJson,
      'labelsJson': null,
    });
  }

  // =======================================================================
  // 【核心修正】: `getPendingProposalOperationInfo` 实现了原来查询 `pending_operations` 的逻辑。
  // REASON: 职责清晰，这个方法只为内部同步逻辑服务，不应该暴露给 Service 层。
  // =======================================================================
  @override
  Future<Map<String, dynamic>?> getPendingProposalOperationInfo(String phoneNumber) async {
    try {
      final row = await (_db.select(_db.pendingOperations)
            ..where((t) => t.entityId.equals(phoneNumber))
            ..where((t) => t.operation.equals('PROPOSE_DELETION')))
          .getSingleOrNull();

      if (row != null) {
        final String? payloadStr = row.payload;
        if (payloadStr != null) {
          return jsonDecode(payloadStr) as Map<String, dynamic>;
        }
      }
      return null;
    } catch (e) {
      // 保持错误处理，但不抛出以避免上层崩溃
      return null;
    }
  }




  // =======================================================================
  // 【新增实现】: 聚合查询逻辑
  // =======================================================================
  @override
  Future<List<MyProposalHistoryItem>> getMyProposalHistory(String deviceId) async {
    // 1. 获取我所有的提交记录 (按时间倒序)
    final submissions = await (_db.select(_db.proposalSubmissions)
          ..where((t) => t.proposerId.equals(deviceId))
          ..orderBy([(t) => OrderingTerm.desc(t.submissionTime)]))
        .get();

    if (submissions.isEmpty) return [];

    // 2. 提取所有涉及的电话号码，准备批量查询
    final phoneNumbers = submissions.map((s) => s.phoneNumber).toSet();

    // 3. 批量查询：待同步队列 (Pending)
    final pendingRows = await (_db.select(_db.pendingOperations)
          ..where((t) => t.entityId.isIn(phoneNumbers))
          ..where((t) => t.operation.equals('PROPOSE_DELETION')))
        .get();
    final pendingSet = pendingRows.map((r) => r.entityId).toSet();

    // 4. 批量查询：活跃提议 (Active)
    final activeRows = await (_db.select(_db.activeDeletionProposals)
          ..where((t) => t.phoneNumber.isIn(phoneNumbers)))
        .get();
    // 转为 Map 方便查找详情
    final activeMap = {for (var row in activeRows) row.phoneNumber: row};

    // 5. 批量查询：远程号码表 (RemoteNumbers) - 用于判断是否被拒绝
    final existingNumbersRows = await (_db.select(_db.remoteNumbers)
          ..where((t) => t.phoneNumber.isIn(phoneNumbers)))
        .get();
    final existingNumbersSet = existingNumbersRows.map((r) => r.phoneNumber).toSet();

    // 6. 组装最终结果
    final List<MyProposalHistoryItem> historyList = [];

    for (final sub in submissions) {
      final phone = sub.phoneNumber;
      MyProposalStatus status;
      String? riskLevel;
      int votes = 0;
      int owners = 0;

      // --- 状态判定逻辑 ---
      if (pendingSet.contains(phone)) {
        // 还在本地 Pending 队列
        status = MyProposalStatus.waitingForSync;
      } else if (activeMap.containsKey(phone)) {
        // 服务器已接收，正在投票
        status = MyProposalStatus.underReview;
        final activeData = activeMap[phone]!;
        riskLevel = activeData.highestRiskLevel;
        votes = activeData.proposalCount;
        owners = activeData.verifiedOwnerCount;
      } else {
        // 既不在 Pending 也不在 Active，说明流程结束
        if (existingNumbersSet.contains(phone)) {
          // 号码还在 -> 提议被驳回
          status = MyProposalStatus.rejected;
        } else {
          // 号码没了 -> 提议通过 (删除成功)
          status = MyProposalStatus.approved;
        }
      }

      historyList.add(MyProposalHistoryItem(
        phoneNumber: phone,
        submissionTime: DateTime.parse(sub.submissionTime),
        status: status,
        highestRiskLevel: riskLevel,
        currentVotes: votes,
        verifiedOwnerCount: owners,
      ));
    }

    return historyList;
  }


}
