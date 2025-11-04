import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:yourcallyourrule/data/database/local/local_database.dart';

final localDatabaseProvider = Provider<LocalDatabase>((ref) {
  return LocalDatabase();
});