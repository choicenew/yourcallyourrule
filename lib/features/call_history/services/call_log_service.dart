import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yourcallyourrule/features/common/utils/avatar_utils.dart';
import 'package:yourcallyourrule/features/call_history/entities/call_log.dart';
import 'package:yourcallyourrule/features/call_history/repositories/call_log_repository.dart';
import 'package:yourcallyourrule/features/call_history/data/repositories/call_log_repository_impl.dart';
import 'package:yourcallyourrule/features/common/value_objects/phone_number.dart';
import 'package:yourcallyourrule/features/contacts/services/contact_service.dart';
import 'package:yourcallyourrule/features/labels/services/label_service.dart';
import 'package:yourcallyourrule/features/rules/services/rule_management_service.dart';

part 'call_log_service.g.dart';

/// CallLogService Riverpod Provider
@Riverpod(keepAlive: true)
CallLogService callLogService(Ref ref) {
  final callLogRepository = ref.watch(callLogRepositoryProvider);
  final contactService = ref.watch(contactServiceProvider);
  final labelService = ref.watch(labelServiceProvider);
  final ruleManagementService = ref.watch(ruleManagementServiceProvider);

  return CallLogService(
    callLogRepository,
    contactService: contactService,
    labelService: labelService,
    ruleManagementService: ruleManagementService,
  );
}

class CallLogService {
  final CallLogRepository _repository;
  final StreamController<List<CallLog>> _logController = StreamController.broadcast();
  
  final ContactService? _contactService;
  final LabelService? _labelService;
  final RuleManagementService? _blacklistWhitelistService;
  
  final Map<String, String?> _avatarCache = {};

  CallLogService(
    this._repository, {
    ContactService? contactService,
    LabelService? labelService,
    RuleManagementService? ruleManagementService,
  }) : 
    _contactService = contactService,
    _labelService = labelService,
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
  }

  Future<List<CallLog>> getRecentLogs() async {
    return await _repository.getRecentLogs();
  }

  Future<List<CallLog>> getLogsByLabelId(String labelId) async {
    return await _repository.getLogsByLabelId(labelId);
  }

  Future<void> addLabelToLog(CallLog log, String labelId) async {
    final labelIds = log.labelIds?.toList() ?? <String>[];
    
    if (!labelIds.contains(labelId)) {
      labelIds.add(labelId);
      
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
        endTime: log.endTime,
        duration: log.duration,
      );
      
      await _repository.addLog(updatedLog);
    }
  }

  Future<void> setLabelForLog(CallLog log, String labelId) async {
    final updatedLog = log.copyWith(labelIds: [labelId]);
    await updateLog(updatedLog);
  }

  Future<void> removeLabelFromLog(CallLog log, String labelId) async {
    final newLabelIds = List<String>.from(log.labelIds ?? [])..remove(labelId);
    final updatedLog = log.copyWith(labelIds: newLabelIds);
    await updateLog(updatedLog);
  }

  bool hasLabel(CallLog log, String labelId) {
    return log.labelIds?.contains(labelId) ?? false;
  }

  Future<void> updateLog(CallLog log) async {
    await _repository.update(log);
  }

  Future<CallLog?> getLastLog() async {
    final logs = await _repository.getRecentLogs();
    if (logs.isEmpty) return null;
    
    logs.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    return logs.first;
  }

  Future<String?> getAvatarForNumber(String phoneNumber) async {
    if (_avatarCache.containsKey(phoneNumber)) {
      return _avatarCache[phoneNumber];
    }
    
    String? avatar;
    final phone = PhoneNumber.fromString(phoneNumber);
    
    if (_contactService != null) {
      final contact = await _contactService!.findContactByPhoneNumber(phone);
      if (contact != null && contact.photoUrl != null && contact.photoUrl!.isNotEmpty) {
        avatar = contact.photoUrl;
      }
    }
    
    if (avatar == null && _blacklistWhitelistService != null) {
      final allRules = await _blacklistWhitelistService!.getAllRulesByActionType(null);
      final matchingRules = allRules.where((rule) => rule.phoneNumber.value == phoneNumber);
      
      if (matchingRules.isNotEmpty && matchingRules.first.avatar != null) {
        avatar = matchingRules.first.avatar;
      }
    }
    
    if (avatar == null && _labelService != null) {
      final label = await _labelService!.getLabelByPhoneNumber(phone);
      if (label != null && label.avatar != null && label.avatar!.isNotEmpty) {
        avatar = label.avatar;
      }
    }
    
    _avatarCache[phoneNumber] = avatar;
    return avatar;
  }

  ImageProvider? getDefaultAvatarForLabel(String? label) {
    if (label == null || label.isEmpty) {
      return null;
    }
    
    return AssetImage(AvatarUtils.getSafeAvatarPath(label));
  }

  void clearAvatarCache() {
    _avatarCache.clear();
  }

  Future<bool> deleteLogs(List<CallLog> logsToDelete) async {
    if (logsToDelete.isEmpty) {
      return true;
    }
    return await _repository.deleteAll(logsToDelete);
  }

  Future<bool> deleteLog(String logId) async {
    return await _repository.deleteById(logId);
  }

  Future<bool> clearAllLogs() async {
    final logs = await getRecentLogs();
    return await _repository.deleteAll(logs);
  }

  Future<void> updateNameAndLabelsByPhoneNumber(String phoneNumber, String? newName, List<String>? newLabelIds) async {
    final logsToUpdate = await _repository.getLogsByPhoneNumber(phoneNumber);

    if (logsToUpdate.isEmpty) {
      return;
    }

    final updatedLogs = logsToUpdate.map((log) {
      return log.copyWith(
        name: newName,
        labelIds: newLabelIds,
      );
    }).toList();

    await _repository.updateAll(updatedLogs);
  }
}