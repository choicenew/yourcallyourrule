import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/entities/label/label_phone_entry.dart';
import 'package:yourcallyourrule/core/value_objects/phone_number.dart';
import 'package:yourcallyourrule/features/common/widgets/public_select_label.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';
import 'package:yourcallyourrule/core/provider/providers/rule_management_service_provider.dart';

/// 标记电话编辑对话框
/// 用于编辑标记电话条目
class MarkPhoneEditDialog extends ConsumerStatefulWidget {
  final LabelPhoneEntry entry;
  final Function? onEntryUpdated;
  final Color themeColor;

  const MarkPhoneEditDialog({
    super.key,
    required this.entry,
    this.onEntryUpdated,
    this.themeColor = const Color(0xFFF5A623),
  });

  @override
  ConsumerState<MarkPhoneEditDialog> createState() => _MarkPhoneEditDialogState();

  /// 显示标记电话编辑对话框的静态方法
  static void show(BuildContext context, LabelPhoneEntry entry, {Function? onEntryUpdated, Color themeColor = const Color(0xFFF5A623)}) {
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
    _phoneController = TextEditingController(text: widget.entry.phoneNumber.toString());
    _selectedLabelId = widget.entry.labelId;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _saveEntry() async {
    // 验证输入
    if (_phoneController.text.isEmpty || _selectedLabelId == null || _selectedLabelId!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${AppLocalizations.of(context)!.nameAndPhoneNumberCannotBeEmpty}, ${AppLocalizations.of(context)!.selectLabel}'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isProcessing = true;
    });

    try {
      // 更新标记电话条目
      final updatedEntry = LabelPhoneEntry(
        id: widget.entry.id,
        name: _nameController.text,
        phoneNumber: PhoneNumber.fromString(_phoneController.text),
        labelId: _selectedLabelId!,
        isEnabled: widget.entry.isEnabled,
      );

      final ruleService = ref.read(ruleManagementServiceProvider);
      // 使用保存方法而不是更新方法
      await ruleService.saveRule(updatedEntry);

      // 调用回调函数
      if (widget.onEntryUpdated != null) {
        widget.onEntryUpdated!();
      }

      // 关闭对话框
      if (mounted) {
        Navigator.pop(context);

        // 显示成功提示
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.ruleUpdateSuccess),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      // 显示错误提示
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:Text(AppLocalizations.of(context)!.updateRuleFailed(e.toString())),
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
    return AlertDialog(
      title: Text(AppLocalizations.of(context)!.edit),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context)!.name,
              hintText: AppLocalizations.of(context)!.name,
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _phoneController,
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context)!.phoneNumber,
              hintText: AppLocalizations.of(context)!.examplePhoneNumber,
            ),
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 16),
          // 标签选择器
          PublicSelectLabel(
            initialLabelId: _selectedLabelId,
            onLabelIdChanged: (labelId) {
              setState(() {
                _selectedLabelId = labelId;
              });
            },
            themeColor: widget.themeColor,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: _isProcessing ? null : () => Navigator.pop(context),
          child: Text(AppLocalizations.of(context)!.cancelButton),
        ),
        TextButton(
          onPressed: _isProcessing ? null : _saveEntry,
          child: _isProcessing
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Text(AppLocalizations.of(context)!.save),
        ),
      ],
    );
  }
}