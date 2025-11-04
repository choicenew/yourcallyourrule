import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:yourcallyourrule/data/database/remote/remote_database.dart';

final remoteDatabaseProvider = Provider<RemoteDatabase>((ref) {
  return RemoteDatabase();
});