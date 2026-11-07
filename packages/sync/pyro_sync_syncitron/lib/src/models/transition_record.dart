import 'package:isar_community/isar.dart';

part 'transition_record.g.dart';

@collection
class TransitionRecord {
  Id? id;

  @Index()
  late String table;

  @Index()
  late String recordId;

  late String payloadJson;

  late bool isSynced;

  String? operationId;

  DateTime? updatedAt;
}
