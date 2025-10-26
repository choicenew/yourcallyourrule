// VIP兑换服务类，用于处理VIP兑换的业务逻辑

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/data/database/local/local_database_manager.dart';
import 'package:yourcallyourrule/data/datasources/local/local_label_mark_statistics_datasource.dart';
import 'package:yourcallyourrule/data/repositories/label_mark_statistics_repository.dart';

// 标记统计服务提供者
final labelMarkStatisticsRepositoryProvider =
    Provider<LabelMarkStatisticsRepository>((ref) {
      return LabelMarkStatisticsRepositoryImpl(
        LocalLabelMarkStatisticsDataSource(LocalDatabaseManagerImpl()),
      );
    });
