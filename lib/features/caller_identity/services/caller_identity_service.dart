import 'dart:async';

import 'package:dlibphonenumber/dlibphonenumber.dart';
import 'package:flutter/material.dart' hide Locale;
import 'package:flutter_contacts/flutter_contacts.dart' as fluttercontact;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uuid/uuid.dart';

import 'package:yourcallyourrule/features/common/error/logger.dart';
import 'package:pyro_phone_caller_identity_protocol/pyro_phone_caller_identity_protocol.dart';
import 'package:pyro_phone_contacts_protocol/pyro_phone_contacts_protocol.dart';
import 'package:pyro_phone_marking_protocol/pyro_phone_marking_protocol.dart';
import 'package:pyro_phone_location_protocol/pyro_phone_location_protocol.dart';
import 'package:pyro_phone_lookup_plugin_protocol/pyro_phone_lookup_plugin_protocol.dart';
import 'package:pyro_phone_remote_filter_protocol/pyro_phone_remote_filter_protocol.dart';
import 'package:pyro_phone_rules_protocol/pyro_phone_rules_protocol.dart';
import 'package:yourcallyourrule/features/common/value_objects/phone_number.dart' as vo;
import 'package:yourcallyourrule/features/contacts/services/contact_service.dart';
import 'package:yourcallyourrule/features/phone_rules/services/rule_management_service.dart';
import 'package:yourcallyourrule/features/labels/services/label_service.dart';
import 'package:yourcallyourrule/features/labels/services/predefined_label_service.dart';
import 'package:yourcallyourrule/features/remote_filter/services/remote_number_service.dart';
import 'package:yourcallyourrule/features/phone_location/services/location_service.dart';

part 'caller_identity_service.g.dart';

@Riverpod(keepAlive: true)
CallerIdentityService callerIdentityService(Ref ref) {
  final contactService = ref.watch(contactServiceProvider);
  final ruleManagementService = ref.watch(ruleManagementServiceProvider);
  final labelService = ref.watch(labelServiceProvider);
  final predefinedLabelService = ref.watch(predefinedLabelServiceProvider);
  final remoteNumberService = ref.watch(remoteNumberServiceProvider);
  final locationService = ref.watch(locationServiceProvider);

  return CallerIdentityService(
    contactService: contactService,
    ruleManagementService: ruleManagementService,
    labelService: labelService,
    predefinedLabelService: predefinedLabelService,
    remoteNumberService: remoteNumberService,
    locationService: locationService,
  );
}

class CallerIdentityService {
  final ContactService _contactService;
  final RuleManagementService _ruleManagementService;
  final LabelService _labelService;
  final PredefinedLabelService _predefinedLabelService;
  final RemoteNumberService _remoteNumberService;
  final LocationService _locationService;

  final BehaviorSubject<PluginSourceData> _pluginDataSubject = BehaviorSubject<PluginSourceData>();
  final BehaviorSubject<CallerIdData> _callerIdSubject = BehaviorSubject<CallerIdData>();
  final BehaviorSubject<LabelPhoneEntry> _labelPhoneEntrySubject = BehaviorSubject<LabelPhoneEntry>();

  CallerIdentityService({
    required ContactService contactService,
    required RuleManagementService ruleManagementService,
    required LabelService labelService,
    required PredefinedLabelService predefinedLabelService,
    required RemoteNumberService remoteNumberService,
    required LocationService locationService,
  })  : _contactService = contactService,
        _ruleManagementService = ruleManagementService,
        _labelService = labelService,
        _predefinedLabelService = predefinedLabelService,
        _remoteNumberService = remoteNumberService,
        _locationService = locationService;

  Stream<PluginSourceData> get pluginDataStream => _pluginDataSubject.stream;
  Stream<CallerIdData> get callerIdStream => _callerIdSubject.stream;
  Stream<LabelPhoneEntry> get labelPhoneEntryStream => _labelPhoneEntrySubject.stream;

  Future<CallerIdData> getCallerId(String phoneNumber, Locale locale) async {
    final e164 = phoneNumber.startsWith('+') ? phoneNumber : '+$phoneNumber';
    return getCallerIdWithParsed(
      phoneNumber,
      e164,
      phoneNumber,
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

    final voPhone = vo.PhoneNumber.fromString(phoneNumber);
    final finalContact = await _contactService.findContactByPhoneNumber(voPhone);
    final allRules = await _ruleManagementService.getRulesByPhoneNumber(voPhone);
    final labelEntry = await _labelService.getLabelByPhoneNumber(phoneNumber);
    final remoteNumberEntry = await _remoteNumberService.getRemoteNumberByPhoneNumber(voPhone);
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
      pluginCount: pluginSourceData != null ? 1 : (_pluginDataSubject.hasValue ? 1 : 0),
      remoteCount: remoteNumberEntry != null ? 1 : 0,
    );

    _callerIdSubject.add(callerIdData);
    return callerIdData;
  }

  void dispose() {
    _pluginDataSubject.close();
    _callerIdSubject.close();
    _labelPhoneEntrySubject.close();
  }
}
