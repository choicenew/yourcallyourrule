import 'dart:async';

import 'package:yourcallyourrule/core/entities/label/label_phone_entry.dart';
import 'package:yourcallyourrule/core/value_objects/phone_number.dart';
import 'package:yourcallyourrule/features/labels/services/label_mark_statistics_service.dart';
import 'package:yourcallyourrule/features/labels/services/predefined_label_service.dart';

/// 标签标记统计同步服务类
/// 负责监听标签电话条目流并记录标记统计
/// 类似于LabelToRemoteSyncService，但专门用于标记统计
class LabelMarkStatisticsSyncService {
  final LabelMarkStatisticsService _statisticsService;
  final PredefinedLabelService _predefinedLabelService;
  StreamSubscription<dynamic>? _dataSubscription;

  LabelMarkStatisticsSyncService(
    this._statisticsService,
    this._predefinedLabelService,
  );

  /// 开始监听标签电话条目流并记录标记统计
  void startSync(Stream<LabelPhoneEntry> labelPhoneEntryStream) {
    _dataSubscription?.cancel();
    
    _dataSubscription = labelPhoneEntryStream.listen(_handleLabelData);
  }

  /// 处理单个标签数据并记录标记统计
  Future<void> syncSingleLabel(LabelPhoneEntry labelPhoneEntry) async {
    await _handleLabelData(labelPhoneEntry);
  }

  /// 处理标签数据并记录标记统计
  Future<void> _handleLabelData(LabelPhoneEntry labelPhoneEntry) async {
    // 获取电话号码
    final phoneNumber = labelPhoneEntry.phoneNumber;
    
    // 获取标签ID
    final labelId = labelPhoneEntry.labelId;
    
    // 获取预定义标签信息
    final predefinedLabel = await _predefinedLabelService.getLabelById(labelId);
    
    // 如果标签不是"unknown"，则记录标记统计
    if (predefinedLabel != null && predefinedLabel.text.toLowerCase() != 'unknown') {
      await _statisticsService.recordMark(phoneNumber, labelId);
    }
  }

  /// 停止同步
  void stopSync() {
    _dataSubscription?.cancel();
    _dataSubscription = null;
  }

  /// 释放资源
  void dispose() {
    stopSync();
  }
}