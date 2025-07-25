// 标记统计仓库类，作为服务层和数据源层之间的桥梁

import 'dart:async';

import '../datasources/local/local_label_mark_statistics_datasource.dart';
import '../models/label_mark_statistics_model.dart';
import '../../core/value_objects/phone_number.dart';

// 标记统计仓库接口
abstract class LabelMarkStatisticsRepository {
  // 获取标记流
  Stream<int> get markCountStream;
  
  // 记录标记
  Future<bool> recordMark(PhoneNumber phoneNumber, String labelId);
  
  // 获取当前标记计数
  Future<int> getMarkCount();
  
  // 重置标记计数
  Future<void> resetMarkCount();
  
  // 获取所有标记记录
  Future<List<LabelMarkRecordModel>> getAllMarks();
  
  // 释放资源
  void dispose();
}

// 标记统计仓库实现
class LabelMarkStatisticsRepositoryImpl implements LabelMarkStatisticsRepository {
  final LocalLabelMarkStatisticsDataSource _dataSource;
  
  // 单例实例
  static LabelMarkStatisticsRepositoryImpl? _instance;
  
  // 工厂构造函数
  factory LabelMarkStatisticsRepositoryImpl(LocalLabelMarkStatisticsDataSource dataSource) {
    _instance ??= LabelMarkStatisticsRepositoryImpl._internal(dataSource);
    return _instance!;
  }
  
  // 私有构造函数
  LabelMarkStatisticsRepositoryImpl._internal(this._dataSource);
  
  // 获取标记流
  @override
  Stream<int> get markCountStream => _dataSource.markCountStream;
  
  // 记录标记
  @override
  Future<bool> recordMark(PhoneNumber phoneNumber, String labelId) {
    return _dataSource.recordMark(phoneNumber.value, labelId);
  }
  
  // 获取当前标记计数
  @override
  Future<int> getMarkCount() {
    return _dataSource.getMarkCount();
  }
  
  // 重置标记计数
  @override
  Future<void> resetMarkCount() {
    return _dataSource.resetMarkCount();
  }
  
  // 获取所有标记记录
  @override
  Future<List<LabelMarkRecordModel>> getAllMarks() {
    return _dataSource.getAllMarks();
  }
  
  // 释放资源
  @override
  void dispose() {
    _dataSource.dispose();
  }
}