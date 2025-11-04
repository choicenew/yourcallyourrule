import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/provider/database_provider/local_database_provider.dart';
import 'package:yourcallyourrule/core/provider/database_provider/remote_database_provider.dart';
import 'package:yourcallyourrule/data/datasources/local/local_call_log_datasource.dart';
import 'package:yourcallyourrule/data/datasources/local/local_contact_datasource.dart';
import 'package:yourcallyourrule/data/datasources/local/local_label_datasource.dart';
import 'package:yourcallyourrule/data/datasources/local/local_label_mark_statistics_datasource.dart';
import 'package:yourcallyourrule/data/datasources/local/local_location_datasource.dart';
import 'package:yourcallyourrule/data/datasources/local/local_phone_rule_datasource.dart';
import 'package:yourcallyourrule/data/datasources/local/local_plugin_datasource.dart';
import 'package:yourcallyourrule/data/datasources/local/local_predefined_label_datasource.dart';
import 'package:yourcallyourrule/data/datasources/local/local_regex_rule_datasource.dart';
import 'package:yourcallyourrule/data/datasources/local/local_sim_slot_rule_datasource.dart';
import 'package:yourcallyourrule/data/datasources/local/local_sms_datasource.dart';
import 'package:yourcallyourrule/data/datasources/local/local_sms_regex_rule_datasource.dart';
import 'package:yourcallyourrule/data/datasources/local/local_subscription_datasource.dart';
import 'package:yourcallyourrule/data/datasources/remote/remote_number_datasource.dart';



// 本地数据源提供者
final localCallLogDataSourceProvider = Provider<LocalCallLogDataSource>((ref) {
  final localDatabase = ref.watch(localDatabaseProvider);
  return LocalCallLogDataSource(localDatabase);
});

final localContactDataSourceProvider = Provider<LocalContactDataSource>((ref) {
  final localDatabase = ref.watch(localDatabaseProvider);
  return LocalContactDataSource(localDatabase);
});

final localLabelDataSourceProvider = Provider<LocalLabelDataSource>((ref) {
  final localDatabase = ref.watch(localDatabaseProvider);
  return LocalLabelDataSource(localDatabase);
});

final localLabelMarkStatisticsDataSourceProvider = Provider<LocalLabelMarkStatisticsDataSource>((ref) {
  final localDatabase = ref.watch(localDatabaseProvider);
  return LocalLabelMarkStatisticsDataSource(localDatabase);
});

final localLocationDataSourceProvider = Provider<LocalLocationDataSource>((ref) {
  final localDatabase = ref.watch(localDatabaseProvider);
  return LocalLocationDataSource(localDatabase);
});

final localPhoneRuleDataSourceProvider = Provider<LocalPhoneRuleDataSource>((ref) {
  final localDatabase = ref.watch(localDatabaseProvider);
  return LocalPhoneRuleDataSource(localDatabase);
});

final localPluginDataSourceProvider = Provider<LocalPluginDataSource>((ref) {
  final localDatabase = ref.watch(localDatabaseProvider);
  return LocalPluginDataSource(localDatabase);
});

final localPredefinedLabelDataSourceProvider = Provider<LocalPredefinedLabelDataSource>((ref) {
  final localDatabase = ref.watch(localDatabaseProvider);
  return LocalPredefinedLabelDataSource(localDatabase);
});

final localRegexRuleDataSourceProvider = Provider<LocalRegexRuleDataSource>((ref) {
  final localDatabase = ref.watch(localDatabaseProvider);
  return LocalRegexRuleDataSource(localDatabase);
});

final localSimSlotRuleDataSourceProvider = Provider<LocalSimSlotRuleDataSource>((ref) {
  final localDatabase = ref.watch(localDatabaseProvider);
  return LocalSimSlotRuleDataSource(localDatabase);
});

final localSmsDataSourceProvider = Provider<LocalSmsDataSource>((ref) {
  final localDatabase = ref.watch(localDatabaseProvider);
  return LocalSmsDataSource(localDatabase);
});

final localSmsRegexRuleDataSourceProvider = Provider<LocalSmsRegexRuleDataSource>((ref) {
  final localDatabase = ref.watch(localDatabaseProvider);
  return LocalSmsRegexRuleDataSource(localDatabase);
});

final localSubscriptionDataSourceProvider = Provider<LocalSubscriptionDataSource>((ref) {
  final localDatabase = ref.watch(localDatabaseProvider);
  return LocalSubscriptionDataSource(localDatabase);
});

// 远程数据源提供者
final remoteNumberDataSourceProvider = Provider<RemoteNumberDataSource>((ref) {
  final remoteDatabase = ref.watch(remoteDatabaseProvider);
  return RemoteNumberDataSource(remoteDatabase);
});