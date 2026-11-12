import 'package:pyro_phone_marking_protocol/pyro_phone_marking_protocol.dart';

abstract class PredefinedLabelRepository {
  Future<void> save(PredefinedLabel label);
  Future<void> saveAll(List<PredefinedLabel> labels);
  Future<void> update(PredefinedLabel label);
  Future<void> delete(String id);
  Future<List<PredefinedLabel>> getAll();
  Future<PredefinedLabel?> getById(String id);
  Future<List<PredefinedLabel>> getByText(String text);
  Future<String?> getIdByText(String text);
  Future<String?> getLabelTextAsync(String id);
}
