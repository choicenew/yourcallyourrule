import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/cloud_sync/services/local_storage_service.dart';
import 'package:yourcallyourrule/data/database/local/local_database_manager.dart';

/// 提供LocalStorageService的Provider
final localStorageServiceProvider = Provider<LocalStorageService>((ref) {
  final dbManager = LocalDatabaseManagerImpl();
  return LocalStorageService(dbManager);
});