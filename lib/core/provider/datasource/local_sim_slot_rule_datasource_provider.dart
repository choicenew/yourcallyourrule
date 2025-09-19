import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/data/datasources/local/local_sim_slot_rule_datasource.dart';
import '../basic_provider/database_service_provider.dart';

/// SIM卡槽位规则本地数据源提供者
final localSimSlotRuleDataSourceProvider = Provider<LocalSimSlotRuleDataSource>((ref) {
  final databaseService = ref.watch(databaseServiceProvider);
  return databaseService.localSimSlotRuleDataSource;
});