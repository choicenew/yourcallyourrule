import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/data/datasources/local/local_phone_rule_datasource.dart';
import '../basic_provider/database_service_provider.dart';

/// 本地电话规则数据源提供者
final localPhoneRuleDataSourceProvider = Provider<LocalPhoneRuleDataSource>((ref) {
  final databaseService = ref.watch(databaseServiceProvider);
  return databaseService.localPhoneRuleDataSource;
});