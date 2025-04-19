import 'package:flutter/material.dart';
import '../../../common/utils/phone_utils.dart';
import '../base_widget.dart';

/// 规则表单组件
/// 用于添加和编辑规则
class RuleForm extends BaseStatefulWidget {
  final String? initialPhoneNumber;
  final String? initialName;
  final String? initialDescription;
  final Function(String phoneNumber, String name, String? description) onSubmit;

  const RuleForm({
    Key? key,
    this.initialPhoneNumber,
    this.initialName,
    this.initialDescription,
    required this.onSubmit,
  }) : super(key: key);

  @override
  RuleFormState createState() => RuleFormState();
}

class RuleFormState extends BaseStatefulWidgetState<RuleForm> {
  final _formKey = GlobalKey<FormState>();
  final _phoneNumberController = TextEditingController();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _phoneNumberController.text = widget.initialPhoneNumber ?? '';
    _nameController.text = widget.initialName ?? '';
    _descriptionController.text = widget.initialDescription ?? '';
  }

  @override
  void dispose() {
    _phoneNumberController.dispose();
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _phoneNumberController,
              decoration: const InputDecoration(
                labelText: '电话号码',
                hintText: '输入电话号码',
                prefixIcon: Icon(Icons.phone),
              ),
              keyboardType: TextInputType.phone,
              validator: _validatePhoneNumber,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: '名称',
                hintText: '输入规则名称',
                prefixIcon: Icon(Icons.label),
              ),
              validator: _validateName,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: '描述（可选）',
                hintText: '输入规则描述',
                prefixIcon: Icon(Icons.description),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _submitForm,
              child: const Text('保存'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 验证电话号码
  String? _validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return '请输入电话号码';
    }
    
    // 使用PhoneUtils验证电话号码格式
    if (!PhoneUtils.isValidPhoneNumber(value)) {
      return '请输入有效的电话号码';
    }
    
    return null;
  }

  // 验证名称
  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return '请输入规则名称';
    }
    return null;
  }

  // 提交表单
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      widget.onSubmit(
        _phoneNumberController.text.trim(),
        _nameController.text.trim(),
        _descriptionController.text.trim().isEmpty
            ? null
            : _descriptionController.text.trim(),
      );
    }
  }
}