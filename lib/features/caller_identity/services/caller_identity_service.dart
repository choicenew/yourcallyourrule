import 'dart:async';

import 'package:dlibphonenumber/dlibphonenumber.dart';
import 'package:flutter/material.dart' hide Locale;
import 'package:flutter_contacts/flutter_contacts.dart' as fluttercontact;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uuid/uuid.dart';

import 'package:yourcallyourrule/features/common/error/logger.dart';
import 'package:yourcallyourrule/features/phone/utils/phone_utils.dart';
import 'package:pyro_caller_identity_protocol/pyro_caller_identity_protocol.dart';
import 'package:pyro_phone_contacts_protocol/pyro_phone_contacts_protocol.dart';
import 'package:pyro_phone_marking_protocol/pyro_phone_marking_protocol.dart';
import 'package:pyro_phone_location_protocol/pyro_phone_location_protocol.dart';
import 'package:pyro_phone_lookup_plugin_protocol/pyro_phone_lookup_plugin_protocol.dart';
import 'package:pyro_phone_remote_filter_protocol/pyro_phone_remote_filter_protocol.dart';
import 'package:pyro_phone_rules_protocol/pyro_phone_rules_protocol.dart';
import 'package:yourcallyourrule/core/value_objects/phone_number.dart' as vo;
import 'package:yourcallyourrule/features/contacts/services/contact_service.dart';
import 'package:yourcallyourrule/features/labels/services/label_service.dart';
import 'package:yourcallyourrule/features/labels/services/predefined_label_service.dart';
import 'package:yourcallyourrule/features/location/services/location_service.dart';
import 'package:yourcallyourrule/features/plugin/services/plugin_invoker_service.dart';
import 'package:yourcallyourrule/features/remote_filter/services/remote_number_service.dart';
import 'package:yourcallyourrule/features/rules/services/rule_management_service.dart';

part 'caller_identity_service.g.dart';

@Riverpod(keepAlive: true)
CallerIdentityService callerIdentityService(Ref ref) {
  final pluginService = ref.watch(pluginServiceProvider);
  final contactService = ref.watch(contactServiceProvider);
  final ruleManagementService = ref.watch(ruleManagementServiceProvider);
  final labelService = ref.watch(labelServiceProvider);
  final locationService = ref.watch(locationServiceProvider);
  final predefinedLabelService = ref.watch(predefinedLabelServiceProvider);
  final remoteNumberService = ref.watch(remoteNumberServiceProvider);

  return CallerIdentityService(
    pluginService: pluginService,
    contactService: contactService,
    ruleManagementService: ruleManagementService,
    labelService: labelService,
    locationService: locationService,
    predefinedLabelService: predefinedLabelService,
    remoteNumberService: remoteNumberService,
  );
}

/// 生产级标准来电身份画像聚合服�?(CallerIdentityService)
class CallerIdentityService {
  CallerIdentityService({
    required PluginInvokerService pluginService,
    required ContactService contactService,
    required RuleManagementService ruleManagementService,
    required LabelService labelService,
    required LocationService locationService,
    required PredefinedLabelService predefinedLabelService,
    required RemoteNumberService remoteNumberService,
  })  : _contactService = contactService,
        _ruleManagementService = ruleManagementService,
        _labelService = labelService,
        _locationService = locationService,
        _predefinedLabelService = predefinedLabelService,
        _pluginService = pluginService,
        _remoteNumberService = remoteNumberService;

  final RuleManagementService _ruleManagementService;
  final _callerIdSubject = BehaviorSubject<CallerIdData>();
  final ContactService _contactService;
  final _labelPhoneEntrySubject = BehaviorSubject<LabelPhoneEntry>();
  final LabelService _labelService;
  final LocationService _locationService;
  final _pluginDataSubject = BehaviorSubject<PluginSourceData>();
  final PluginInvokerService _pluginService;
  final PredefinedLabelService _predefinedLabelService;
  final RemoteNumberService _remoteNumberService;

  Stream<PluginSourceData> get pluginDataStream => _pluginDataSubject.stream;
  Stream<CallerIdData> get callerIdStream => _callerIdSubject.stream;
  Stream<LabelPhoneEntry> get labelPhoneEntryStream => _labelPhoneEntrySubject.stream;

  Future<CallerIdData> getCallerId(String phoneNumber, Locale locale) async {
    final parsed = await PhoneUtils.parsePhoneNumberWithIsoEntity(
      phoneNumber,
      locale.country,
    );
    return getCallerIdWithParsed(
      phoneNumber,
      parsed.e164Number,
      parsed.nationalNumber,
      locale,
    );
  }

  Future<CallerIdData> getCallerIdWithParsed(
    String phoneNumber,
    String e164Number,
    String nationalNumber,
    Locale locale,
  ) async {
    List<fluttercontact.Contact> allLocalContacts = [];
    try {
      allLocalContacts = await fluttercontact.FlutterContacts.getAll();
    } catch (e) {
      debugPrint('[CallerIdentityService] 获取系统联系人跳�?无权�? $e');
      allLocalContacts = [];
    }

    fluttercontact.Contact? localContact;
    for (var contact in allLocalContacts) {
      for (var phone in contact.phones) {
        String normalizedPhone = phone.number.replaceAll(' ', '');
        if (normalizedPhone == phoneNumber.replaceAll(' ', '') ||
            normalizedPhone == e164Number ||
            normalizedPhone == nationalNumber) {
          localContact = contact;
          break;
        }
      }
      if (localContact != null) break;
    }

    final futures = await Future.wait([
      _contactService.findContactByPhoneNumber(vo.PhoneNumber.fromString(phoneNumber)),
      _ruleManagementService.getRulesByPhoneNumber(vo.PhoneNumber.fromString(phoneNumber)),
      _labelService.getLabelByPhoneNumber(vo.PhoneNumber.fromString(phoneNumber)),
      _pluginService.callPluginsAllEntities(phoneNumber, nationalNumber, e164Number),
      _remoteNumberService.getRemoteNumberByPhoneNumber(vo.PhoneNumber.fromString(e164Number)),
      _locationService.getCallerLocation(e164Number, locale),
    ]);

    final finalContact = futures[0] as Contact?;
    final allRules = futures[1] as List<PhoneRule>;
    final labelEntry = futures[2] as LabelPhoneEntry?;
    final (firstResult, allResultsFuture) = futures[3] as (PluginSourceData?, Future<List<PluginSourceData>>);
    final remoteNumberEntry = futures[4] as RemoteNumberEntry?;
    final locationData = futures[5] as LocationEntry?;

    PhoneRule? phoneRule;
    if (allRules.isNotEmpty) {
      final matchingRules = allRules.where(
        (rule) =>
            rule.phoneNumber == vo.PhoneNumber.fromString(phoneNumber) ||
            (e164Number.isNotEmpty && rule.phoneNumber == vo.PhoneNumber.fromString(e164Number)) ||
            (nationalNumber.isNotEmpty && rule.phoneNumber == vo.PhoneNumber.fromString(nationalNumber)),
      ).toList();
      if (matchingRules.isNotEmpty) {
        matchingRules.sort((a, b) => b.priority.value.compareTo(a.priority.value));
        phoneRule = matchingRules.first;
      }
    }

    PluginSourceData? pluginSourceData = firstResult;

    final labelId = labelEntry?.labelId ?? phoneRule?.labelId;
    final labelFromId = labelId != null ? await _predefinedLabelService.getLabelById(labelId) : null;

    final callerIdData = CallerIdData.resolve(
      rawNumber: phoneNumber,
      localContact: localContact,
      finalContact: finalContact,
      phoneRule: phoneRule,
      labelEntry: labelEntry,
      labelFromId: labelFromId,
      remoteNumberEntry: remoteNumberEntry,
      pluginSourceData: pluginSourceData,
      locationData: locationData,
    );

    _callerIdSubject.add(callerIdData);

    final bool hasHighPriorityName = localContact != null || finalContact != null || phoneRule?.name != null || remoteNumberEntry?.name != null;
    final bool hasHighPriorityAction = phoneRule?.action != null || remoteNumberEntry?.action != null;
    final bool hasHighPriorityAvatar = finalContact?.avatar != null || phoneRule?.avatar != null;

    unawaited(
      _processAllPluginData(
        allResultsFuture,
        callerIdData,
        hasHighPriorityName: hasHighPriorityName,
        hasHighPriorityAction: hasHighPriorityAction,
        hasHighPriorityAvatar: hasHighPriorityAvatar,
      ),
    );

    return callerIdData;
  }

  Future<void> _processAllPluginData(
    Future<List<PluginSourceData>> allResultsFuture,
    CallerIdData initialData, {
    bool hasHighPriorityName = false,
    bool hasHighPriorityAction = false,
    bool hasHighPriorityAvatar = false,
  }) async {
    try {
      final allResults = await allResultsFuture;
      if (allResults.isEmpty) return;

      final completePluginData = PluginSourceData.merge(allResults);

      final updatedCallerIdData = initialData.enrichWith(
        completePluginData,
        hasHighPriorityName: hasHighPriorityName,
        hasHighPriorityAction: hasHighPriorityAction,
        hasHighPriorityAvatar: hasHighPriorityAvatar,
      );

      if (updatedCallerIdData.name != initialData.name ||
          updatedCallerIdData.action != initialData.action ||
          updatedCallerIdData.avatar != initialData.avatar ||
          updatedCallerIdData.count != initialData.count ||
          updatedCallerIdData.labels?.first.label != initialData.labels?.first.label) {
        _callerIdSubject.add(updatedCallerIdData);
      }

      if (_pluginDataSubject.hasValue &&
          _pluginDataSubject.value.phoneNumber == completePluginData.phoneNumber) {
        if (completePluginData.name != null &&
            completePluginData.name!.isNotEmpty &&
            completePluginData.name != 'Unknown') {
          _pluginDataSubject.add(completePluginData);
        }
      } else {
        _pluginDataSubject.add(completePluginData);
      }

      if (completePluginData.predefinedLabel != null) {
        final e164Number = completePluginData.phoneNumber ?? '';
        if (e164Number.isNotEmpty) {
          final existingLabel = await _labelService.getLabelByPhoneNumber(
            vo.PhoneNumber.fromString(e164Number),
          );

          final matchingRules = await _ruleManagementService.getRulesByPhoneNumber(
            vo.PhoneNumber.fromString(e164Number),
          );
          final matchingRule = matchingRules.firstOrNull;

          if (existingLabel == null && matchingRule?.labelId == null) {
            final labels = await _predefinedLabelService.getLabelsByText(
              completePluginData.predefinedLabel!,
            );
            if (labels.isNotEmpty) {
              final entry = LabelPhoneEntry(
                id: const Uuid().v4(),
                phoneNumber: vo.PhoneNumber.fromString(e164Number),
                labelId: labels.first.id,
                name: completePluginData.name ?? 'Unknown',
                action: completePluginData.action,
              );
              if (!_labelPhoneEntrySubject.hasValue ||
                  _labelPhoneEntrySubject.value.phoneNumber != entry.phoneNumber) {
                await _labelService.addLabel(entry);
                _labelPhoneEntrySubject.add(entry);
              }
            }
          }
        }
      }
    } catch (e) {
      AppLogger.error('处理所有插件数据失�?, e);
    }
  }

  void dispose() {
    _callerIdSubject.close();
    _pluginDataSubject.close();
    _labelPhoneEntrySubject.close();
  }
}
