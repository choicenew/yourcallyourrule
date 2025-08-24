import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/data/datasources/local/local_location_datasource.dart';
import '../basic_provider/database_service_provider.dart';

final localLocationDataSourceProvider = Provider<LocalLocationDataSource>((ref) {
  final databaseService = ref.watch(databaseServiceProvider);
  return databaseService.localLocationDataSource;
});