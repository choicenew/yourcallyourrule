// 远程号码服务类，用于管理远程号码数据

import 'dart:async';

import 'package:yourcallyourrule/core/entities/remote/remote_number_entry.dart';
import 'package:yourcallyourrule/core/repositories/rule_repository.dart';
import 'package:yourcallyourrule/core/services/list_service.dart';
import 'package:yourcallyourrule/core/services/rule_import_export_service.dart';
import 'package:yourcallyourrule/core/value_objects/phone_number.dart';
import 'package:yourcallyourrule/core/value_objects/rule_action.dart';
import 'package:yourcallyourrule/data/database/sync/incremental_sync_manager_remote_database.dart';
import 'package:yourcallyourrule/data/database/remote/remote_data_access_restriction.dart';

/// 远程号码服务类，继承自ListService，提供远程号码的管理功能
/// 包括查询、更新、计数等操作
class RemoteNumberService extends ListService {
  final RuleRepository _ruleRepository;
  final RuleImportExportService _importExportService;
  final RemoteDataAccessRestriction _remoteDataAccess;
  
  // 默认计数阈值
  static const int DEFAULT_COUNT_THRESHOLD = 5;
  
  // 当前计数阈值
  int _countThreshold = DEFAULT_COUNT_THRESHOLD;
  
  RemoteNumberService(
    this._ruleRepository,
    this._remoteDataAccess,
  ) : 
    _importExportService = RuleImportExportService(_ruleRepository),
    super(_ruleRepository);
  
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
    await _ruleRepository.save(entry);
  }
  
  // 批量添加远程号码
  Future<void> addRemoteNumbers(List<RemoteNumberEntry> entries) async {
    await _ruleRepository.saveAll(entries);
  }
  
  // 更新远程号码
  Future<void> updateRemoteNumber(RemoteNumberEntry entry) async {
    await _ruleRepository.update(entry);
  }
  
  // 删除远程号码
  Future<void> removeRemoteNumber(String id) async {
    final entryToDelete = await _ruleRepository.getById(id);
    if (entryToDelete != null) {
      await _ruleRepository.delete(entryToDelete);
    }
  }
  
  // 获取所有远程号码
  Future<List<RemoteNumberEntry>> getAllRemoteNumbers() async {
    final rules = await _ruleRepository.getAll();
    return rules.whereType<RemoteNumberEntry>().toList();
  }
  
  // 根据电话号码获取远程号码
  Future<RemoteNumberEntry?> getRemoteNumberByPhoneNumber(PhoneNumber phoneNumber) async {
    final rules = await getAllRemoteNumbers();
    try {
      return rules.firstWhere(
        (entry) => entry.phoneNumber.value == phoneNumber.value,
      );
    } catch (e) {
      return null;
    }
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
    final entry = await getRemoteNumberByPhoneNumber(phoneNumber);
    return entry != null;
  }
  
  // 增加远程号码的计数并更新
  Future<RemoteNumberEntry?> incrementCount(PhoneNumber phoneNumber) async {
    final entry = await getRemoteNumberByPhoneNumber(phoneNumber);
    if (entry != null) {
      final updatedEntry = entry.incrementCount();
      await updateRemoteNumber(updatedEntry);
      return updatedEntry;
    }
    return null;
  }
  
  // 检查远程号码的计数是否超过阈值
  Future<bool> isCountExceeded(PhoneNumber phoneNumber) async {
    final entry = await getRemoteNumberByPhoneNumber(phoneNumber);
    if (entry != null) {
      return entry.isCountExceeded(_countThreshold);
    }
    return false;
  }
  
  // 从远程数据库查询号码信息
  Future<Map<String, dynamic>?> queryRemoteNumberInfo(String phoneNumberStr) async {
    return await _remoteDataAccess.queryRemoteNumberInfo(phoneNumberStr);
  }
  
  // 根据计数阈值判断是否应该接受或拒绝号码
  Future<bool> shouldAcceptBasedOnCount(PhoneNumber phoneNumber) async {
    final entry = await getRemoteNumberByPhoneNumber(phoneNumber);
    if (entry != null) {
      // 如果计数超过阈值且动作为阻止，则拒绝
      if (entry.isCountExceeded(_countThreshold) && entry.action == RuleAction.block) {
        return false;
      }
      // 如果计数超过阈值且动作为允许，则接受
      if (entry.isCountExceeded(_countThreshold) && entry.action == RuleAction.allow) {
        return true;
      }
    }
    // 默认情况下，不基于计数做决定
    return true;
  }
  
  // 同步远程号码数据
  Future<bool> syncRemoteNumbers() async {
    try {
      // 记录访问日志
      await _remoteDataAccess.logAccess('sync', 'sync');
      // 检查访问权限
      final hasPermission = await _remoteDataAccess.checkAccessPermission('sync');
      if (!hasPermission) {
        return false;
      }
      
      // 使用增量同步管理器执行同步
      final syncManager = IncrementalSyncManager();
      
      // 确保同步管理器已初始化
      await syncManager.initialize();
      
      // 执行增量同步
      final success = await syncManager.syncIncremental();
      
      return success;
    } catch (e) {
      return false;
    }
  }
}