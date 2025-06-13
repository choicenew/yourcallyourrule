import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:yourcallyourrule/core/value_objects/phone_number.dart';
import 'package:yourcallyourrule/core/value_objects/rule_action.dart';
import 'package:yourcallyourrule/features/contacts/services/contact_service.dart';
import 'package:yourcallyourrule/features/labels/services/label_service.dart';
import 'package:yourcallyourrule/features/labels/utils/label_text_utils.dart';
import 'package:yourcallyourrule/features/remote_filter/services/remote_number_service.dart';
import 'package:yourcallyourrule/features/rules/services/rule_management_service.dart';
import 'package:yourcallyourrule/features/rules/services/allowed_blocked_service.dart';

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
  final String? description;
  final SearchResultType type;
  final String? ruleType; // 规则类型，如 'phone' 或 'allowedBlocked'
  final dynamic data; // 原始数据对象

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

/// 搜索服务类
/// 用于搜索本地和远程数据库中的号码
class SearchService {
  final ContactService _contactService;
  final LabelService _labelService;
  final RuleManagementService _ruleManagementService;
  final AllowedBlockedService _allowedBlockedService;
  final RemoteNumberService _remoteNumberService;
  final BuildContext context;
  final WidgetRef? ref;

  SearchService({
    required ContactService contactService,
    required LabelService labelService,
    required RuleManagementService ruleManagementService,
    required AllowedBlockedService allowedBlockedService,
    required RemoteNumberService remoteNumberService,
    BuildContext? context,
    this.ref,
  })  : _contactService = contactService,
        _labelService = labelService,
        _ruleManagementService = ruleManagementService,
        _allowedBlockedService = allowedBlockedService,
        _remoteNumberService = remoteNumberService,
        context = context ?? (throw ArgumentError('context is required'));

  /// 搜索电话号码
  /// 返回搜索结果列表
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
              description: '联系人',
              type: SearchResultType.contact,
              ruleType: null,
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
            name: await _getLabelName(label.labelId, ref: ref),
            description: '标签',
            type: SearchResultType.label,
            ruleType: null,
            data: label,
          ));
        }
      }

      // 搜索号码规则管理
      final ruleManagementRules =
          await _ruleManagementService.getAllRulesByActionType(null);
      for (final rule in ruleManagementRules) {
        if (rule.phoneNumber.toString().contains(phoneNumberStr)) {
          // 根据规则的action类型确定搜索结果类型
          final actionType = rule.action.type;
          final SearchResultType resultType;
          String actionName;
          String actionDescription;

          switch (actionType) {
            case RuleActionType.allow:
              resultType = SearchResultType.allow;
              actionName = '允许';
              actionDescription = '允许规则';
              break;
            case RuleActionType.block:
              resultType = SearchResultType.block;
              actionName = '阻止';
              actionDescription = '阻止规则';
              break;
            case RuleActionType.silence:
              resultType = SearchResultType.silence;
              actionName = '静音';
              actionDescription = '静音规则';
              break;
            case RuleActionType.none:
              resultType = SearchResultType.none;
              actionName = '无动作';
              actionDescription = '无动作规则';
              break;
            default:
              resultType = SearchResultType.notFound;
              actionName = '未知';
              actionDescription = '未知规则';
          }

          results.add(SearchResult(
            id: rule.id,
            phoneNumber: rule.phoneNumber.toString(),
            name: actionName,
            description: actionDescription,
            type: resultType,
            ruleType: 'phone',
            data: rule,
          ));
        }
      }

      // 搜索允许/阻止规则
      final allowedBlockedRules =
          await _allowedBlockedService.getAllRulesByActionType(null);
      for (final rule in allowedBlockedRules) {
        if (rule.phoneNumber.toString().contains(phoneNumberStr)) {
          // 根据规则的action类型确定搜索结果类型
          final actionType = rule.action.type;
          final SearchResultType resultType;
          String actionName;
          String actionDescription;

          switch (actionType) {
            case RuleActionType.allow:
              resultType = SearchResultType.allow;
              actionName = '允许';
              actionDescription = '允许规则';
              break;
            case RuleActionType.block:
              resultType = SearchResultType.block;
              actionName = '阻止';
              actionDescription = '阻止规则';
              break;
            case RuleActionType.silence:
              resultType = SearchResultType.silence;
              actionName = '静音';
              actionDescription = '静音规则';
              break;
            case RuleActionType.none:
              resultType = SearchResultType.none;
              actionName = '无动作';
              actionDescription = '无动作规则';
              break;
            default:
              resultType = SearchResultType.notFound;
              actionName = '未知';
              actionDescription = '未知规则';
          }

          results.add(SearchResult(
            id: rule.id,
            phoneNumber: rule.phoneNumber.toString(),
            name: actionName,
            description: actionDescription,
            type: resultType,
            ruleType: 'allowedBlocked',
            data: rule,
          ));
        }
      }

      // 搜索远程号码
      try {
        final remoteNumber = await _remoteNumberService
            .getRemoteNumberByPhoneNumber(phoneNumber);
        if (remoteNumber != null) {
          results.add(SearchResult(
            id: remoteNumber.id,
            phoneNumber: remoteNumber.phoneNumber.toString(),
            name: remoteNumber.name,
            description: '远程号码',
            type: SearchResultType.remoteNumber,
            ruleType: null,
            data: remoteNumber,
          ));
        }
      } catch (e) {
        // 远程号码搜索失败，忽略错误
      }

      // 如果没有找到任何结果，添加一个未找到的结果
      if (results.isEmpty) {
        results.add(SearchResult(
          id: 'not_found',
          phoneNumber: phoneNumberStr,
          name: '未找到',
          description: '未找到匹配的号码',
          type: SearchResultType.notFound,
          ruleType: null,
          data: null,
        ));
      }
    } catch (e) {
      // 处理搜索过程中的错误
      results.add(SearchResult(
        id: 'error',
        phoneNumber: phoneNumberStr,
        name: '搜索错误',
        description: '搜索过程中发生错误: $e',
        type: SearchResultType.notFound,
        ruleType: null,
        data: null,
      ));
    }

    return results;
  }

  /// 获取标签名称
  /// 需要传入WidgetRef参数以使用LabelTextUtils.getLabelTextById
  Future<String?> _getLabelName(String labelId, {WidgetRef? ref}) async {
    try {
      if (ref != null) {
        // 使用LabelTextUtils获取标签文本
        return await LabelTextUtils.getLabelTextById(context, ref, labelId);
      }
      // 如果没有提供ref，则返回labelId作为后备
      return labelId;
    } catch (e) {
      return labelId;
    }
  }
}
