import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/data/datasources/local/local_sms_regex_rule_datasource.dart';
import 'package:yourcallyourrule/core/provider/basic_provider/database_service_provider.dart';

final localSmsRegexRuleDataSourceProvider = Provider<LocalSmsRegexRuleDataSource>((ref) {
  final databaseService = ref.watch(databaseServiceProvider);
  return databaseService.localSmsRegexRuleDataSource;
});