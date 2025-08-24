import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/data/datasources/local/local_call_log_datasource.dart';
import '../basic_provider/database_service_provider.dart';

final localCallLogDataSourceProvider = Provider<LocalCallLogDataSource>((ref) {
  final databaseService = ref.watch(databaseServiceProvider);
  return databaseService.localCallLogDataSource;
});