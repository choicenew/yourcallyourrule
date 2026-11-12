import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yourcallyourrule/features/labels/data/repositories/label_mark_statistics_repository.dart'; 
import 'package:yourcallyourrule/features/common/value_objects/phone_number.dart';

part 'deletion_proposal_statistics_service.g.dart';

@riverpod
DeletionProposalStatisticsService deletionProposalStatisticsService(Ref ref) {
  final repository = ref.watch(labelMarkStatisticsRepositoryProvider);
  return DeletionProposalStatisticsService(repository);
}

class DeletionProposalStatisticsService {
  final LabelMarkStatisticsRepository _repository;
  
  DeletionProposalStatisticsService(this._repository);

  Stream<int> get voteCountStream => _repository.markCountStream;
  
  Future<bool> recordVote(String phoneNumber, bool support) {
    return _repository.recordMark(
      PhoneNumber.fromString(phoneNumber), 
      support ? 'support' : 'oppose'
    );
  }
  
  Future<int> getVoteCount() {
    return _repository.getMarkCount();
  }
  
  Future<void> resetVoteCount() {
    return _repository.resetMarkCount();
  }
  
  Future<List<dynamic>> getAllVotes() {
    return _repository.getAll();
  }
}
