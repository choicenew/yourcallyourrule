import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/data/database/remote/remote_database_manager.dart';
import 'package:yourcallyourrule/data/datasources/remote/remote_number_datasource.dart';

/// 远程号码数据源提供者
final remoteNumberDataSourceProvider = Provider<RemoteNumberDataSource>((ref) {
  final dbManager = RemoteDatabaseManagerImpl();
  return RemoteNumberDataSource(dbManager);
});