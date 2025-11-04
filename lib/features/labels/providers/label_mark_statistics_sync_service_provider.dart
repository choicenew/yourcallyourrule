import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/provider/providers/predefined_label_service_provider.dart';
import 'package:yourcallyourrule/core/provider/basic_provider/label_mark_statistics_repository_provider.dart';
import 'package:yourcallyourrule/features/labels/services/label_mark_statistics_service.dart';
import 'package:yourcallyourrule/features/labels/services/label_mark_statistics_sync_service.dart';

/// 标记统计服务提供者
final labelMarkStatisticsServiceProvider = Provider<LabelMarkStatisticsService>((ref) {
  final repository = ref.watch(labelMarkStatisticsRepositoryProvider);
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