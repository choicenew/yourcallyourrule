import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_phone_remote_filter_protocol/pyro_phone_remote_filter_protocol.dart';
import 'package:yourcallyourrule/features/common/services/list_service.dart';
import 'package:yourcallyourrule/features/common/value_objects/phone_number.dart';
import 'package:yourcallyourrule/features/common/value_objects/rule_action.dart';
import 'package:yourcallyourrule/features/remote_filter/data/repositories/remote_number_repository_impl.dart';
// 导入依赖�?Provider

part 'remote_number_service.g.dart';

/// RemoteNumberService �?@riverpod Provider
@riverpod
RemoteNumberService remoteNumberService(Ref ref) {
  // 注入 Repository 依赖
  return RemoteNumberService(ref.watch(remoteNumberRepositoryProvider));
}

/// 远程号码服务�?(基本无状态，阈值由外部设置)
class RemoteNumberService extends ListService<RemoteNumberEntry, String> {
  final RemoteNumberRepositoryImpl _remoteNumberRepository;

  static const int DEFAULT_COUNT_THRESHOLD = 5;
  int _countThreshold = DEFAULT_COUNT_THRESHOLD;

  RemoteNumberService(this._remoteNumberRepository)
    : super(_remoteNumberRepository);

  // ... (所有方法保持不变，因为它们不直接依赖可变状�? ...

  @override
  Future<List<RemoteNumberEntry>> getAll() async {
    return await _remoteNumberRepository.getAll();
  }

  // 设置计数阈�?
  void setCountThreshold(int threshold) {
    _countThreshold = threshold;
  }

  // 获取计数阈�?
  int getCountThreshold() {
    return _countThreshold;
  }

  // 添加远程号码
  Future<void> addRemoteNumber(
    RemoteNumberEntry entry, {
    String? countryIsoCode,
  }) async {
    await _remoteNumberRepository.save(entry, countryIsoCode: countryIsoCode);
  }

  // 批量添加远程号码
  Future<void> addRemoteNumbers(List<RemoteNumberEntry> entries) async {
    await _remoteNumberRepository.saveAll(entries);
  }

  // 更新远程号码
  Future<void> updateRemoteNumber(
    RemoteNumberEntry entry, {
    String? countryIsoCode,
  }) async {
    await _remoteNumberRepository.update(entry, countryIsoCode: countryIsoCode);
  }

  // 删除远程号码
  Future<void> removeRemoteNumber(String id) async {
    final entryToDelete = await _remoteNumberRepository.getById(id);
    if (entryToDelete != null) {
      await _remoteNumberRepository.delete(entryToDelete);
    }
  }

  // 获取所有远程号�?
  Future<List<RemoteNumberEntry>> getAllRemoteNumbers() async {
    final rules = await _remoteNumberRepository.getAll();
    return rules.whereType<RemoteNumberEntry>().toList();
  }

  // 根据电话号码获取远程号码
  Future<RemoteNumberEntry?> getRemoteNumberByPhoneNumber(
    PhoneNumber phoneNumber,
  ) async {
    return await _remoteNumberRepository.getRemoteNumberByPhoneNumber(
      phoneNumber,
    );
  }

  // 根据标签获取远程号码
  Future<List<RemoteNumberEntry>> getRemoteNumbersByLabel(String label) async {
    final rules = await getAllRemoteNumbers();
    return rules.where((entry) => entry.label == label).toList();
  }

  // 根据动作获取远程号码
  Future<List<RemoteNumberEntry>> getRemoteNumbersByAction(
    RuleAction action,
  ) async {
    final rules = await getAllRemoteNumbers();
    return rules.where((entry) => entry.action == action).toList();
  }

  // 检查电话号码是否存在于远程数据�?
  Future<bool> isInRemoteNumbers(PhoneNumber phoneNumber) async {
    return await _remoteNumberRepository.isInRemoteNumbers(phoneNumber);
  }

  // 增加远程号码的计数并更新
  Future<RemoteNumberEntry?> incrementCount(PhoneNumber phoneNumber) async {
    return await _remoteNumberRepository.incrementCount(phoneNumber);
  }

  // 检查远程号码的计数是否超过阈�?
  Future<bool> isCountExceeded(PhoneNumber phoneNumber) async {
    return await _remoteNumberRepository.isCountExceeded(
      phoneNumber,
      _countThreshold,
    );
  }

  // 从远程数据库查询号码信息
  Future<Map<String, dynamic>?> queryRemoteNumberInfo(
    String phoneNumberStr,
  ) async {
    return await _remoteNumberRepository.queryRemoteNumberInfo(phoneNumberStr);
  }

  // 根据计数阈值判断是否应该接受或拒绝号码
  Future<bool> shouldAcceptBasedOnCount(PhoneNumber phoneNumber) async {
    return await _remoteNumberRepository.shouldAcceptBasedOnCount(
      phoneNumber,
      _countThreshold,
    );
  }

  // 同步远程号码数据
  Future<bool> syncRemoteNumbers() async {
    return await _remoteNumberRepository.syncRemoteNumbers();
  }

  // 关联号码和国家代�?
  Future<void> linkNumberToCountry(
    String phoneNumber,
    String countryIsoCode,
  ) async {
    await _remoteNumberRepository.linkNumberToCountry(
      phoneNumber,
      countryIsoCode,
    );
  }
}
