import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

import 'package:pyro_phone_marking_protocol/pyro_phone_marking_protocol.dart';
import 'package:yourcallyourrule/features/labels/data/datasources/local_label_datasource.dart';

part 'mark_phone_service.g.dart';

/// LabelPhoneService 的 @Riverpod Provider
@Riverpod(keepAlive: true)
LabelPhoneService markPhoneService(Ref ref) {
  final dataSource = ref.watch(localLabelDataSourceProvider);
  return LabelPhoneService(dataSource);
}

/// 电话号码标签服务类
class LabelPhoneService {
  final LocalLabelDataSource _dataSource;
  final Uuid _uuid = const Uuid();

  LabelPhoneService(this._dataSource);

  /// 标记电话号码
  Future<LabelPhoneEntry> markPhone(String phoneNumber, String labelId, {
    String? name,
    String? avatar,
    String? icon,
    int priority = 10,
    String action = 'block',
    bool isEnabled = true,
  }) async {
    final entry = LabelPhoneEntry(
      id: _uuid.v4(),
      name: name ?? '',
      phoneNumber: phoneNumber,
      labelId: labelId,
      avatar: avatar,
      icon: icon,
      priority: priority,
      action: action,
      isEnabled: isEnabled,
    );

    await _dataSource.insert(entry);
    return entry;
  }

  /// 更新电话号码标记
  Future<void> updatePhoneMark(LabelPhoneEntry entry) async {
    await _dataSource.update(entry);
  }

  /// 删除电话号码标记
  Future<void> removePhoneMark(String entryId) async {
    await _dataSource.delete(entryId);
  }

  /// 获取所有电话号码标记
  Future<List<LabelPhoneEntry>> getAllPhoneMarks() async {
    return await _dataSource.getAll();
  }

  /// 根据电话号码获取标记
  Future<LabelPhoneEntry?> getLabelByPhoneNumber(String phoneNumber) async {
    final marks = await _dataSource.getByPhoneNumber(phoneNumber);
    return marks.isNotEmpty ? marks.first : null;
  }

  /// 根据标签ID获取所有标记
  Future<List<LabelPhoneEntry>> getMarksByLabelId(String labelId) async {
    return await _dataSource.getByLabelId(labelId);
  }

  /// 检查电话号码是否已标记
  Future<bool> isPhoneMarked(String phoneNumber) async {
    final mark = await getLabelByPhoneNumber(phoneNumber);
    return mark != null;
  }
}
