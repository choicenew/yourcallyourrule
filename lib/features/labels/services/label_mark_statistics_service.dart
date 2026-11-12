import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yourcallyourrule/features/common/value_objects/phone_number.dart';
import 'package:yourcallyourrule/features/labels/data/repositories/label_mark_statistics_repository.dart';

part 'label_mark_statistics_service.g.dart';

/// LabelMarkStatisticsService Riverpod Provider
@Riverpod(keepAlive: true)
LabelMarkStatisticsService labelMarkStatisticsService(Ref ref) {
  final repository = ref.watch(labelMarkStatisticsRepositoryProvider);
  return LabelMarkStatisticsService(repository);
}

/// 标记统计服务类
class LabelMarkStatisticsService {
  final LabelMarkStatisticsRepository _repository;

  static LabelMarkStatisticsService? _instance;

  factory LabelMarkStatisticsService(LabelMarkStatisticsRepository repository) {
    _instance ??= LabelMarkStatisticsService._internal(repository);
    return _instance!;
  }

  LabelMarkStatisticsService._internal(this._repository);

  Stream<int> get markCountStream => _repository.markCountStream;

  Future<bool> recordMark(PhoneNumber phoneNumber, String labelId) {
    return _repository.recordMark(phoneNumber, labelId);
  }

  Future<int> getMarkCount() {
    return _repository.getMarkCount();
  }

  Future<void> resetMarkCount() {
    return _repository.resetMarkCount();
  }

  Future<List<dynamic>> getAllMarks() {
    return _repository.getAll();
  }

  void dispose() {
    _repository.dispose();
  }
}
