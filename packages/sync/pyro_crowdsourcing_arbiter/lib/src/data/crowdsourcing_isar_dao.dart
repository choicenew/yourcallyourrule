import 'dart:async';
import 'package:isar_community/isar.dart';
import '../domain/models/crowdsourced_item.dart';
import '../domain/models/crowdsourced_submission.dart';
import '../domain/models/crowdsourced_vote.dart';

/// 众包 Isar 数据访问层 (DAO)
class CrowdsourcingIsarDao {
  final Isar? _isar;
  final Map<String, CrowdsourcedItem> _memoryItems = {};
  final List<CrowdsourcedSubmission> _memorySubmissions = [];
  final List<CrowdsourcedVote> _memoryVotes = [];

  CrowdsourcingIsarDao([this._isar]);

  IsarCollection<CrowdsourcedItem>? get _itemsCollection =>
      (_isar != null && _isar.isOpen) ? _isar.collection<CrowdsourcedItem>() : null;

  IsarCollection<CrowdsourcedSubmission>? get _submissionsCollection =>
      (_isar != null && _isar.isOpen) ? _isar.collection<CrowdsourcedSubmission>() : null;

  IsarCollection<CrowdsourcedVote>? get _votesCollection =>
      (_isar != null && _isar.isOpen) ? _isar.collection<CrowdsourcedVote>() : null;

  /// 插入或更新众包项
  Future<void> upsertItem(CrowdsourcedItem item) async {
    final col = _itemsCollection;
    if (col != null) {
      await _isar!.writeTxn(() async {
        await col.putByCompositeKey(item);
      });
    } else {
      _memoryItems[item.compositeKey] = item;
    }
  }

  /// 按复合主键查询
  Future<CrowdsourcedItem?> getItemByCompositeKey(String compositeKey) async {
    final col = _itemsCollection;
    if (col != null) {
      return await col.getByCompositeKey(compositeKey);
    } else {
      return _memoryItems[compositeKey];
    }
  }

  /// 按业务域查询所有共识通过项
  Future<List<CrowdsourcedItem>> getConsensusItemsByDomain(String domain) async {
    final col = _itemsCollection;
    if (col != null) {
      return await col
          .where()
          .domainEqualTo(domain)
          .filter()
          .statusEqualTo(CrowdsourcedItemStatus.communityConsensus)
          .findAll();
    } else {
      return _memoryItems.values
          .where((i) => i.domain == domain && i.status == CrowdsourcedItemStatus.communityConsensus)
          .toList();
    }
  }

  /// 记录提交日志
  Future<void> recordSubmission(CrowdsourcedSubmission submission) async {
    final col = _submissionsCollection;
    if (col != null) {
      await _isar!.writeTxn(() async {
        await col.put(submission);
      });
    } else {
      _memorySubmissions.add(submission);
    }
  }

  /// 获取设备在指定窗口期内的提交次数 (用于限额控制)
  Future<int> getSubmissionCountInWindow({
    required String deviceId,
    required Duration window,
  }) async {
    final cutoff = DateTime.now().subtract(window);
    final col = _submissionsCollection;
    if (col != null) {
      return await col
          .filter()
          .proposerDeviceIdEqualTo(deviceId)
          .and()
          .submissionTimeGreaterThan(cutoff)
          .count();
    } else {
      return _memorySubmissions
          .where((s) => s.proposerDeviceId == deviceId && s.submissionTime.isAfter(cutoff))
          .length;
    }
  }

  /// 记录投票
  Future<void> recordVote(CrowdsourcedVote vote) async {
    final col = _votesCollection;
    if (col != null) {
      await _isar!.writeTxn(() async {
        await col.put(vote);
      });
    } else {
      _memoryVotes.add(vote);
    }
  }
}
