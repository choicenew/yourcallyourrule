import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notification_manager/data/services/backup_restore_service_impl.dart';
import 'package:notification_manager/domain/services/backup_restore_service.dart';

final backupRestoreServiceProvider = Provider<BackupRestoreService>((ref) {
  final service = BackupRestoreServiceImpl();
  // Initialize the service
  service.initialize({});
  return service;
});