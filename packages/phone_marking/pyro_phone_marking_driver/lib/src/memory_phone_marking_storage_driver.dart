import 'package:flutter/foundation.dart';
import 'package:pyro_phone_marking_protocol/pyro_phone_marking_protocol.dart';

/// 真实内存级打标持久化驱动 (MemoryPhoneMarkingStorageDriver)
class MemoryPhoneMarkingStorageDriver implements PhoneMarkingStorageDriver {
  final Map<String, LabelPhoneEntry> _marks = {};

  MemoryPhoneMarkingStorageDriver();

  @override
  Future<LabelPhoneEntry?> getMarkByPhone(String phoneNumber) async {
    return _marks[phoneNumber];
  }

  @override
  Future<void> saveMark(LabelPhoneEntry entry) async {
    _marks[entry.phoneNumber] = entry;
    debugPrint('[MemoryMarkingDriver] 持久化保存打标: ${entry.phoneNumber} -> ${entry.labelId}');
  }

  @override
  Future<void> deleteMark(String entryId) async {
    _marks.removeWhere((key, value) => value.id == entryId);
  }

  @override
  Future<List<LabelPhoneEntry>> getAllMarks() async {
    return _marks.values.toList();
  }
}
