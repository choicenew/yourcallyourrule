import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:yourcallyourrule/features/labels/data/datasources/local_label_mark_statistics_datasource.dart';
import 'package:yourcallyourrule/features/labels/domain/label_mark_record_model.dart';
import 'package:yourcallyourrule/features/common/value_objects/phone_number.dart';

part 'label_mark_statistics_repository.g.dart';

@Riverpod(keepAlive: true)
LabelMarkStatisticsRepository labelMarkStatisticsRepository(Ref ref) {
  final localLabelMarkStatisticsDataSource = ref.watch(localLabelMarkStatisticsDataSourceProvider);
  return LabelMarkStatisticsRepositoryImpl(localLabelMarkStatisticsDataSource);
}

abstract class LabelMarkStatisticsRepository {
  Stream<int> get markCountStream;
  Future<bool> recordMark(PhoneNumber phoneNumber, String labelId);
  Future<int> getMarkCount();
  Future<void> resetMarkCount();
  Future<List<LabelMarkRecordModel>> getAll();
  void dispose();
}

class LabelMarkStatisticsRepositoryImpl implements LabelMarkStatisticsRepository {
  final LocalLabelMarkStatisticsDataSource _dataSource;
  
  static LabelMarkStatisticsRepositoryImpl? _instance;
  
  factory LabelMarkStatisticsRepositoryImpl(LocalLabelMarkStatisticsDataSource dataSource) {
    _instance ??= LabelMarkStatisticsRepositoryImpl._internal(dataSource);
    return _instance!;
  }
  
  LabelMarkStatisticsRepositoryImpl._internal(this._dataSource);
  
  @override
  Stream<int> get markCountStream => _dataSource.markCountStream;
  
  @override
  Future<bool> recordMark(PhoneNumber phoneNumber, String labelId) {
    return _dataSource.recordMark(phoneNumber.value, labelId);
  }
  
  @override
  Future<int> getMarkCount() {
    return _dataSource.getMarkCount();
  }
  
  @override
  Future<void> resetMarkCount() {
    return _dataSource.resetMarkCount();
  }
  
  @override
  Future<List<LabelMarkRecordModel>> getAll() {
    return _dataSource.getAll();
  }
  
  @override
  void dispose() {
    _dataSource.dispose();
  }
}
