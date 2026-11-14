import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_phone_marking_protocol/pyro_phone_marking_protocol.dart';
import 'package:yourcallyourrule/features/common/widgets/public_select_label.dart';
import 'package:yourcallyourrule/features/labels/services/label_service.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

class MarkPhoneEditDialog extends ConsumerStatefulWidget {
  final LabelPhoneEntry entry;
  final Function? onEntryUpdated;
  final Color? themeColor;

  const MarkPhoneEditDialog({
    super.key,
    required this.entry,
    this.onEntryUpdated,
    this.themeColor,
  });

  @override
  ConsumerState<MarkPhoneEditDialog> createState() => _MarkPhoneEditDialogState();

  static void show(BuildContext context, LabelPhoneEntry entry, {Function? onEntryUpdated, Color? themeColor}) {
    showDialog(
      context: context,
      builder: (context) => MarkPhoneEditDialog(
        entry: entry,
        onEntryUpdated: onEntryUpdated,
        themeColor: themeColor,
      ),
    );
  }
}

class _MarkPhoneEditDialogState extends ConsumerState<MarkPhoneEditDialog> {
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  String? _selectedLabelId;
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.entry.name);
    _phoneController = TextEditingController(text: widget.entry.phoneNumber);
    _selectedLabelId = widget.entry.labelId;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _saveEntry() async {
    if (_phoneController.text.isEmpty || _selectedLabelId == null || _selectedLabelId!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${AppLocalizations.of(context).nameAndPhoneNumberCannotBeEmpty}, ${AppLocalizations.of(context).selectLabel}'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isProcessing = true;
    });

    try {
      final updatedEntry = LabelPhoneEntry(
        id: widget.entry.id,
        name: _nameController.text,
        phoneNumber: _phoneController.text,
        labelId: _selectedLabelId!,
        isEnabled: widget.entry.isEnabled,
      );

      final labelPhoneService = ref.read(labelServiceProvider);
      await labelPhoneService.updateLabel(updatedEntry);

      if (widget.onEntryUpdated != null) {
        widget.onEntryUpdated!();
      }

      if (mounted) {
        Navigator.pop(context);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context).ruleUpdateSuccess),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context).updateRuleFailed(e.toString())),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isProcessing = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: theme.colorScheme.outlineVariant, width: 1.0),
      ),
      title: Text(AppLocalizations.of(context).edit),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context).name,
                hintText: AppLocalizations.of(context).name,
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
            const SizedBox(height: 12),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context).phoneNumber,
                hintText: AppLocalizations.of(context).examplePhoneNumber,
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
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 12),
            PublicSelectLabel(
              initialLabelId: _selectedLabelId,
              onLabelIdChanged: (labelId) {
                setState(() {
                  _selectedLabelId = labelId;
                });
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isProcessing ? null : () => Navigator.pop(context),
          child: Text(AppLocalizations.of(context).cancelButton),
        ),
        TextButton(
          onPressed: _isProcessing ? null : _saveEntry,
          child: _isProcessing
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Text(AppLocalizations.of(context).save),
        ),
      ],
    );
  }
}
