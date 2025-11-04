import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:yourcallyourrule/features/labels/services/label_mark_statistics_service.dart';
import 'package:yourcallyourrule/data/repositories/label_mark_statistics_repository.dart';
import '../datasource/datasource_provider.dart';

/// 标记统计服务提供者
final labelMarkStatisticsServiceProvider = Provider<LabelMarkStatisticsService>((ref) {
  final localLabelMarkStatisticsDataSource = ref.watch(localLabelMarkStatisticsDataSourceProvider);
  final repository = LabelMarkStatisticsRepositoryImpl(localLabelMarkStatisticsDataSource);
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