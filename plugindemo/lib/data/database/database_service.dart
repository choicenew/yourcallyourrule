// 数据库服务类，用于管理数据库的初始化和提供数据源访问

import 'package:plugindemo/data/database/local/local_database.dart';
import 'package:plugindemo/data/datasources/local/local_plugin_datasource.dart';

// 数据库服务类
class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  
  // Drift 数据库实例
  late final LocalDatabase localDatabase;
  
  // 数据源 - 只保留插件相关的数据源
  late final LocalPluginDataSource localPluginDataSource;
  
  // 私有构造函数
  DatabaseService._internal() {
    localDatabase = LocalDatabase();
    
    // 初始化数据源 - 只保留插件相关的数据源
    localPluginDataSource = LocalPluginDataSource(localDatabase);
  }
  
  // 工厂构造函数
  factory DatabaseService() {
    return _instance;
  }
}