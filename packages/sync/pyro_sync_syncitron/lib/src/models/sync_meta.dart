import 'package:isar_community/isar.dart';

part 'sync_meta.g.dart';

@collection
class SyncMeta {
  Id? id;

  @Index(unique: true)
  late String key;

  late String value;
}
