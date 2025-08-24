import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/provider/basic_provider/database_service_provider.dart';
import 'package:yourcallyourrule/data/datasources/local/local_contact_datasource.dart';

final localContactDataSourceProvider = Provider<LocalContactDataSource>((ref) {
  final databaseService = ref.watch(databaseServiceProvider);
  return databaseService.localContactDataSource;
});