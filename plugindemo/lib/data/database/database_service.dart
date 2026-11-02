import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:plugindemo/data/database/local/local_database.dart';
import 'package:plugindemo/data/datasources/local/local_plugin_datasource.dart';

part 'database_service.g.dart';

@Riverpod(keepAlive: true)
DatabaseService databaseService(Ref ref) {
  return DatabaseService();
}

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();

  late final LocalDatabase localDatabase;
  late final LocalPluginDataSource localPluginDataSource;

  DatabaseService._internal() {
    localDatabase = LocalDatabase();
    localPluginDataSource = LocalPluginDataSource(localDatabase);
  }

  factory DatabaseService() {
    return _instance;
  }
}
