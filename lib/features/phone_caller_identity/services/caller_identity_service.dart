import 'dart:async';

import 'package:dlibphonenumber/dlibphonenumber.dart';
import 'package:material_ui/material_ui.dart' hide Locale;
import 'package:flutter_contacts/flutter_contacts.dart' as fluttercontact;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:pyro_phone_caller_identity_protocol/pyro_phone_caller_identity_protocol.dart';
import 'package:pyro_phone_marking_protocol/pyro_phone_marking_protocol.dart';
import 'package:pyro_phone_location_hub/pyro_phone_location_hub.dart';
import 'package:pyro_phone_lookup_plugin_protocol/pyro_phone_lookup_plugin_protocol.dart';
import 'package:pyro_phone_remote_filter_protocol/pyro_phone_remote_filter_protocol.dart';
import 'package:pyro_phone_rules_protocol/pyro_phone_rules_protocol.dart';
import 'package:yourcallyourrule/features/common/value_objects/phone_number.dart' as vo;

part 'caller_identity_service.g.dart';

@Riverpod(keepAlive: true)
CallerIdentityService callerIdentityService(Ref ref) {
  return CallerIdentityService();
}

class CallerIdentityService {
  Future<dynamic> Function(vo.PhoneNumber phone)? _contactResolver;
  Future<List<PhoneRuleEntity>> Function(vo.PhoneNumber phone)? _rulesResolver;
  Future<LabelPhoneEntry?> Function(String phoneNumber)? _labelResolver;
  Future<PredefinedLabel?> Function(String labelId)? _predefinedLabelResolver;
  Future<RemoteNumberEntry?> Function(vo.PhoneNumber phone)? _remoteNumberResolver;

  final BehaviorSubject<PluginSourceData> _pluginDataSubject = BehaviorSubject<PluginSourceData>();
  final BehaviorSubject<CallerIdData> _callerIdSubject = BehaviorSubject<CallerIdData>();
  final BehaviorSubject<LabelPhoneEntry> _labelPhoneEntrySubject = BehaviorSubject<LabelPhoneEntry>();

  CallerIdentityService({
    Future<dynamic> Function(vo.PhoneNumber phone)? contactResolver,
    Future<List<PhoneRuleEntity>> Function(vo.PhoneNumber phone)? rulesResolver,
    Future<LabelPhoneEntry?> Function(String phoneNumber)? labelResolver,
    Future<PredefinedLabel?> Function(String labelId)? predefinedLabelResolver,
    Future<RemoteNumberEntry?> Function(vo.PhoneNumber phone)? remoteNumberResolver,
  })  : _contactResolver = contactResolver,
        _rulesResolver = rulesResolver,
        _labelResolver = labelResolver,
        _predefinedLabelResolver = predefinedLabelResolver,
        _remoteNumberResolver = remoteNumberResolver;

  void bindResolvers({
    Future<dynamic> Function(vo.PhoneNumber phone)? contactResolver,
    Future<List<PhoneRuleEntity>> Function(vo.PhoneNumber phone)? rulesResolver,
    Future<LabelPhoneEntry?> Function(String phoneNumber)? labelResolver,
    Future<PredefinedLabel?> Function(String labelId)? predefinedLabelResolver,
    Future<RemoteNumberEntry?> Function(vo.PhoneNumber phone)? remoteNumberResolver,
  }) {
    if (contactResolver != null) _contactResolver = contactResolver;
    if (rulesResolver != null) _rulesResolver = rulesResolver;
    if (labelResolver != null) _labelResolver = labelResolver;
    if (predefinedLabelResolver != null) _predefinedLabelResolver = predefinedLabelResolver;
    if (remoteNumberResolver != null) _remoteNumberResolver = remoteNumberResolver;
  }

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
    final finalContact = await _contactResolver?.call(voPhone);
    final allRules = await _rulesResolver?.call(voPhone) ?? const [];
    final labelEntry = await _labelResolver?.call(phoneNumber);
    final remoteNumberEntry = await _remoteNumberResolver?.call(voPhone);
    final locationData = await PhoneLocationControlCenter.instance.getCallerLocation(
      e164Number,
      localeLanguage: locale.language,
      localeCountry: locale.country,
    );

    PhoneRuleEntity? phoneRule;
    if (allRules.isNotEmpty) {
      phoneRule = allRules.first;
    }

    PluginSourceData? pluginSourceData;
    final labelId = labelEntry?.labelId ?? phoneRule?.labelId;
    final labelFromId = labelId != null ? await _predefinedLabelResolver?.call(labelId) : null;

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
