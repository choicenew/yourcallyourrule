import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yourcallyourrule/features/common/value_objects/phone_number.dart';
import 'package:yourcallyourrule/features/labels/data/repositories/label_mark_statistics_repository.dart';

part 'label_mark_statistics_service.g.dart';

/// LabelMarkStatisticsService �?@Riverpod Provider
@Riverpod(keepAlive: true)
LabelMarkStatisticsService labelMarkStatisticsService(Ref ref) {
  final repository = ref.watch(labelMarkStatisticsRepositoryProvider);
  return LabelMarkStatisticsService(repository);
}








/// 标记统计服务�?
/// 负责统计用户标记号码的次数，并提供相关的统计功能
class LabelMarkStatisticsService {
  final LabelMarkStatisticsRepository _repository;
  
  // 单例实例
  static LabelMarkStatisticsService? _instance;
  
  // 工厂构造函�?
  factory LabelMarkStatisticsService(LabelMarkStatisticsRepository repository) {
    _instance ??= LabelMarkStatisticsService._internal(repository);
    return _instance!;
  }
  
  // 私有构造函�?
  LabelMarkStatisticsService._internal(this._repository);
  
  // 获取标记�?
  Stream<int> get markCountStream => _repository.markCountStream;
  
  // 记录标记
  Future<bool> recordMark(PhoneNumber phoneNumber, String labelId) {
    return _repository.recordMark(phoneNumber, labelId);
  }
  
  // 获取当前标记计数
  Future<int> getMarkCount() {
    return _repository.getMarkCount();
  }
  
  // 重置标记计数
  Future<void> resetMarkCount() {
    return _repository.resetMarkCount();
  }
  
  // 获取所有标记记�?
  Future<List<dynamic>> getAllMarks() {
    return _repository.getAll();
  }
  
  // 释放资源
  void dispose() {
    _repository.dispose();
  }
}