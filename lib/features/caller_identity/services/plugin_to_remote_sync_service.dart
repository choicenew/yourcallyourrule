import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uuid/uuid.dart';
import 'package:yourcallyourrule/common/utils/phone_utils.dart';
import 'package:yourcallyourrule/core/entities/label/label_phone_entry.dart';
import 'package:yourcallyourrule/core/entities/plugin/plugin_source_data.dart';
import 'package:yourcallyourrule/core/entities/remote/remote_number_entry.dart';
import 'package:yourcallyourrule/core/value_objects/phone_number.dart';
import 'package:yourcallyourrule/core/value_objects/rule_action.dart';
import 'package:yourcallyourrule/core/value_objects/rule_priority.dart';
import 'package:yourcallyourrule/features/caller_identity/services/caller_identity_service.dart';
import 'package:yourcallyourrule/features/remote_filter/services/remote_number_service.dart';

final pluginToRemoteSyncServiceProvider = Provider<PluginToRemoteSyncService>((ref) {
  final remoteNumberService = ref.watch(remoteNumberServiceProvider);
  return PluginToRemoteSyncService(remoteNumberService);
});

final pluginSyncServiceInitializerProvider = Provider<void>((ref) {
  final callerIdentityService = ref.watch(callerIdentityServiceProvider);
  final syncService = PluginToRemoteSyncService(ref.watch(remoteNumberServiceProvider));
  syncService.startSync(
    callerIdentityService.pluginDataStream,
    callerIdentityService.labelPhoneEntryStream,
  );
});

class PluginToRemoteSyncService {
  final RemoteNumberService _remoteNumberService;
  StreamSubscription<dynamic>? _dataSubscription;

  PluginToRemoteSyncService(this._remoteNumberService);

  void startSync(
    Stream<PluginSourceData> pluginDataStream, [
    Stream<LabelPhoneEntry>? labelPhoneEntryStream,
  ]) {
    _dataSubscription?.cancel();

    if (labelPhoneEntryStream != null) {
      final mergedStream = pluginDataStream
          .map((data) => {'type': 'plugin', 'data': data})
          .mergeWith([
            labelPhoneEntryStream.map(
              (data) => {'type': 'label', 'data': data},
            ),
          ]);

      _dataSubscription = mergedStream.listen((event) {
        if (event['type'] == 'plugin') {
          _handleData(event['data'] as PluginSourceData, null);
        } else if (event['type'] == 'label') {
          _handleData(null, event['data'] as LabelPhoneEntry);
        }
      });
    } else {
      _dataSubscription = pluginDataStream.listen(
        (data) => _handleData(data, null),
      );
    }
  }

  Future<void> _handleData(
    PluginSourceData? pluginSourceData,
    LabelPhoneEntry? labelPhoneEntry,
  ) async {
    PhoneNumber? phoneNumber;
    if (pluginSourceData != null && pluginSourceData.phoneNumber != null) {
      phoneNumber = PhoneNumber.fromString(pluginSourceData.phoneNumber!);
    } else if (labelPhoneEntry != null) {
      phoneNumber = labelPhoneEntry.phoneNumber;
    } else {
      return;
    }

    if (phoneNumber.value.isEmpty) {
      return;
    }

    final existingEntry = await _remoteNumberService
        .getRemoteNumberByPhoneNumber(phoneNumber);

    if (existingEntry != null) {
      final updatedEntry = RemoteNumberEntry(
        id: existingEntry.id,
        phoneNumber: phoneNumber,
        name: _determineName(pluginSourceData, labelPhoneEntry, existingEntry),
        label: _determineLabel(pluginSourceData, existingEntry),
        priority: existingEntry.priority,
        count: pluginSourceData?.count ?? existingEntry.count,
        action: _determineAction(
          pluginSourceData,
          labelPhoneEntry,
          existingEntry,
        ),
        isEnabled: existingEntry.isEnabled,
      );
      final phoneDetails = await PhoneUtils.parsePhoneNumberWithoutIso(
        phoneNumber.value,
        null,
      );
      final countryCode = phoneDetails['countryCode'];

      await _remoteNumberService.updateRemoteNumber(
        updatedEntry,
        countryIsoCode: countryCode,
      );
    } else {
      final newEntry = RemoteNumberEntry(
        id: const Uuid().v4(),
        phoneNumber: phoneNumber,
        name: pluginSourceData?.name ?? labelPhoneEntry?.name ?? '',
        label: pluginSourceData?.predefinedLabel ?? '',
        priority: const RulePriority(0),
        count: pluginSourceData?.count ?? 0,
        action: _determineAction(pluginSourceData, labelPhoneEntry, null),
        isEnabled: true,
      );

      final phoneDetails = await PhoneUtils.parsePhoneNumberWithoutIso(
        phoneNumber.value,
        null,
      );
      final countryCode = phoneDetails['countryCode'];

      await _remoteNumberService.addRemoteNumber(
        newEntry,
        countryIsoCode: countryCode,
      );
    }
  }

  String _determineName(
    PluginSourceData? pluginSourceData,
    LabelPhoneEntry? labelPhoneEntry,
    RemoteNumberEntry existingEntry,
  ) {
    if (pluginSourceData?.name != null && pluginSourceData!.name!.isNotEmpty) {
      return pluginSourceData.name!;
    } else if (labelPhoneEntry != null && labelPhoneEntry.name.isNotEmpty) {
      return labelPhoneEntry.name;
    }
    return existingEntry.name;
  }

  String _determineLabel(
    PluginSourceData? pluginSourceData,
    RemoteNumberEntry existingEntry,
  ) {
    if (pluginSourceData?.predefinedLabel != null &&
        pluginSourceData!.predefinedLabel!.isNotEmpty) {
      return pluginSourceData.predefinedLabel!;
    }

    return existingEntry.label;
  }

  RuleAction _determineAction(
    PluginSourceData? pluginSourceData,
    LabelPhoneEntry? labelPhoneEntry,
    RemoteNumberEntry? existingEntry,
  ) {
    if (pluginSourceData != null &&
        pluginSourceData.action != RuleAction.none) {
      return pluginSourceData.action;
    }

    if (labelPhoneEntry != null && labelPhoneEntry.action != RuleAction.none) {
      return labelPhoneEntry.action;
    }

    return existingEntry?.action ?? RuleAction.none;
  }

  void dispose() {
    _dataSubscription?.cancel();
    _dataSubscription = null;
  }
}
