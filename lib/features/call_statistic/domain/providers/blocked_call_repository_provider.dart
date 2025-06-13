import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/features/call_statistic/domain/repositories/blocked_call_repository.dart';

/// 拦截记录仓库的Provider
/// 用于在应用中提供BlockedCallRepository的实例
final blockedCallRepositoryProvider = Provider<BlockedCallRepository>((ref) {
  return BlockedCallRepository();
});