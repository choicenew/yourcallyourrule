import 'dart:async';

import 'package:flutter/material.dart';
import 'package:yourcallyourrule/core/entities/call/call_log.dart';
import 'package:yourcallyourrule/core/repositories/call_log_repository.dart';
import 'package:yourcallyourrule/core/value_objects/phone_number.dart';
import 'package:yourcallyourrule/features/contacts/services/contact_service.dart';
import 'package:yourcallyourrule/features/labels/services/label_service.dart';
import 'package:yourcallyourrule/features/rules/services/allowed_blocked_service.dart';

import 'package:yourcallyourrule/features/rules/services/rule_management_service.dart';

class CallLogService {
  final CallLogRepository _repository;
  final StreamController<List<CallLog>> _logController = StreamController.broadcast();
  
  // 添加服务依赖，用于获取头像信息
  final ContactService? _contactService;
  final LabelService? _labelService;
  final AllowedBlockedService? _allowedBlockedService;
  final RuleManagementService? _blacklistWhitelistService;
  
  // 头像缓存，避免重复查询
  final Map<String, String?> _avatarCache = {};

  CallLogService(
    this._repository, {
    ContactService? contactService,
    LabelService? labelService,
    AllowedBlockedService? allowedBlockedService,
    RuleManagementService? ruleManagementService,
  }) : 
    _contactService = contactService,
    _labelService = labelService,
    _allowedBlockedService = allowedBlockedService,
    _blacklistWhitelistService = ruleManagementService;

  Stream<List<CallLog>> get logsStream => _logController.stream;

  Future<void> initialize() async {
    await _loadAllLogs();
    await _setupAutoRefresh();
  }

  Future<void> _loadAllLogs() async {
    try {
      final logs = await _repository.getRecentLogs();
      _logController.add(logs);
    } catch (e) {
      _logController.addError(e);
    }
  }

  Future<void> refresh() async {
    await _repository.refreshLogs();
    await _loadAllLogs();
  }

  Future<void> _setupAutoRefresh() async {
    _repository.watchLogs().listen((logs) {
      _logController.add(logs);
    });
  }

  Future<void> addLog(CallLog log) async {
     await _repository.save(log);
    //await refresh();
  }
  
  /// 获取所有通话记录
  Future<List<CallLog>> getRecentLogs() async {
    return await _repository.getRecentLogs();
  }
  
  /// 根据标签ID获取通话记录
  Future<List<CallLog>> getLogsByLabelId(String labelId) async {
    return await _repository.getLogsByLabelId(labelId);
  }
  
  /// 为通话记录添加标签
  Future<void> addLabelToLog(CallLog log, String labelId) async {
    // 创建标签ID列表（如果不存在）
    final labelIds = log.labelIds?.toList() ?? <String>[];
    
    // 如果标签ID不在列表中，则添加
    if (!labelIds.contains(labelId)) {
      labelIds.add(labelId);
      
      // 创建带有更新标签的新CallLog
      final updatedLog = CallLog(
        id: log.id,
        phoneNumber: log.phoneNumber,
        timestamp: log.timestamp,
        callType: log.callType,
        simDisplayName: log.simDisplayName,
        simSlotIndex: log.simSlotIndex,
        carrierName: log.carrierName,
        countryIso: log.countryIso,
        subscriptionId: log.subscriptionId,
        labelIds: labelIds,
      );
      
      // 更新通话记录
      await _repository.addLog(updatedLog);
      //await refresh();
    }
  }
  
  /// 为通话记录设置单个标签（替换所有现有标签）
  Future<void> setLabelForLog(CallLog log, String labelId) async {
    final updatedLog = log.copyWith(labelIds: [labelId]);
    await updateLog(updatedLog);
  }

  /// 从通话记录中移除标签
  Future<void> removeLabelFromLog(CallLog log, String labelId) async {
    final newLabelIds = List<String>.from(log.labelIds ?? [])..remove(labelId);
    final updatedLog = log.copyWith(labelIds: newLabelIds);
    await updateLog(updatedLog);
  }
  
  /// 检查通话记录是否包含指定标签
  bool hasLabel(CallLog log, String labelId) {
    return log.labelIds?.contains(labelId) ?? false;
  }
  
  /// 更新通话记录
  Future<void> updateLog(CallLog log) async {
   await _repository.update(log);
  //  //await refresh();
  }
  
  /// 获取最后一条通话记录
  /// 按时间戳排序，返回最新的一条记录
  Future<CallLog?> getLastLog() async {
    final logs = await _repository.getRecentLogs();
    if (logs.isEmpty) return null;
    
    // 按时间戳排序
    logs.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    return logs.first;
  }
  
  /// 根据电话号码获取头像
  /// 按照优先级从联系人、规则、标签中获取头像
  Future<String?> getAvatarForNumber(String phoneNumber) async {
    // 检查缓存
    if (_avatarCache.containsKey(phoneNumber)) {
      return _avatarCache[phoneNumber];
    }
    
    String? avatar;
    final phone = PhoneNumber.fromString(phoneNumber);
    
    // 1. 从联系人中获取头像
    if (_contactService != null) {
      final contact = await _contactService!.findContactByPhoneNumber(phone);
      if (contact != null && contact.avatar != null && contact.avatar!.isNotEmpty) {
        avatar = contact.avatar;
      }
    }
    
    // 2. 如果联系人中没有头像，从规则中获取
    if (avatar == null && _allowedBlockedService != null) {
      final allowedRules = await _allowedBlockedService!.getAllAllowedRules();
      final blockedRules = await _allowedBlockedService!.getAllBlockedRules();
      
      // 查找匹配的规则
      final matchingAllowed = allowedRules.where((rule) => rule.phoneNumber.value == phoneNumber);
      final matchingBlocked = blockedRules.where((rule) => rule.phoneNumber.value == phoneNumber);
      
      if (matchingAllowed.isNotEmpty && matchingAllowed.first.avatar != null) {
        avatar = matchingAllowed.first.avatar;
      } else if (matchingBlocked.isNotEmpty && matchingBlocked.first.avatar != null) {
        avatar = matchingBlocked.first.avatar;
      }
    }
    
    // 3. 如果规则中没有头像，从规则管理服务中获取
    if (avatar == null && _blacklistWhitelistService != null) {
      // 获取所有规则，不再区分黑白名单
      final allRules = await _blacklistWhitelistService!.getAllRulesByActionType(null);
      
      // 查找匹配的规则
      final matchingRules = allRules.where((rule) => rule.phoneNumber.value == phoneNumber);
      
      // 如果找到匹配的规则并且有头像，使用第一个匹配规则的头像
      if (matchingRules.isNotEmpty && matchingRules.first.avatar != null) {
        avatar = matchingRules.first.avatar;
      }
    }
    
    // 4. 如果规则中没有头像，从标签中获取
    if (avatar == null && _labelService != null) {
      final label = await _labelService!.getLabelByPhoneNumber(phone);
      if (label != null && label.avatar != null && label.avatar!.isNotEmpty) {
        avatar = label.avatar;
      }
    }
    
    // 缓存结果
    _avatarCache[phoneNumber] = avatar;
    return avatar;
  }
  
  /// 根据标签获取默认头像
  ImageProvider? getDefaultAvatarForLabel(String? label) {
    if (label == null || label.isEmpty) {
      return null;
    }
    
    return AssetImage('assets/avatars/$label.png');
  }
  
  /// 清除头像缓存
  void clearAvatarCache() {
    _avatarCache.clear();
  }
    /// 删除指定的通话记录列表
  Future<bool> deleteLogs(List<CallLog> logsToDelete) async {
    if (logsToDelete.isEmpty) {
      return true; // 如果列表为空，直接返回成功
    }
    return await _repository.deleteAll(logsToDelete);
  }
  
  /// 删除单个通话记录
  Future<bool> deleteLog(String logId) async {
    return await _repository.deleteById(logId);
  }
  
  /// 清除所有通话记录
  Future<bool> clearAllLogs() async {
    final logs = await getRecentLogs();
    return await _repository.deleteAll(logs);
  }
}