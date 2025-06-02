import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yourcallyourrule/core/entities/label/label_phone_entry.dart';
import 'package:yourcallyourrule/core/value_objects/phone_number.dart';
import 'package:yourcallyourrule/features/common/widgets/public_select_label.dart';
import 'package:yourcallyourrule/features/labels/services/label_service.dart';
import 'package:yourcallyourrule/features/labels/services/predefined_label_service.dart';

/// 标签编辑对话框
/// 用于编辑标签信息，通过 PublicSelectLabel 组件来选择标签
class LabelEditDialog extends StatefulWidget {
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
  State<LabelEditDialog> createState() => _LabelEditDialogState();

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

class _LabelEditDialogState extends State<LabelEditDialog> {
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
        const SnackBar(
          content: Text('请选择标签并输入有效的电话号码'),
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

      final labelService = Provider.of<LabelService>(context, listen: false);
      await labelService.updateLabel(updatedLabel);

      // 调用回调函数
      if (widget.onLabelUpdated != null) {
        widget.onLabelUpdated!();
      }

      // 关闭对话框
      if (mounted) {
        Navigator.pop(context);

        // 获取标签文本
        final predefinedLabelService = Provider.of<PredefinedLabelService>(context, listen: false);
        final labelText = await predefinedLabelService.getLabelById(_selectedLabelId);

        // 显示成功提示
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('标签 "${labelText?.text ?? _selectedLabelId}" 更新成功'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      // 显示错误提示
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('更新标签失败: $e'),
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
    final predefinedLabelService = Provider.of<PredefinedLabelService>(context, listen: false);
    final selectLabelService = PredefinedLabelServiceAdapter(predefinedLabelService);
    
    return AlertDialog(
      title: const Text('编辑标签'),
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
              decoration: const InputDecoration(
                labelText: '电话号码',
                hintText: '输入电话号码',
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _iconController,
              decoration: const InputDecoration(
                labelText: '图标代码（可选）',
                hintText: '输入图标代码',
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('取消'),
        ),
        TextButton(
          onPressed: _isProcessing ? null : _saveLabel,
          child: _isProcessing
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Text('保存', style: TextStyle(color: widget.themeColor)),
        ),
      ],
    );
  }
}