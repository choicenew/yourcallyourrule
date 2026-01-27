import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plugindemo/core/provider/database_provider/local_database_provider.dart';
import 'package:plugindemo/data/datasources/local/local_plugin_datasource.dart';

// 本地数据源提供者 - 只保留插件相关的数据源
final localPluginDataSourceProvider = Provider<LocalPluginDataSource>((ref) {
  final localDatabase = ref.watch(localDatabaseProvider);
  return LocalPluginDataSource(localDatabase);
});