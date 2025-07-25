import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/provider/providers/predefined_label_service_provider.dart';

import 'package:yourcallyourrule/features/labels/services/label_mark_statistics_service.dart';
import 'package:yourcallyourrule/features/labels/services/label_mark_statistics_sync_service.dart';
import 'package:yourcallyourrule/data/repositories/label_mark_statistics_repository.dart';
import 'package:yourcallyourrule/data/datasources/local/local_label_mark_statistics_datasource.dart';
import 'package:yourcallyourrule/data/database/local/local_database_manager.dart';

/// 标记统计服务提供者
final labelMarkStatisticsServiceProvider = Provider<LabelMarkStatisticsService>((ref) {
  final repository = LabelMarkStatisticsRepositoryImpl(
    LocalLabelMarkStatisticsDataSource(LocalDatabaseManagerImpl())
  );
  return LabelMarkStatisticsService(repository);
});

/// 标记统计同步服务提供者
final labelMarkStatisticsSyncServiceProvider = Provider<LabelMarkStatisticsSyncService>((ref) {
  final statisticsService = ref.watch(labelMarkStatisticsServiceProvider);
  final predefinedLabelService = ref.watch(predefinedLabelServiceProvider);
  
  return LabelMarkStatisticsSyncService(
    statisticsService,
    predefinedLabelService,
  );
});