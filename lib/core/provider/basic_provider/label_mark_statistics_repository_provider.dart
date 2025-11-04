// 标记统计仓库提供者

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/provider/datasource/datasource_provider.dart';
import 'package:yourcallyourrule/data/repositories/label_mark_statistics_repository.dart';

// 标记统计仓库提供者
final labelMarkStatisticsRepositoryProvider =
    Provider<LabelMarkStatisticsRepository>((ref) {
      final localLabelMarkStatisticsDataSource = ref.watch(localLabelMarkStatisticsDataSourceProvider);
      return LabelMarkStatisticsRepositoryImpl(localLabelMarkStatisticsDataSource);
    });
