import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/provider/basic_provider/database_service_provider.dart';
import 'package:yourcallyourrule/data/datasources/local/local_predefined_label_datasource.dart';

final localPredefinedLabelDataSourceProvider = Provider<LocalPredefinedLabelDataSource>((ref) {
  final dbService = ref.watch(databaseServiceProvider);
  return dbService.localPredefinedLabelDataSource;
});