import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:plugindemo/data/database/local/local_database.dart';

final localDatabaseProvider = Provider<LocalDatabase>((ref) {
  return LocalDatabase();
});