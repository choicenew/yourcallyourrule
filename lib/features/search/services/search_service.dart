import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:yourcallyourrule/features/common/value_objects/phone_number.dart';
import 'package:yourcallyourrule/features/common/value_objects/rule_action.dart';
import 'package:yourcallyourrule/features/contacts/services/contact_service.dart';
import 'package:yourcallyourrule/features/labels/services/label_service.dart';
import 'package:yourcallyourrule/features/remote_filter/services/remote_number_service.dart';
import 'package:yourcallyourrule/features/phone_rules/services/rule_management_service.dart';
import 'package:yourcallyourrule/features/phone_rules/services/allowed_blocked_service.dart';
import 'package:yourcallyourrule/features/phone_rules/utils/rule_action_display_utils.dart';

part 'search_service.g.dart';

enum SearchResultType {
  contact,
  label,
  allow,
  block,
  silence,
  none,
  remoteNumber,
  notFound,
}

class SearchResult {
  final String id;
  final String phoneNumber;
  final String? name;
  final String? description;
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

  Future<List<SearchResult>> searchPhoneNumber(String phoneNumberStr) async {
    final results = <SearchResult>[];

    try {
      final phoneNumber = PhoneNumber.fromString(phoneNumberStr);

      final contacts = await _contactService.getAll();
      for (final contact in contacts) {
        for (final number in contact.phoneNumbers) {
          if (number.contains(phoneNumberStr)) {
            results.add(SearchResult(
              id: contact.id,
              phoneNumber: number,
              name: contact.displayName,
              type: SearchResultType.contact,
              data: contact,
            ));
          }
        }
      }

      final labels = await _labelService.getAllLabels();
      for (final label in labels) {
        if (label.phoneNumber.toString().contains(phoneNumberStr)) {
          results.add(SearchResult(
            id: label.id,
            phoneNumber: label.phoneNumber.toString(),
            name: label.labelId,
            type: SearchResultType.label,
            data: label,
          ));
        }
      }

      final ruleManagementRules = await _ruleManagementService.getAllRulesByActionType(null);
      for (final rule in ruleManagementRules) {
        if (rule.phoneNumber.toString().contains(phoneNumberStr)) {
          final action = RuleActionDisplayUtils.parseActionType(rule.actionType);
          results.add(SearchResult(
            id: rule.id,
            phoneNumber: rule.phoneNumber.toString(),
            name: rule.name,
            type: _mapActionToResultType(action.type),
            ruleType: rule.actionType,
            data: rule,
          ));
        }
      }

      final allowedBlockedRules = await _allowedBlockedService.getAllAllowedRules();
      for (final rule in allowedBlockedRules) {
        if (rule.phoneNumber.toString().contains(phoneNumberStr)) {
          final action = RuleActionDisplayUtils.parseActionType(rule.actionType);
          results.add(SearchResult(
            id: rule.id,
            phoneNumber: rule.phoneNumber.toString(),
            name: rule.name,
            type: _mapActionToResultType(action.type),
            ruleType: rule.actionType,
            data: rule,
          ));
        }
      }

      try {
        final remoteNumber = await _remoteNumberService.getRemoteNumberByPhoneNumber(phoneNumber);
        if (remoteNumber != null) {
          results.add(SearchResult(
            id: remoteNumber.id,
            phoneNumber: remoteNumber.phoneNumber.toString(),
            name: remoteNumber.phoneNumber.toString(),
            type: SearchResultType.remoteNumber,
            data: remoteNumber,
          ));
        }
      } catch (e) {
      }

      if (results.isEmpty) {
        results.add(SearchResult(
          id: 'not_found',
          phoneNumber: phoneNumberStr,
          type: SearchResultType.notFound,
        ));
      }
    } catch (e) {
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
}
