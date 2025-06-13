import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/features/remote_filter/services/remote_number_service.dart';
import 'package:yourcallyourrule/core/provider/basic_provider/rule_repository_provider.dart';
import 'remote_data_access_provider.dart';

/// RemoteNumberService的Provider
final remoteNumberServiceProvider = Provider<RemoteNumberService>((ref) {
  final ruleRepository = ref.watch(ruleRepositoryProvider);
  final remoteDataAccess = ref.watch(remoteDataAccessProvider);
  return RemoteNumberService(ruleRepository, remoteDataAccess);
});