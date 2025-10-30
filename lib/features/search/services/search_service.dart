import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:yourcallyourrule/core/value_objects/phone_number.dart';
import 'package:yourcallyourrule/core/value_objects/rule_action.dart';
import 'package:yourcallyourrule/features/contacts/provider/contact_service_provider.dart';
import 'package:yourcallyourrule/features/contacts/services/contact_service.dart';
import 'package:yourcallyourrule/features/labels/services/label_service.dart';
import 'package:yourcallyourrule/features/remote_filter/services/remote_number_service.dart';
import 'package:yourcallyourrule/features/rules/services/rule_management_service.dart';
import 'package:yourcallyourrule/features/rules/services/allowed_blocked_service.dart';

// [重构]: 导入所有依赖的 Provider

import 'package:yourcallyourrule/core/provider/providers/label_service_provider.dart';
import 'package:yourcallyourrule/core/provider/providers/rule_management_service_provider.dart';
import 'package:yourcallyourrule/features/rules/providers/allowed_blocked_service_provider.dart';


part 'search_service.g.dart';

/// 搜索结果类型枚举
enum SearchResultType {
  contact, // 联系人
  label, // 标签
  allow, // 允许
  block, // 阻止
  silence, // 静音
  none, // 无动作
  remoteNumber, // 远程号码
  notFound // 未找到
}

/// 搜索结果模型
class SearchResult {
  final String id;
  final String phoneNumber;
  final String? name;
  final String? description; // 这个字段将由 UI 层根据类型和国际化文本生成
  final SearchResultType type;
  final String? ruleType;
  final dynamic data;

  SearchResult({
    required this.id,
    required this.phoneNumber,
    this.name,
    this.description,
    required this.type,
    this.ruleType,
    this.data,
  });
}


// [重构]: 为 SearchService 创建一个简单的 @riverpod Provider
@riverpod
SearchService searchService(Ref ref) {
  return SearchService(
    contactService: ref.watch(contactServiceProvider),
    labelService: ref.watch(labelServiceProvider),
    ruleManagementService: ref.watch(ruleManagementServiceProvider),
    allowedBlockedService: ref.watch(allowedBlockedServiceProvider),
    remoteNumberService: ref.watch(remoteNumberServiceProvider),
  );
}


/// [重构]: SearchService 现在是一个纯粹的业务逻辑类。
/// 它不再依赖 BuildContext 或 WidgetRef。
class SearchService {
  final ContactService _contactService;
  final LabelService _labelService;
  final RuleManagementService _ruleManagementService;
  final AllowedBlockedService _allowedBlockedService;
  final RemoteNumberService _remoteNumberService;

  SearchService({
    required ContactService contactService,
    required LabelService labelService,
    required RuleManagementService ruleManagementService,
    required AllowedBlockedService allowedBlockedService,
    required RemoteNumberService remoteNumberService,
  })  : _contactService = contactService,
        _labelService = labelService,
        _ruleManagementService = ruleManagementService,
        _allowedBlockedService = allowedBlockedService,
        _remoteNumberService = remoteNumberService;

  /// 搜索电话号码
  Future<List<SearchResult>> searchPhoneNumber(String phoneNumberStr) async {
    final results = <SearchResult>[];

    try {
      final phoneNumber = PhoneNumber.fromString(phoneNumberStr);

      // 搜索联系人
      final contacts = await _contactService.getAll();
      for (final contact in contacts) {
        for (final number in contact.phoneNumbers) {
          if (number.contains(phoneNumberStr)) {
            results.add(SearchResult(
              id: contact.id,
              phoneNumber: number,
              name: contact.name,
              type: SearchResultType.contact,
              data: contact,
            ));
          }
        }
      }

      // 搜索标签
      final labels = await _labelService.getAllLabels();
      for (final label in labels) {
        if (label.phoneNumber.toString().contains(phoneNumberStr)) {
          results.add(SearchResult(
            id: label.id,
            phoneNumber: label.phoneNumber.toString(),
            name: label.labelId, // UI 层将负责将 ID 转换为文本
            type: SearchResultType.label,
            data: label,
          ));
        }
      }

      // 搜索号码规则管理
      final ruleManagementRules = await _ruleManagementService.getAllRulesByActionType(null);
      for (final rule in ruleManagementRules) {
        if (rule.phoneNumber.toString().contains(phoneNumberStr)) {
          results.add(SearchResult(
            id: rule.id,
            phoneNumber: rule.phoneNumber.toString(),
            name: rule.name,
            type: _mapActionToResultType(rule.action.type),
            ruleType: 'phone',
            data: rule,
          ));
        }
      }

      // 搜索允许/阻止规则
      final allowedBlockedRules = await _allowedBlockedService.getAllRulesByActionType(null);
      for (final rule in allowedBlockedRules) {
        if (rule.phoneNumber.toString().contains(phoneNumberStr)) {
          results.add(SearchResult(
            id: rule.id,
            phoneNumber: rule.phoneNumber.toString(),
            name: rule.name,
            type: _mapActionToResultType(rule.action.type),
            ruleType: 'allowedBlocked',
            data: rule,
          ));
        }
      }

      // 搜索远程号码
      try {
        final remoteNumber = await _remoteNumberService.getRemoteNumberByPhoneNumber(phoneNumber);
        if (remoteNumber != null) {
          results.add(SearchResult(
            id: remoteNumber.id,
            phoneNumber: remoteNumber.phoneNumber.toString(),
            name: remoteNumber.name,
            type: SearchResultType.remoteNumber,
            data: remoteNumber,
          ));
        }
      } catch (e) {
        // 忽略远程号码搜索失败
      }

      // 如果没有找到任何结果，添加一个未找到的结果
      if (results.isEmpty) {
        results.add(SearchResult(
          id: 'not_found',
          phoneNumber: phoneNumberStr,
          type: SearchResultType.notFound,
        ));
      }
    } catch (e) {
      // 重新抛出异常，让 Notifier 来处理
      rethrow;
    }

    return results;
  }
  
  SearchResultType _mapActionToResultType(RuleActionType actionType) {
    switch (actionType) {
      case RuleActionType.allow: return SearchResultType.allow;
      case RuleActionType.block: return SearchResultType.block;
      case RuleActionType.silence: return SearchResultType.silence;
      case RuleActionType.none: return SearchResultType.none;
      default: return SearchResultType.notFound;
    }
  }

  // [重构]: 移除了 _getLabelName，因为这个逻辑现在属于 UI 层。
}