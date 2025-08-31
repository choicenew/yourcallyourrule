import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/data/datasources/local/local_regex_rule_datasource.dart';
import '../basic_provider/database_service_provider.dart';

/// 本地正则规则数据源提供者
final localRegexRuleDataSourceProvider = Provider<LocalRegexRuleDataSource>((ref) {
  final databaseService = ref.watch(databaseServiceProvider);
  return databaseService.localRegexRuleDataSource;
});