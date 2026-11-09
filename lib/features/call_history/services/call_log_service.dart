import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_phone_call_history_protocol/pyro_phone_call_history_protocol.dart';
import 'package:yourcallyourrule/features/common/utils/avatar_utils.dart';
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
  final StreamController<List<CallLogEntry>> _logController = StreamController.broadcast();

  final ContactService? _contactService;
  final LabelService? _labelService;
  final RuleManagementService? _blacklistWhitelistService;

  final Map<String, String?> _avatarCache = {};

  CallLogService(
    this._repository, {
    ContactService? contactService,
    LabelService? labelService,
    RuleManagementService? ruleManagementService,
  })  : _contactService = contactService,
        _labelService = labelService,
        _blacklistWhitelistService = ruleManagementService;

  Stream<List<CallLogEntry>> get logsStream => _logController.stream;

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

  Future<void> addLog(CallLogEntry log) async {
    await _repository.save(log);
  }

  Future<List<CallLogEntry>> getRecentLogs() async {
    return await _repository.getRecentLogs();
  }

  Future<List<CallLogEntry>> getLogsByLabelId(String labelId) async {
    return await _repository.getLogsByLabelId(labelId);
  }

  Future<void> updateLog(CallLogEntry log) async {
    await _repository.update(log);
  }

  Future<CallLogEntry?> getLastLog() async {
    final logs = await _repository.getRecentLogs();
    if (logs.isEmpty) return null;

    logs.sort((a, b) => (b.timestamp ?? 0).compareTo(a.timestamp ?? 0));
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
      if (contact != null && contact.url != null && contact.url!.isNotEmpty) {
        avatar = contact.url;
      }
    }

    if (avatar == null && _blacklistWhitelistService != null) {
      final allRules = await _blacklistWhitelistService!.getAllRulesByActionType(null);
      final matchingRules = allRules.where((rule) => rule.phoneNumber == phoneNumber);

      if (matchingRules.isNotEmpty && matchingRules.first.avatar != null) {
        avatar = matchingRules.first.avatar;
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

  Future<bool> deleteLogs(List<CallLogEntry> logsToDelete) async {
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
}
