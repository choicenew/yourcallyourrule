import 'package:yourcallyourrule/features/call_statistic/domain/repositories/blocked_call_repository.dart';

abstract class CallStatisticsRepository {
  Future<List<BlockedCall>> getBlockedCalls();
  Future<void> addBlockedCall(String phoneNumber);
}