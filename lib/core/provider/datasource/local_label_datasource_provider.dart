import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/data/datasources/local/local_label_datasource.dart';
import '../basic_provider/database_service_provider.dart';

final localLabelDataSourceProvider = Provider<LocalLabelDataSource>((ref) {
  final databaseService = ref.watch(databaseServiceProvider);
  return databaseService.localLabelDataSource;
});