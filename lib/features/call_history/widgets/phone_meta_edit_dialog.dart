import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:pyro_phone_marking_protocol/pyro_phone_marking_protocol.dart';
import 'package:yourcallyourrule/features/call_history/entities/call_log.dart';
import 'package:yourcallyourrule/features/call_history/services/call_log_service.dart';
import 'package:yourcallyourrule/features/labels/services/label_service.dart';
import 'package:yourcallyourrule/features/common/widgets/public_select_label.dart';
import 'package:yourcallyourrule/features/labels/services/label_phone_entry_to_remote.dart';
import 'package:yourcallyourrule/features/labels/services/label_mark_statistics_sync_service.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

class PhoneMetaEditDialog extends ConsumerStatefulWidget {
  final CallLog log;

  const PhoneMetaEditDialog({super.key, required this.log});

  static Future<bool> show(BuildContext context, {required CallLog log}) async {
    final bool? dataChanged = await showDialog<bool>(
      context: context,
      builder: (_) => PhoneMetaEditDialog(log: log),
    );
    return dataChanged ?? false;
  }

  @override
  ConsumerState<PhoneMetaEditDialog> createState() => _PhoneMetaEditDialogState();
}

class _PhoneMetaEditDialogState extends ConsumerState<PhoneMetaEditDialog> {
  late TextEditingController _nameController;
  String? _selectedLabelId;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.log.name);
    _selectedLabelId = widget.log.labelIds?.firstOrNull;
  }
  
  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _saveChanges() async {
    setState(() => _isSaving = true);

    try {
      final newName = _nameController.text.trim();
      final callLogService = ref.read(callLogServiceProvider);
      
      final entryToProcess = await _createOrUpdateLabelPhoneEntry(newName, _selectedLabelId);

      await callLogService.updateLog(widget.log.copyWith(
        name: newName.isEmpty ? null : newName,
      ));

      if (entryToProcess != null) {
        final syncService = ref.read(labelPhoneEntryToRemoteProvider);
        await syncService.sync(entryToProcess);

        final statisticsSyncService = ref.read(labelMarkStatisticsSyncServiceProvider);
        await statisticsSyncService.syncSingleLabel(entryToProcess);
      }
      
      if (mounted) {
        Navigator.pop(context, true);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Error: $e"),
          backgroundColor: Colors.red,
        ));
      }
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  Future<LabelPhoneEntry?> _createOrUpdateLabelPhoneEntry(String newName, String? newLabelId) async {
    final labelService = ref.read(labelServiceProvider);
    
    final phoneStr = widget.log.phoneNumber;

    if (phoneStr.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(AppLocalizations.of(context).numberInvalidFormat)));
      }
      return null;
    }
      
    LabelPhoneEntry? existingEntry = await labelService.getLabelByPhoneNumber(phoneStr);
    LabelPhoneEntry entryToProcess;

    if (existingEntry != null) {
      entryToProcess = existingEntry.copyWith(
        name: newName, 
        labelId: newLabelId ?? '',
      );
      await labelService.updateLabel(entryToProcess);
    } else {
      entryToProcess = LabelPhoneEntry(
        id: const Uuid().v4(),
        phoneNumber: phoneStr,
        labelId: newLabelId ?? '',
        name: newName,
      );
      await labelService.addLabel(entryToProcess);
    }
    debugPrint('LabelPhoneEntry: ${entryToProcess.toMap()}');
    return entryToProcess;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: theme.colorScheme.outlineVariant, width: 1.0),
      ),
      title: Text(AppLocalizations.of(context).editRule),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context).name,
                hintText: AppLocalizations.of(context).enterName,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: theme.colorScheme.outlineVariant),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: theme.colorScheme.primary, width: 1.5),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              ),
            ),
            const SizedBox(height: 16),
            PublicSelectLabel(
              initialLabelId: _selectedLabelId,
              onLabelIdChanged: (newLabelId) {
                setState(() {
                  _selectedLabelId = newLabelId;
                });
              },
            ),
          ],
        ),
      ),
      actions: [
        if (!_isSaving)
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(AppLocalizations.of(context).cancelButton),
          ),
        ElevatedButton(
          onPressed: _isSaving ? null : _saveChanges,
          style: ElevatedButton.styleFrom(
            backgroundColor: theme.colorScheme.primary,
            foregroundColor: theme.colorScheme.onPrimary,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          child: _isSaving
              ? SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: theme.colorScheme.onPrimary,
                  ),
                )
              : Text(AppLocalizations.of(context).save),
        ),
      ],
    );
  }
}
