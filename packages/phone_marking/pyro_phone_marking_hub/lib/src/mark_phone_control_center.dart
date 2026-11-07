import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_phone_marking_protocol/pyro_phone_marking_protocol.dart';

part 'mark_phone_control_center.g.dart';

@Riverpod(keepAlive: true)
MarkPhoneControlCenter markPhoneControlCenter(Ref ref) {
  return MarkPhoneControlCenter.instance;
}

/// 用户号码打标控制中心 (MarkPhoneControlCenter)
class MarkPhoneControlCenter {
  static final MarkPhoneControlCenter instance = MarkPhoneControlCenter._();

  MarkPhoneControlCenter._();

  PhoneMarkingStorageDriver? _storageDriver;

  void registerStorageDriver(PhoneMarkingStorageDriver driver) {
    _storageDriver = driver;
    debugPrint('[PhoneMarkingHub] 已挂载注册存储驱动: ${driver.runtimeType}');
  }

  PhoneMarkingStorageDriver? get storageDriver => _storageDriver;

  Future<LabelPhoneEntry?> getMarkByPhone(String phoneNumber) async {
    return await _storageDriver?.getMarkByPhone(phoneNumber);
  }

  Future<void> saveMark(LabelPhoneEntry entry) async {
    await _storageDriver?.saveMark(entry);
    debugPrint('[PhoneMarkingHub] 用户已打标: ${entry.phoneNumber} -> ${entry.labelId}');
  }
}
