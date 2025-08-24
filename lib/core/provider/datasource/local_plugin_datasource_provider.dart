import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/provider/basic_provider/database_service_provider.dart';
import 'package:yourcallyourrule/data/datasources/local/local_plugin_datasource.dart';



/// 本地插件数据源提供者
final localPluginDataSourceProvider = Provider<LocalPluginDataSource>((ref) {
  final databaseService = ref.watch(databaseServiceProvider);
  return databaseService.localPluginDataSource;
});