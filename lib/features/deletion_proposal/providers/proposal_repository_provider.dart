// file: lib/features/deletion_proposal/providers/proposal_repository_provider.dart

import 'package:riverpod_annotation/riverpod_annotation.dart';

// 引入您所有的 DataSource 和 Repository 实现
import 'package:yourcallyourrule/core/provider/basic_provider/database_service_provider.dart';
import 'package:yourcallyourrule/features/deletion_proposal/data/proposal_datasource.dart';
import 'package:yourcallyourrule/features/deletion_proposal/data/proposal_datasource_impl.dart';
import 'package:yourcallyourrule/features/deletion_proposal/domain/repositories/proposal_repository.dart';
import 'package:yourcallyourrule/features/deletion_proposal/data/repositories/proposal_repository_impl.dart';

part 'proposal_repository_provider.g.dart';

@riverpod
ProposalDataSource proposalDataSource(Ref ref) {
    // 1. 监视 databaseServiceProvider 以获取 DatabaseService 实例。
  final databaseService = ref.watch(databaseServiceProvider);
  
  // 2. 从 DatabaseService 中获取正确的 remoteDatabaseManager 实例。
 
  final remoteDatabaseManager = databaseService.remoteDatabaseManager;
  
  // 3. 创建并返回 ProposalDataSourceImpl 实例。
  return ProposalDataSourceImpl(remoteDatabaseManager);
  
  
}

@riverpod
ProposalRepository proposalRepository(Ref ref) {
  final dataSource = ref.watch(proposalDataSourceProvider);
  return ProposalRepositoryImpl(dataSource);
}