import 'dart:async';

import 'package:yourcallyourrule/core/value_objects/phone_number.dart';
import 'package:yourcallyourrule/data/repositories/label_mark_statistics_repository.dart';

/// 删除提议统计服务类
/// 负责统计用户投票次数，并提供相关的统计功能
class DeletionProposalStatisticsService {
  final LabelMarkStatisticsRepository _repository;
  
  // 单例实例
  static DeletionProposalStatisticsService? _instance;
  
  // 工厂构造函数
  factory DeletionProposalStatisticsService(LabelMarkStatisticsRepository repository) {
    _instance ??= DeletionProposalStatisticsService._internal(repository);
    return _instance!;
  }
  
  // 私有构造函数
  DeletionProposalStatisticsService._internal(this._repository);
  
  // 获取投票流
  Stream<int> get voteCountStream => _repository.markCountStream;
  
  // 记录投票
  Future<bool> recordVote(String phoneNumber, bool support) {
    // 使用repository的recordMark方法，传入phoneNumber
    // 这里复用现有的统计基础设施
    return _repository.recordMark(
      PhoneNumber.fromString(phoneNumber), 
      support ? 'support' : 'oppose'
    );
  }
  
  // 获取当前投票计数
  Future<int> getVoteCount() {
    return _repository.getMarkCount();
  }
  
  // 重置投票计数
  Future<void> resetVoteCount() {
    return _repository.resetMarkCount();
  }
  
  // 获取所有投票记录
  Future<List<dynamic>> getAllVotes() {
    return _repository.getAll();
  }
  
  // 释放资源
  void dispose() {
    _repository.dispose();
  }
}