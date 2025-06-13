import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/entities/label/label_phone_entry.dart';
import 'package:yourcallyourrule/core/value_objects/phone_number.dart';
import 'package:yourcallyourrule/features/common/widgets/public_select_label.dart';
import 'package:yourcallyourrule/features/labels/services/label_service.dart';
import 'package:yourcallyourrule/features/labels/services/predefined_label_service.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';
import 'package:yourcallyourrule/core/provider/providers/label_service_provider.dart';
import 'package:yourcallyourrule/core/provider/providers/predefined_label_service_provider.dart';

/// 标签编辑对话框
/// 用于编辑标签信息，通过 PublicSelectLabel 组件来选择标签
class LabelEditDialog extends ConsumerStatefulWidget {
  final LabelPhoneEntry label;
  final Function? onLabelUpdated;
  final Color? themeColor;

  const LabelEditDialog({
    super.key,
    required this.label,
    this.onLabelUpdated,
    this.themeColor,
  });

  @override
  ConsumerState<LabelEditDialog> createState() => _LabelEditDialogState();

  /// 显示标签编辑对话框的静态方法
  static void show(BuildContext context, LabelPhoneEntry label, {Function? onLabelUpdated, Color? themeColor}) {
    showDialog(
      context: context,
      builder: (context) => LabelEditDialog(
        label: label,
        onLabelUpdated: onLabelUpdated,
        themeColor: themeColor,
      ),
    );
  }
}

class _LabelEditDialogState extends ConsumerState<LabelEditDialog> {
  String _selectedLabelId = '';
  bool _isProcessing = false;
  late TextEditingController _phoneController;
  late TextEditingController _iconController;

  @override
  void initState() {
    super.initState();
    _selectedLabelId = widget.label.labelId;
    _phoneController = TextEditingController(text: widget.label.phoneNumber.toString());
    _iconController = TextEditingController(text: widget.label.icon ?? '');
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _iconController.dispose();
    super.dispose();
  }

  Future<void> _saveLabel() async {
    // 验证输入
    final phoneText = _phoneController.text.trim();
    final iconText = _iconController.text.trim();
    
    if (_selectedLabelId.isEmpty || phoneText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.pleaseSelectLabelAndEnterValidPhone),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isProcessing = true;
    });

    try {
      // 更新标签
      final phoneNumber = PhoneNumber.fromString(phoneText);
      final updatedLabel = LabelPhoneEntry(
        id: widget.label.id,
        phoneNumber: phoneNumber,
        labelId: _selectedLabelId,
        icon: iconText.isNotEmpty ? iconText : null,
      );

      final labelService = ref.read(labelServiceProvider);
      await labelService.updateLabel(updatedLabel);

      // 调用回调函数
      if (widget.onLabelUpdated != null) {
        widget.onLabelUpdated!();
      }

      // 关闭对话框
      if (mounted) {
        Navigator.pop(context);

        // 获取标签文本
        final predefinedLabelService = ref.read(predefinedLabelServiceProvider);
        final labelText = await predefinedLabelService.getLabelById(_selectedLabelId);

        // 显示成功提示
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${AppLocalizations.of(context)!.labelUpdateSuccess}: $labelText?.text ?? _selectedLabelId}'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      // 显示错误提示
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.labelUpdateFailed(e.toString())),
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
    final predefinedLabelService = ref.read(predefinedLabelServiceProvider);
    final selectLabelService = PredefinedLabelServiceAdapter(predefinedLabelService);
    
    return AlertDialog(
      title: Text(AppLocalizations.of(context)!.editLabel),
      content: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PublicSelectLabel(
              initialLabelId: _selectedLabelId,
              onLabelIdChanged: (labelId) {
                setState(() {
                  _selectedLabelId = labelId;
                });
              },
              selectLabelService: selectLabelService,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.phoneNumber,
                hintText: AppLocalizations.of(context)!.enterPhoneNumber,
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _iconController,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.iconCodeOptional,
                hintText: AppLocalizations.of(context)!.enterIconCode,
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(AppLocalizations.of(context)!.cancel),
        ),
        TextButton(
          onPressed: _isProcessing ? null : _saveLabel,
          child: _isProcessing
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Text(AppLocalizations.of(context)!.save, style: TextStyle(color: widget.themeColor)),
        ),
      ],
    );
  }
}