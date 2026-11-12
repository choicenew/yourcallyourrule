import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:pyro_phone_marking_protocol/pyro_phone_marking_protocol.dart' hide PredefinedLabel;
import 'package:pyro_phone_remote_filter_protocol/pyro_phone_remote_filter_protocol.dart';
import 'package:yourcallyourrule/features/labels/services/predefined_label_service.dart';
import 'package:yourcallyourrule/features/remote_filter/services/remote_number_service.dart';
import 'package:yourcallyourrule/features/common/value_objects/phone_number.dart';

part 'label_phone_entry_to_remote.g.dart';

@Riverpod(keepAlive: true)
LabelPhoneEntryToRemote labelPhoneEntryToRemote(Ref ref) {
  final remoteNumberService = ref.watch(remoteNumberServiceProvider);
  final predefinedLabelService = ref.watch(predefinedLabelServiceProvider);
  return LabelPhoneEntryToRemote(remoteNumberService, predefinedLabelService);
}

class LabelPhoneEntryToRemote {
  final RemoteNumberService _remoteNumberService;
  final PredefinedLabelService _predefinedLabelService;

  LabelPhoneEntryToRemote(
    this._remoteNumberService,
    this._predefinedLabelService,
  );

  Future<void> syncSingleLabelToRemote(LabelPhoneEntry entry) async {
    await sync(entry);
  }

  Future<void> sync(LabelPhoneEntry labelPhoneEntry) async {
    final phoneNumberStr = labelPhoneEntry.phoneNumber;
    final voPhone = PhoneNumber.fromString(phoneNumberStr);

    final predefinedLabel = await _predefinedLabelService.getLabelById(
      labelPhoneEntry.labelId,
    );
    final labelText = predefinedLabel?.text ?? '';

    final existingEntry = await _remoteNumberService
        .getRemoteNumberByPhoneNumber(voPhone);

    if (existingEntry != null) {
      final updatedEntry = existingEntry.copyWith(
        name: labelPhoneEntry.name.isNotEmpty ? labelPhoneEntry.name : (existingEntry.name ?? ''),
        label: labelText,
      );
      await _remoteNumberService.updateRemoteNumber(updatedEntry);
    } else {
      final newEntry = RemoteNumberEntry(
        id: const Uuid().v4(),
        phoneNumber: phoneNumberStr,
        name: labelPhoneEntry.name,
        label: labelText,
        count: 0,
        actionType: 'block',
        isEnabled: true,
      );
      await _remoteNumberService.addRemoteNumber(newEntry);
    }
  }
}
