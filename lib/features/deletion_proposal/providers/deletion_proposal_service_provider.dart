import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:yourcallyourrule/core/provider/basic_provider/database_service_provider.dart';
import 'package:yourcallyourrule/data/datasources/remote/proposal_datasource.dart';
import 'package:yourcallyourrule/features/deletion_proposal/services/deletion_proposal_service.dart';

/// ProposalDataSource的Provider
/// 用于在应用中提供ProposalDataSource的实例
final proposalDataSourceProvider = Provider<ProposalDataSource>((ref) {
  final databaseService = ref.watch(databaseServiceProvider);
  return ProposalDataSource(databaseService.remoteDatabaseManager);
});

/// DeletionProposalService的Provider
/// 用于在应用中提供DeletionProposalService的实例
final deletionProposalServiceProvider = Provider<DeletionProposalService>((ref) {
  final databaseService = ref.watch(databaseServiceProvider);
  final proposalDataSource = ref.watch(proposalDataSourceProvider);
  final service = DeletionProposalService(
    databaseManager: databaseService.remoteDatabaseManager,
    remoteDataSource: databaseService.remoteNumberDataSource,
    proposalDataSource: proposalDataSource,
  );
  
  // 当provider被销毁时，释放服务资源
  ref.onDispose(() {
    service.dispose();
  });
  
  return service;
});