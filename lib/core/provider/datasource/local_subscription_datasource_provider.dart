import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/data/datasources/local/local_subscription_datasource.dart';
import '../basic_provider/database_service_provider.dart';

final localSubscriptionDataSourceProvider = Provider<LocalSubscriptionDataSource>((ref) {
  final databaseService = ref.watch(databaseServiceProvider);
  return databaseService.localSubscriptionDataSource;
});