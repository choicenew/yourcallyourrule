import 'package:pyro_phone_marking_protocol/pyro_phone_marking_protocol.dart' hide PredefinedLabel;

/// 电话标签仓库接口
abstract class LabelPhoneRepository {
  Future<List<LabelPhoneEntry>> getAll();
  Future<LabelPhoneEntry?> getById(String id);
  Future<LabelPhoneEntry> saveLabel(LabelPhoneEntry entity);
  Future<LabelPhoneEntry> save(LabelPhoneEntry entity);
  Future<LabelPhoneEntry> updateLabel(LabelPhoneEntry entity);
  Future<LabelPhoneEntry> update(LabelPhoneEntry entity);
  Future<bool> delete(LabelPhoneEntry entity);
  Future<bool> deleteById(String id);
  Future<bool> deleteAll(List<LabelPhoneEntry> entities);
  Future<List<LabelPhoneEntry>> saveAllLabels(List<LabelPhoneEntry> entities);
  Future<List<LabelPhoneEntry>> saveAll(List<LabelPhoneEntry> entities);
  Future<bool> exists(String id);
  Future<int> count();
  LabelPhoneEntry fromMap(Map<String, dynamic> map);

  Future<LabelPhoneEntry?> getByName(String name);
  Future<List<LabelPhoneEntry>> getByType(String type);
  Future<bool> nameExists(String name);
  Future<List<LabelPhoneEntry>> getAllEnabled();
  Future<LabelPhoneEntry?> getByPhoneNumber(String phoneNumber);
  Future<List<LabelPhoneEntry>> getByLabelId(String labelId);
}
