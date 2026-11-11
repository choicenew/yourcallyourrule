import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_phone_remote_filter_protocol/pyro_phone_remote_filter_protocol.dart';
import 'package:yourcallyourrule/features/common/services/list_service.dart';
import 'package:yourcallyourrule/features/common/value_objects/phone_number.dart';
import 'package:yourcallyourrule/features/common/value_objects/rule_action.dart';
import 'package:yourcallyourrule/features/remote_filter/data/repositories/remote_number_repository_impl.dart';

part 'remote_number_service.g.dart';

/// RemoteNumberService 的 @riverpod Provider
@riverpod
RemoteNumberService remoteNumberService(Ref ref) {
  final repository = ref.watch(remoteNumberRepositoryProvider);
  return RemoteNumberService(
    remoteNumberRepository: repository,
    getConfig: () async => throw UnimplementedError(),
  );
}

/// 远程号码管理服务
class RemoteNumberService {
  final RemoteNumberRepositoryImpl _remoteNumberRepository;
  final Future<dynamic> Function() _getConfig;
  int _countThreshold = 5;

  static const int defaultCountThreshold = 5;

  RemoteNumberService({
    required RemoteNumberRepositoryImpl remoteNumberRepository,
    required Future<dynamic> Function() getConfig,
  })  : _remoteNumberRepository = remoteNumberRepository,
        _getConfig = getConfig;

  void setCountThreshold(int threshold) {
    _countThreshold = threshold;
  }

  int get countThreshold => _countThreshold;

  @override
  Future<List<RemoteNumberEntry>> getAll() async {
    return await _remoteNumberRepository.getAll();
  }

  Future<List<RemoteNumberEntry>> getAllRemoteNumbers() async {
    return await getAll();
  }

  @override
  Future<RemoteNumberEntry?> getByPhoneNumber(PhoneNumber phoneNumber) async {
    return await _remoteNumberRepository.getByPhoneNumber(phoneNumber);
  }

  Future<RemoteNumberEntry?> getRemoteNumberByPhoneNumber(
    PhoneNumber phoneNumber,
  ) async {
    return await getByPhoneNumber(phoneNumber);
  }

  @override
  Future<RemoteNumberEntry> add(
    RemoteNumberEntry entity, {
    String? countryIsoCode,
  }) async {
    return await _remoteNumberRepository.save(
      entity,
      countryIsoCode: countryIsoCode,
    );
  }

  Future<RemoteNumberEntry> addRemoteNumber(
    RemoteNumberEntry entity, {
    String? countryIsoCode,
  }) async {
    return await add(entity, countryIsoCode: countryIsoCode);
  }

  @override
  Future<RemoteNumberEntry> update(
    RemoteNumberEntry entity, {
    String? countryIsoCode,
  }) async {
    return await _remoteNumberRepository.update(
      entity,
      countryIsoCode: countryIsoCode,
    );
  }

  Future<RemoteNumberEntry> updateRemoteNumber(
    RemoteNumberEntry entity, {
    String? countryIsoCode,
  }) async {
    return await update(entity, countryIsoCode: countryIsoCode);
  }

  @override
  Future<bool> delete(RemoteNumberEntry entity) async {
    return await _remoteNumberRepository.delete(entity);
  }

  Future<bool> deleteRemoteNumber(RemoteNumberEntry entity) async {
    return await delete(entity);
  }

  @override
  Future<bool> deleteByPhoneNumber(PhoneNumber phoneNumber) async {
    return await _remoteNumberRepository.deleteById(phoneNumber.value);
  }

  Future<bool> deleteRemoteNumberByPhoneNumber(
    PhoneNumber phoneNumber,
  ) async {
    return await deleteByPhoneNumber(phoneNumber);
  }

  Future<List<RemoteNumberEntry>> getRemoteNumbersByAction(
    RuleAction action,
  ) async {
    final rules = await getAllRemoteNumbers();
    return rules.where((entry) => entry.actionType == action.type.name).toList();
  }

  Future<bool> isInRemoteNumbers(PhoneNumber phoneNumber) async {
    return await _remoteNumberRepository.isInRemoteNumbers(phoneNumber);
  }

  Future<RemoteNumberEntry?> incrementCount(PhoneNumber phoneNumber) async {
    return await _remoteNumberRepository.incrementCount(phoneNumber);
  }

  Future<bool> isCountExceeded(PhoneNumber phoneNumber) async {
    final entry = await _remoteNumberRepository.getByPhoneNumber(phoneNumber);
    return (entry?.count ?? 0) >= _countThreshold;
  }

  Future<Map<String, dynamic>?> queryRemoteNumberInfo(
    String phoneNumberStr,
  ) async {
    return await _remoteNumberRepository.queryRemoteNumberInfo(phoneNumberStr);
  }

  Future<bool> shouldAcceptBasedOnCount(PhoneNumber phoneNumber) async {
    final entry = await _remoteNumberRepository.getByPhoneNumber(phoneNumber);
    if (entry == null) return true;
    return entry.count < _countThreshold;
  }

  Future<bool> syncRemoteNumbers() async {
    return await _remoteNumberRepository.syncRemoteNumbers();
  }
}
