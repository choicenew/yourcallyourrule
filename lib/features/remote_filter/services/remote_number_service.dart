// 远程号码服务类，用于管理远程号码数据

import 'dart:async';

import 'package:yourcallyourrule/core/entities/remote/remote_number_entry.dart';
import 'package:yourcallyourrule/core/repositories/base_repository.dart';
import 'package:yourcallyourrule/core/services/list_service.dart';
import 'package:yourcallyourrule/core/value_objects/phone_number.dart';
import 'package:yourcallyourrule/core/value_objects/rule_action.dart';
import 'package:yourcallyourrule/data/repositories/remote/remote_number_repository_impl.dart';

/// 远程号码服务类，继承自ListService，提供远程号码的管理功能
/// 包括查询、更新、计数等操作
class RemoteNumberService extends ListService<RemoteNumberEntry, String> {
  final RemoteNumberRepositoryImpl _remoteNumberRepository;

  // 默认计数阈值
  static const int DEFAULT_COUNT_THRESHOLD = 5;

  // 当前计数阈值
  int _countThreshold = DEFAULT_COUNT_THRESHOLD;
  RemoteNumberService(
    this._remoteNumberRepository,
  ) : super(_remoteNumberRepository);
  
  @override
  Future<List<RemoteNumberEntry>> getAll() async {
    final rules = await _remoteNumberRepository.getAll();
    return rules;
  }
  
  // 设置计数阈值
  void setCountThreshold(int threshold) {
    _countThreshold = threshold;
  }
  
  // 获取计数阈值
  int getCountThreshold() {
    return _countThreshold;
  }
  
  // 添加远程号码
  Future<void> addRemoteNumber(RemoteNumberEntry entry) async {
    await _remoteNumberRepository.save(entry);
  }
  
  // 批量添加远程号码
  Future<void> addRemoteNumbers(List<RemoteNumberEntry> entries) async {
    await _remoteNumberRepository.saveAll(entries);
  }
  
  // 更新远程号码
  Future<void> updateRemoteNumber(RemoteNumberEntry entry) async {
    await _remoteNumberRepository.update(entry);
  }
  
  // 删除远程号码
  Future<void> removeRemoteNumber(String id) async {
    final entryToDelete = await _remoteNumberRepository.getById(id);
    if (entryToDelete != null) {
      await _remoteNumberRepository.delete(entryToDelete);
    }
  }
  
  // 获取所有远程号码
  Future<List<RemoteNumberEntry>> getAllRemoteNumbers() async {
    final rules = await _remoteNumberRepository.getAll();
    return rules.whereType<RemoteNumberEntry>().toList();
  }
  
  // 根据电话号码获取远程号码
  Future<RemoteNumberEntry?> getRemoteNumberByPhoneNumber(PhoneNumber phoneNumber) async {
    return await _remoteNumberRepository.getRemoteNumberByPhoneNumber(phoneNumber);
  }
  
  // 根据标签获取远程号码
  Future<List<RemoteNumberEntry>> getRemoteNumbersByLabel(String label) async {
    final rules = await getAllRemoteNumbers();
    return rules.where((entry) => entry.label == label).toList();
  }
  
  // 根据动作获取远程号码
  Future<List<RemoteNumberEntry>> getRemoteNumbersByAction(RuleAction action) async {
    final rules = await getAllRemoteNumbers();
    return rules.where((entry) => entry.action == action).toList();
  }
  
  // 检查电话号码是否存在于远程数据中
  Future<bool> isInRemoteNumbers(PhoneNumber phoneNumber) async {
    return await _remoteNumberRepository.isInRemoteNumbers(phoneNumber);
  }
  
  // 增加远程号码的计数并更新
  Future<RemoteNumberEntry?> incrementCount(PhoneNumber phoneNumber) async {
    return await _remoteNumberRepository.incrementCount(phoneNumber);
  }
  
  // 检查远程号码的计数是否超过阈值
  Future<bool> isCountExceeded(PhoneNumber phoneNumber) async {
    return await _remoteNumberRepository.isCountExceeded(phoneNumber, _countThreshold);
  }
  
  // 从远程数据库查询号码信息
  Future<Map<String, dynamic>?> queryRemoteNumberInfo(String phoneNumberStr) async {
    return await _remoteNumberRepository.queryRemoteNumberInfo(phoneNumberStr);
  }
  
  // 根据计数阈值判断是否应该接受或拒绝号码
  Future<bool> shouldAcceptBasedOnCount(PhoneNumber phoneNumber) async {
    return await _remoteNumberRepository.shouldAcceptBasedOnCount(phoneNumber, _countThreshold);
  }
  
  // 同步远程号码数据
  Future<bool> syncRemoteNumbers() async {
    return await _remoteNumberRepository.syncRemoteNumbers();
  }

  // 关联号码和国家代码
  Future<void> linkNumberToCountry(String phoneNumber, String countryIsoCode) async {
    await _remoteNumberRepository.linkNumberToCountry(phoneNumber, countryIsoCode);
  }
}