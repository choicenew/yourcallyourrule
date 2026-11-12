import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_phone_remote_filter_protocol/pyro_phone_remote_filter_protocol.dart';
import 'package:yourcallyourrule/features/common/value_objects/phone_number.dart';
import 'package:yourcallyourrule/data/database/remote/remote_data_access_restriction.dart';
import '../../../sync/services/cloud_sync/incremental_sync_manager.dart';
import '../../../sync/services/cloud_sync/sync_conflict_resolver.dart';
import 'package:yourcallyourrule/features/config/data/repositories/config_repository.dart';
import 'package:yourcallyourrule/features/remote_filter/data/datasources/remote_number_datasource.dart';

part 'remote_number_repository_impl.g.dart';

/// 远程号码仓库提供者
@Riverpod(keepAlive: true)
RemoteNumberRepositoryImpl remoteNumberRepository(Ref ref) {
  final remoteNumberDataSource = ref.watch(remoteNumberDataSourceProvider);
  final remoteDataAccessRestriction = ref.watch(remoteDataAccessRestrictionProvider);
  final configRepository = ref.watch(configRepositoryProvider);
  final incrementalSyncManager = IncrementalSyncManager(SyncConflictResolver(), configRepository: configRepository);

  return RemoteNumberRepositoryImpl(
    remoteNumberDataSource,
    remoteDataAccessRestriction,
    incrementalSyncManager,
  );
}

class RemoteNumberRepositoryImpl {
  final RemoteNumberDataSource _dataSource;
  final RemoteDataAccessRestriction _remoteDataAccess;
  final IncrementalSyncManager _syncManager;

  RemoteNumberRepositoryImpl(
    this._dataSource,
    this._remoteDataAccess,
    this._syncManager,
  );

  RemoteNumberEntry fromMap(Map<String, dynamic> map) {
    return RemoteNumberEntry.fromMap(map);
  }

  Future<List<RemoteNumberEntry>> getAll() async {
    return await _dataSource.getAll();
  }

  Future<RemoteNumberEntry?> getById(String id) async {
    return await _dataSource.getById(id);
  }

  Future<RemoteNumberEntry> save(
    RemoteNumberEntry entity, {
    String? countryIsoCode,
  }) async {
    await _dataSource.insert(entity, countryIsoCode: countryIsoCode);
    return entity;
  }

  Future<RemoteNumberEntry> addRemoteNumber(
    RemoteNumberEntry entity, {
    String? countryIsoCode,
  }) async {
    return await save(entity, countryIsoCode: countryIsoCode);
  }

  Future<List<RemoteNumberEntry>> saveAll(
    List<RemoteNumberEntry> entities,
  ) async {
    if (entities.isEmpty) {
      return [];
    }
    await _dataSource.insertAll(entities);
    return entities;
  }

  Future<RemoteNumberEntry> update(
    RemoteNumberEntry entity, {
    String? countryIsoCode,
  }) async {
    await _dataSource.update(entity, countryIsoCode: countryIsoCode);
    return entity;
  }

  Future<RemoteNumberEntry> updateRemoteNumber(
    RemoteNumberEntry entity, {
    String? countryIsoCode,
  }) async {
    return await update(entity, countryIsoCode: countryIsoCode);
  }

  Future<bool> delete(RemoteNumberEntry entity) async {
    return await deleteById(entity.phoneNumber);
  }

  Future<bool> deleteById(String id) async {
    final result = await _dataSource.delete(id);
    return result > 0;
  }

  Future<RemoteNumberEntry?> getByPhoneNumber(PhoneNumber phoneNumber) async {
    final remoteNumberInfo = await _remoteDataAccess.queryRemoteNumberInfo(
      phoneNumber.value,
    );
    if (remoteNumberInfo != null) {
      return await _dataSource.getByPhoneNumber(phoneNumber.value);
    }
    return null;
  }

  Future<RemoteNumberEntry?> getRemoteNumberByPhoneNumber(
    PhoneNumber phoneNumber,
  ) async {
    return await getByPhoneNumber(phoneNumber);
  }

  Future<bool> isInRemoteNumbers(PhoneNumber phoneNumber) async {
    final entry = await getByPhoneNumber(phoneNumber);
    return entry != null;
  }

  Future<bool> deleteAll(List<RemoteNumberEntry> entities) async {
    if (entities.isEmpty) {
      return true;
    }
    final phoneNumbers = entities.map((e) => e.phoneNumber).toList();
    final result = await _dataSource.deleteAll(phoneNumbers);
    return result > 0;
  }

  Future<bool> exists(String id) async {
    final entry = await getById(id);
    return entry != null;
  }

  Future<int> count() async {
    final entries = await getAll();
    return entries.length;
  }

  Future<Map<String, dynamic>?> queryRemoteNumberInfo(
    String phoneNumberStr,
  ) async {
    return await _remoteDataAccess.queryRemoteNumberInfo(phoneNumberStr);
  }

  Future<bool> syncRemoteNumbers() async {
    try {
      final hasPermission = await _remoteDataAccess.checkAccessPermission(
        'sync',
      );
      if (!hasPermission) {
        return false;
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<RemoteNumberEntry?> incrementCount(PhoneNumber phoneNumber) async {
    final entry = await getByPhoneNumber(phoneNumber);
    if (entry != null) {
      await _dataSource.atomicIncrementCount(entry.phoneNumber, 1);
      return entry;
    }
    return null;
  }

  Future<void> linkNumberToCountry(
    String phoneNumber,
    String countryIsoCode,
  ) async {
    await _dataSource.linkNumberToCountry(phoneNumber, countryIsoCode);
  }
}
