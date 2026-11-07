import 'package:pyro_phone_marking_protocol/src/models/label_phone_entry.dart';

/// 号码打标持久化 Driver 抽象接口契约 (PhoneMarkingStorageDriver)
abstract class PhoneMarkingStorageDriver {
  Future<LabelPhoneEntry?> getMarkByPhone(String phoneNumber);
  Future<void> saveMark(LabelPhoneEntry entry);
  Future<void> deleteMark(String entryId);
  Future<List<LabelPhoneEntry>> getAllMarks();
}
