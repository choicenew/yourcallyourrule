import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:yourcallyourrule/features/phone_subscription/utils/phone_utils.dart';
import 'package:pyro_phone_marking_protocol/pyro_phone_marking_protocol.dart';
import 'package:pyro_phone_remote_filter_protocol/pyro_phone_remote_filter_protocol.dart';
import 'package:yourcallyourrule/features/common/value_objects/phone_number.dart';
import 'package:yourcallyourrule/features/common/value_objects/rule_action.dart';
import 'package:yourcallyourrule/features/common/value_objects/rule_priority.dart';
import 'package:yourcallyourrule/features/labels/services/predefined_label_service.dart';
import 'package:yourcallyourrule/features/labels/services/predefined_label_service.g.dart';
import 'package:yourcallyourrule/features/remote_filter/services/remote_number_service.dart';
import 'package:yourcallyourrule/features/remote_filter/services/remote_number_service.g.dart';

part 'label_phone_entry_to_remote.g.dart';

@Riverpod(keepAlive: true)
LabelPhoneEntryToRemote labelPhoneEntryToRemote(Ref ref) {
  final remoteNumberService = ref.watch(remoteNumberServiceProvider);
  final predefinedLabelService = ref.watch(predefinedLabelServiceProvider);
  return LabelPhoneEntryToRemote(remoteNumberService, predefinedLabelService);
}

/// 标签电话条目到远程同步服务类
class LabelPhoneEntryToRemote {
  final RemoteNumberService _remoteNumberService;
  final PredefinedLabelService _predefinedLabelService;

  LabelPhoneEntryToRemote(
    this._remoteNumberService,
    this._predefinedLabelService,
  );

  Future<void> sync(LabelPhoneEntry labelPhoneEntry) async {
    final phoneNumber = labelPhoneEntry.phoneNumber;

    try {
      final phoneNumberMap = await PhoneUtils.parsePhoneNumberWithoutIso(
        phoneNumber.value,
        null,
      );

      final e164Number = phoneNumberMap['e164Number'] ?? phoneNumber.value;
      final formattedPhoneNumber = PhoneNumber.fromString(e164Number);

      await _syncInternal(formattedPhoneNumber, labelPhoneEntry);
    } catch (e) {
      await _syncInternal(phoneNumber, labelPhoneEntry);
    }
  }

  Future<void> _syncInternal(
    PhoneNumber phoneNumber,
    LabelPhoneEntry labelPhoneEntry,
  ) async {
    final predefinedLabel = await _predefinedLabelService.getLabelById(
      labelPhoneEntry.labelId,
    );
    final labelText = predefinedLabel?.text ?? '';

    final existingEntry = await _remoteNumberService
        .getRemoteNumberByPhoneNumber(phoneNumber);

    if (existingEntry != null) {
      final updatedEntry = RemoteNumberEntry(
        id: existingEntry.id,
        phoneNumber: phoneNumber,
        name: _determineName(labelPhoneEntry, existingEntry),
        label: labelText,
        priority: existingEntry.priority,
        count: existingEntry.count,
        action: existingEntry.action,
        isEnabled: existingEntry.isEnabled,
      );
      await _remoteNumberService.updateRemoteNumber(updatedEntry);

      final phoneDetails = await PhoneUtils.parsePhoneNumberWithoutIso(
        phoneNumber.value,
        null,
      );
      final countryCode = phoneDetails['countryCode'];
      if (countryCode != null && countryCode.isNotEmpty) {
        await _remoteNumberService.linkNumberToCountry(
          phoneNumber.value,
          countryCode,
        );
      }
    } else {
      final newEntry = RemoteNumberEntry(
        id: const Uuid().v4(),
        phoneNumber: phoneNumber,
        name: labelPhoneEntry.name,
        label: labelText,
        priority: const RulePriority(0),
        count: 0,
        action: RuleAction.none,
        isEnabled: true,
      );
      await _remoteNumberService.addRemoteNumber(newEntry);

      final phoneDetails = await PhoneUtils.parsePhoneNumberWithoutIso(
        phoneNumber.value,
        null,
      );
      final countryCode = phoneDetails['countryCode'];
      if (countryCode != null && countryCode.isNotEmpty) {
        await _remoteNumberService.linkNumberToCountry(
          phoneNumber.value,
          countryCode,
        );
      }
    }
  }

  String _determineName(
    LabelPhoneEntry labelPhoneEntry,
    RemoteNumberEntry existingEntry,
  ) {
    if (labelPhoneEntry.name.isNotEmpty) {
      return labelPhoneEntry.name;
    }
    return existingEntry.name;
  }
}
