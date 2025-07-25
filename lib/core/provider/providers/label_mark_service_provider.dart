import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:yourcallyourrule/features/labels/services/label_mark_statistics_service.dart';
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



/// 标记计数提供者
final labelMarkCountProvider = StreamProvider<int>((ref) {
  final statisticsService = ref.watch(labelMarkStatisticsServiceProvider);
  return statisticsService.markCountStream;
});

/// 当前标记计数提供者
final currentLabelMarkCountProvider = FutureProvider<int>((ref) async {
  final statisticsService = ref.watch(labelMarkStatisticsServiceProvider);
  return await statisticsService.getMarkCount();
});