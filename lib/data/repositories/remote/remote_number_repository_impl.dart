import 'package:yourcallyourrule/core/entities/remote/remote_number_entry.dart';
import 'package:yourcallyourrule/core/repositories/base_repository.dart';
import 'package:yourcallyourrule/core/value_objects/phone_number.dart';
import 'package:yourcallyourrule/data/database/remote/remote_data_access_restriction.dart';
import 'package:yourcallyourrule/data/database/sync/incremental_sync_manager_remote_database.dart';
import 'package:yourcallyourrule/data/datasources/remote/remote_number_datasource.dart';
import 'package:yourcallyourrule/data/models/remote/remote_number_model.dart';

class RemoteNumberRepositoryImpl implements BaseRepository<RemoteNumberEntry, String> {
  final RemoteNumberDataSource _dataSource;
  final RemoteDataAccessRestriction _remoteDataAccess;
  final IncrementalSyncManager _syncManager;

  RemoteNumberRepositoryImpl(this._dataSource, this._remoteDataAccess, this._syncManager);

  @override
  RemoteNumberEntry fromMap(Map<String, dynamic> map) {
    return RemoteNumberEntry.fromMap(map);
  }

  @override
  Future<List<RemoteNumberEntry>> getAll() async {
    final models = await _dataSource.getAll();
    return models.map((model) => RemoteNumberEntry.fromMap(model.toMap())).toList();
  }

  @override
  Future<RemoteNumberEntry?> getById(String id) async {
    final model = await _dataSource.getById(id);
    if (model != null) {
      return RemoteNumberEntry.fromMap(model.toMap());
    }
    return null;
  }

  @override
  Future<RemoteNumberEntry> save(RemoteNumberEntry entity) async {
    final model = RemoteNumberModel.fromMap(entity.toMap());
    await _dataSource.insert(model);
    return entity;
  }

  @override
  Future<List<RemoteNumberEntry>> saveAll(List<RemoteNumberEntry> entities) async {
    if (entities.isEmpty) {
      return [];
    }
    final models = entities.map((e) => RemoteNumberModel.fromMap(e.toMap())).toList();
    await _dataSource.insertAll(models);
    return entities;
  }

  @override
  Future<RemoteNumberEntry> update(RemoteNumberEntry entity) async {
    final model = RemoteNumberModel.fromMap(entity.toMap());
    await _dataSource.update(model);
    return entity;
  }

  @override
  Future<bool> delete(RemoteNumberEntry entity) async {
    // 使用电话号码作为唯一标识进行删除，确保与数据源的主键一致
    return await deleteById(entity.phoneNumber.value);
  }

  @override
  Future<bool> deleteById(String id) async {
    final result = await _dataSource.delete(id);
    return result > 0;
  }

  Future<RemoteNumberEntry?> getByPhoneNumber(PhoneNumber phoneNumber) async {
    final remoteNumberInfo = await _remoteDataAccess.queryRemoteNumberInfo(phoneNumber.value);
    if (remoteNumberInfo != null) {
      final model = await _dataSource.getByPhoneNumber(phoneNumber.value);
      if (model != null) {
        return RemoteNumberEntry.fromMap(model.toMap());
      }
    }
    return null;
  }

  Future<RemoteNumberEntry?> getRemoteNumberByPhoneNumber(PhoneNumber phoneNumber) async {
    return await getByPhoneNumber(phoneNumber);
  }

  Future<bool> isInRemoteNumbers(PhoneNumber phoneNumber) async {
    final entry = await getByPhoneNumber(phoneNumber);
    return entry != null;
  }

  Future<bool> isCountExceeded(PhoneNumber phoneNumber, int threshold) async {
    final entry = await getByPhoneNumber(phoneNumber);
    if (entry != null) {
      return entry.isCountExceeded(threshold);
    }
    return false;
  }

  Future<bool> shouldAcceptBasedOnCount(PhoneNumber phoneNumber, int threshold) async {
    final entry = await getByPhoneNumber(phoneNumber);
    if (entry != null) {
      if (entry.isCountExceeded(threshold) && entry.action == 'block') {
        return false;
      }
      if (entry.isCountExceeded(threshold) && entry.action == 'allow') {
        return true;
      }
    }
    return true;
  }

  @override
  Future<bool> deleteAll(List<RemoteNumberEntry> entities) async {
    if (entities.isEmpty) {
      return true;
    }
    // 批量删除时按电话号码列表进行，匹配数据源的主键 phoneNumber
    final phoneNumbers = entities.map((e) => e.phoneNumber.value).toList();
    final result = await _dataSource.deleteAll(phoneNumbers);
    return result > 0;
  }

  @override
  Future<bool> exists(String id) async {
    final entry = await getById(id);
    return entry != null;
  }

  @override
  Future<int> count() async {
    final entries = await getAll();
    return entries.length;
  }

  Future<Map<String, dynamic>?> queryRemoteNumberInfo(String phoneNumberStr) async {
    return await _remoteDataAccess.queryRemoteNumberInfo(phoneNumberStr);
  }

  Future<bool> syncRemoteNumbers() async {
    try {
      final hasPermission = await _remoteDataAccess.checkAccessPermission('sync');
      if (!hasPermission) {
        return false;
      }
      final success = await _syncManager.syncIncremental();
      return success;
    } catch (e) {
      return false;
    }
  }

  Future<RemoteNumberEntry?> incrementCount(PhoneNumber phoneNumber) async {
    final entry = await getByPhoneNumber(phoneNumber);
    if (entry != null) {
      await _dataSource.atomicIncrementCount(entry.phoneNumber.value, 1);
      return entry.incrementCount();
    }
    return null;
  }

  Future<void> linkNumberToCountry(String phoneNumber, String countryIsoCode) async {
    await _dataSource.linkNumberToCountry(phoneNumber, countryIsoCode);
  }
}