import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/provider/predefined_labels_provider.dart';
import 'package:yourcallyourrule/features/labels/services/label_phone_entry_to_remote.dart';
import 'package:yourcallyourrule/features/remote_filter/provider/remote_number_service_provider.dart';

final labelPhoneEntryToRemoteProvider = Provider<LabelPhoneEntryToRemote>((ref) {
  final remoteNumberService = ref.watch(remoteNumberServiceProvider);
  final predefinedLabelService = ref.watch(predefinedLabelServiceProvider);
  return LabelPhoneEntryToRemote(remoteNumberService, predefinedLabelService);
});