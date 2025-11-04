import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:yourcallyourrule/core/provider/database_provider/remote_database_provider.dart';
import 'package:yourcallyourrule/data/datasources/remote/remote_number_datasource.dart';

/// 远程号码数据源提供者
final remoteNumberDataSourceProvider = Provider<RemoteNumberDataSource>((ref) {
  final dbManager = ref.watch(remoteDatabaseProvider);
  return RemoteNumberDataSource(dbManager);
});