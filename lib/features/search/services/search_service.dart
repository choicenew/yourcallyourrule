import 'package:flutter/material.dart';
import 'package:yourcallyourrule/core/value_objects/phone_number.dart';
import 'package:yourcallyourrule/features/contacts/services/contact_service.dart';
import 'package:yourcallyourrule/features/labels/services/label_service.dart';
import 'package:yourcallyourrule/features/labels/utils/label_text_utils.dart';
import 'package:yourcallyourrule/features/remote_filter/services/remote_number_service.dart';
import 'package:yourcallyourrule/features/rules/services/blacklist_whitelist_service.dart';
import 'package:yourcallyourrule/features/rules/services/allowed_blocked_service.dart';

/// 搜索结果类型枚举
enum SearchResultType {
  contact,      // 联系人
  label,        // 标签
  blacklist,    // 黑名单
  whitelist,    // 白名单
  allowed,      // 允许
  blocked,      // 阻止
  remoteNumber, // 远程号码
  notFound      // 未找到
}

/// 搜索结果模型
class SearchResult {
  final String id;
  final String phoneNumber;
  final String? name;
  final String? description;
  final SearchResultType type;
  final dynamic data; // 原始数据对象

  SearchResult({
    required this.id,
    required this.phoneNumber,
    this.name,
    this.description,
    required this.type,
    this.data,
  });
}

/// 搜索服务类
/// 用于搜索本地和远程数据库中的号码
class SearchService {
  final ContactService _contactService;
  final LabelService _labelService;
  final BlacklistWhitelistService _blacklistWhitelistService;
  final AllowedBlockedService _allowedBlockedService;
  final RemoteNumberService _remoteNumberService;
  final BuildContext context;

  SearchService({
    required ContactService contactService,
    required LabelService labelService,
    required BlacklistWhitelistService blacklistWhitelistService,
    required AllowedBlockedService allowedBlockedService,
    required RemoteNumberService remoteNumberService,
    required this.context,
  }) : 
    _contactService = contactService,
    _labelService = labelService,
    _blacklistWhitelistService = blacklistWhitelistService,
    _allowedBlockedService = allowedBlockedService,
    _remoteNumberService = remoteNumberService;

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
            name: await _getLabelName(label.labelId),
            description: '标签',
            type: SearchResultType.label,
            data: label,
          ));
        }
      }
      
      // 搜索黑白名单
      final blacklistWhitelistRules = await _blacklistWhitelistService.getAllRulesByActionType(null);
      for (final rule in blacklistWhitelistRules) {
        if (rule.phoneNumber.toString().contains(phoneNumberStr)) {
          final isWhitelist = rule.action.type.toString().contains('allow');
          results.add(SearchResult(
            id: rule.id,
            phoneNumber: rule.phoneNumber.toString(),
            name: isWhitelist ? '白名单' : '黑名单',
            description: isWhitelist ? '白名单规则' : '黑名单规则',
            type: isWhitelist ? SearchResultType.whitelist : SearchResultType.blacklist,
            data: rule,
          ));
        }
      }
      
      // 搜索允许/阻止规则
      final allowedBlockedRules = await _allowedBlockedService.getAllRulesByActionType(null);
      for (final rule in allowedBlockedRules) {
        if (rule.phoneNumber.toString().contains(phoneNumberStr)) {
          final isAllowed = rule.action.type.toString().contains('allow');
          results.add(SearchResult(
            id: rule.id,
            phoneNumber: rule.phoneNumber.toString(),
            name: isAllowed ? '允许' : '阻止',
            description: isAllowed ? '允许规则' : '阻止规则',
            type: isAllowed ? SearchResultType.allowed : SearchResultType.blocked,
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
            description: '远程号码',
            type: SearchResultType.remoteNumber,
            data: remoteNumber,
          ));
        }
      } catch (e) {
        debugPrint('搜索远程号码失败: $e');
      }
    } catch (e) {
      debugPrint('搜索过程中出错: $e');
    }
    
    return results;
  }
  
  /// 获取标签名称
  Future<String?> _getLabelName(String labelId) async {
    try {
      return await LabelTextUtils.getLabelTextById(context, labelId) ?? labelId;
    } catch (e) {
      return labelId;
    }
  }
}