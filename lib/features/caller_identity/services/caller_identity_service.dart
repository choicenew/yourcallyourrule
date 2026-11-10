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
import 'package:yourcallyourrule/features/common/value_objects/phone_number.dart' as vo;
import 'package:yourcallyourrule/features/contacts/services/contact_service.dart';
import 'package:yourcallyourrule/features/labels/services/label_service.dart';
import 'package:yourcallyourrule/features/labels/services/predefined_label_service.dart';
import 'package:yourcallyourrule/features/location/services/location_service.dart';
import 'package:yourcallyourrule/features/plugin/services/plugin_manager_service.dart';
import 'package:yourcallyourrule/features/remote_filter/services/remote_number_service.dart';
import 'package:yourcallyourrule/features/rules/services/rule_management_service.dart';

part 'caller_identity_service.g.dart';

@Riverpod(keepAlive: true)
CallerIdentityService callerIdentityService(Ref ref) {
  final pluginService = ref.watch(pluginManagerServiceProvider);
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

/// 生产级标准来电身份画像聚合服务
class CallerIdentityService {
  CallerIdentityService({
    required PluginManagerService pluginService,
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
  final PluginManagerService _pluginService;
  final PredefinedLabelService _predefinedLabelService;
  final RemoteNumberService _remoteNumberService;

  Stream<PluginSourceData> get pluginDataStream => _pluginDataSubject.stream;
  Stream<CallerIdData> get callerIdStream => _callerIdSubject.stream;
  Stream<LabelPhoneEntry> get labelPhoneEntryStream => _labelPhoneEntrySubject.stream;

  Future<CallerIdData> getCallerId(String phoneNumber, Locale locale) async {
    final parsed = await PhoneUtils.parsePhoneNumberWithIsoEntity(
      phoneNumber,
      locale.countryCode ?? 'US',
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
      debugPrint('[CallerIdentityService] 获取系统联系人跳过: $e');
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

    final finalContact = await _contactService.findContactByPhoneNumber(vo.PhoneNumber.fromString(phoneNumber));
    final allRules = await _ruleManagementService.getRulesByPhoneNumber(vo.PhoneNumber.fromString(phoneNumber));
    final labelEntry = await _labelService.getLabelByPhoneNumber(vo.PhoneNumber.fromString(phoneNumber));
    final remoteNumberEntry = await _remoteNumberService.getRemoteNumberByPhoneNumber(vo.PhoneNumber.fromString(e164Number));
    final locationData = await _locationService.getCallerLocation(e164Number, locale);

    PhoneRuleEntity? phoneRule;
    if (allRules.isNotEmpty) {
      phoneRule = allRules.first;
    }

    PluginSourceData? pluginSourceData;
    final labelId = labelEntry?.labelId ?? phoneRule?.labelId;
    final labelFromId = labelId != null ? await _predefinedLabelService.getLabelById(labelId) : null;

    final callerIdData = CallerIdData(
      phoneNumber: e164Number.isNotEmpty ? e164Number : phoneNumber,
      name: localContact?.displayName ?? finalContact?.name ?? phoneRule?.name ?? remoteNumberEntry?.phoneNumber,
      region: locationData?.region,
      countryName: locationData?.countryName,
      carrier: locationData?.carrier,
      labels: labelFromId != null ? [labelFromId.text] : (labelEntry != null ? [labelEntry.labelId] : []),
      localCount: phoneRule?.count ?? 0,
      pluginCount: 0,
      remoteCount: remoteNumberEntry != null ? 1 : 0,
    );

    _callerIdSubject.add(callerIdData);
    return callerIdData;
  }

  void dispose() {
    _callerIdSubject.close();
    _pluginDataSubject.close();
    _labelPhoneEntrySubject.close();
  }
}
