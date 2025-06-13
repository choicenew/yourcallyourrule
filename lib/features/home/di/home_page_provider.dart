import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/features/home/di/home_stats_provider.dart';

/// HomePage的Provider
/// 用于在HomePage中获取HomeStats数据
final homePageProvider = Provider<void>((ref) {
  // 这个Provider主要是为了在HomePage中使用ref.watch(homeStatsProvider)
  // 不需要返回任何值
});