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

  Future<void> upsertItem(CrowdsourcedItem item) async {
    if (_isar != null && _isar.isOpen) {
      await _isar.writeTxn(() async {
        await _isar.crowdsourcedItems.putByCompositeKey(item);
      });
    } else {
      _memoryItems[item.compositeKey] = item;
    }
  }

  Future<CrowdsourcedItem?> getItemByCompositeKey(String compositeKey) async {
    if (_isar != null && _isar.isOpen) {
      return await _isar.crowdsourcedItems.getByCompositeKey(compositeKey);
    } else {
      return _memoryItems[compositeKey];
    }
  }

  Future<List<CrowdsourcedItem>> getConsensusItemsByDomain(String domain) async {
    if (_isar != null && _isar.isOpen) {
      return await _isar.crowdsourcedItems
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

  Future<void> recordSubmission(CrowdsourcedSubmission submission) async {
    if (_isar != null && _isar.isOpen) {
      await _isar.writeTxn(() async {
        await _isar.crowdsourcedSubmissions.put(submission);
      });
    } else {
      _memorySubmissions.add(submission);
    }
  }

  Future<int> getSubmissionCountInWindow({
    required String deviceId,
    required Duration window,
  }) async {
    final cutoff = DateTime.now().subtract(window);
    if (_isar != null && _isar.isOpen) {
      return await _isar.crowdsourcedSubmissions
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

  Future<void> recordVote(CrowdsourcedVote vote) async {
    if (_isar != null && _isar.isOpen) {
      await _isar.writeTxn(() async {
        await _isar.crowdsourcedVotes.put(vote);
      });
    } else {
      _memoryVotes.add(vote);
    }
  }
}
