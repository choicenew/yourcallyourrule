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
import 'package:yourcallyourrule/features/labels/services/predefined_label_service.dart';
import 'package:yourcallyourrule/features/labels/services/predefined_label_service.g.dart';
import 'package:yourcallyourrule/features/rules/repositories/rule_repository.dart';
import 'package:yourcallyourrule/features/rules/repositories/rule_repository_impl.dart';
import 'package:yourcallyourrule/features/rules/repositories/rule_repository_impl.g.dart';
import 'package:yourcallyourrule/features/rules/services/rule_management_service.dart';

part 'call_log_service.g.dart';

/// CallLogService Riverpod Provider
@Riverpod(keepAlive: true)
CallLogService callLogService(Ref ref) {
  final callLogRepository = ref.watch(callLogRepositoryProvider);
  final contactService = ref.watch(contactServiceProvider);
  final ruleRepository = ref.watch(ruleRepositoryProvider);
  final predefinedLabelService = ref.watch(predefinedLabelServiceProvider);
  final labelService = LabelService(ruleRepository, predefinedLabelService);
  final ruleManagementService = ref.watch(ruleManagementServiceProvider);

  return CallLogService(
    callLogRepository,
    contactService: contactService,
    labelService: labelService,
    ruleManagementService: ruleManagementService,
  );
}

/// 通话记录服务
class CallLogService {
  final CallLogRepository _repository;
  final ContactService? _contactService;
  final LabelService? _labelService;
  final RuleManagementService? _blacklistWhitelistService;

  final _logController = StreamController<List<CallLogEntry>>.broadcast();
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

  Future<CallLogEntry?> getLastLog() async {
    final recent = await _repository.getRecentLogs();
    return recent.isNotEmpty ? recent.first : null;
  }

  Future<void> initialize() async {
    await _loadAllLogs();
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

  Future<void> addLog(CallLogEntry log) async {
    await _repository.addLog(log);
    await _loadAllLogs();
  }

  Future<void> deleteLog(String id) async {
    await _repository.deleteById(id);
    await _loadAllLogs();
  }

  Future<void> clearAllLogs() async {
    final all = await _repository.getAll();
    await _repository.deleteAll(all);
    await _loadAllLogs();
  }

  Future<List<CallLogEntry>> getRecentLogs() async {
    return await _repository.getRecentLogs();
  }

  Future<List<CallLogEntry>> getLogsByPhoneNumber(String phoneNumber) async {
    return await _repository.getLogsByPhoneNumber(phoneNumber);
  }

  Future<List<CallLogEntry>> getLogsByLabelId(String labelId) async {
    return await _repository.getLogsByLabelId(labelId);
  }

  Future<void> updateLog(CallLogEntry log) async {
    await _repository.update(log);
  }

  Future<String?> getAvatarForPhoneNumber(String phoneNumber) async {
    if (_avatarCache.containsKey(phoneNumber)) {
      return _avatarCache[phoneNumber];
    }

    String? avatar;
    final phone = PhoneNumber.fromString(phoneNumber);

    if (_contactService != null) {
      final contact = await _contactService.findContactByPhoneNumber(phone);
      if (contact != null && contact.photoUrl != null && contact.photoUrl!.isNotEmpty) {
        avatar = contact.photoUrl;
      }
    }

    if (avatar == null && _blacklistWhitelistService != null) {
      final allRules = await _blacklistWhitelistService.getAllRulesByActionType(null);
      final matchingRules = allRules.where((rule) => rule.phoneNumber == phoneNumber);

      if (matchingRules.isNotEmpty && (matchingRules.first as dynamic).avatar != null) {
        avatar = (matchingRules.first as dynamic).avatar as String?;
      }
    }

    _avatarCache[phoneNumber] = avatar;
    return avatar;
  }

  void dispose() {
    _logController.close();
  }
}
