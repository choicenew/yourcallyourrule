import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/cloud_sync/services/local_storage_service.dart';
import 'package:yourcallyourrule/core/provider/database_provider/local_database_provider.dart';

/// 提供LocalStorageService的Provider
final localStorageServiceProvider = Provider<LocalStorageService>((ref) {
  final localDb = ref.watch(localDatabaseProvider);
  return LocalStorageService(localDb);
});