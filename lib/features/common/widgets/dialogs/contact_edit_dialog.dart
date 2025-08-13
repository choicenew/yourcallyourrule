import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:yourcallyourrule/core/entities/contact/contact_entry.dart';
import 'package:yourcallyourrule/features/common/widgets/public_select_label.dart';
import 'package:yourcallyourrule/features/contacts/services/contact_service.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';
import 'package:yourcallyourrule/core/provider/providers/contact_service_provider.dart';

/// 联系人编辑对话框
/// 用于添加或编辑联系人信息
class ContactEditDialog extends ConsumerStatefulWidget {
  final Contact? contact; // 可为null，表示添加新联系人
  final Function? onContactUpdated;
  final Color themeColor;

  const ContactEditDialog({
    super.key,
    this.contact,
    this.onContactUpdated,
    this.themeColor = Colors.blue,
  });

  @override
  ConsumerState<ContactEditDialog> createState() => _ContactEditDialogState();

  /// 显示联系人编辑对话框的静态方法
  static void show(BuildContext context, {Contact? contact, Function? onContactUpdated, Color themeColor = Colors.blue}) {
    showDialog(
      context: context,
      builder: (context) => ContactEditDialog(
        contact: contact,
        onContactUpdated: onContactUpdated,
        themeColor: themeColor,
      ),
    );
  }
}

class _ContactEditDialogState extends ConsumerState<ContactEditDialog> {
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  String? _selectedLabelId;
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.contact?.name ?? '');
    _phoneController = TextEditingController(
      text: widget.contact!.phoneNumbers.isNotEmpty 
          ? widget.contact!.phoneNumbers.join(', ') 
          : '',
    );
    _emailController = TextEditingController(text: widget.contact?.email ?? '');
    _selectedLabelId = widget.contact?.labelId;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _saveContact() async {
    // 验证输入
    if (_nameController.text.isEmpty || _phoneController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.nameAndPhoneNumberCannotBeEmpty),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    setState(() {
      _isProcessing = true;
    });

    try {
      final contactService = ref.read(contactServiceProvider);
      final bool isEditing = widget.contact != null;
      
      if (isEditing) {
        // 更新联系人
        final updatedContact = widget.contact!.copyWith(
          name: _nameController.text,
          phoneNumbers: _phoneController.text.split(',').map((e) => e.trim()).toList(),
          email: _emailController.text.isNotEmpty ? _emailController.text : null,
          labelId: _selectedLabelId,
        );
        await contactService.update(updatedContact);
      } else {
        // 添加新联系人
        final newContact = Contact(
          id: const Uuid().v4(),
          name: _nameController.text,
          phoneNumbers: _phoneController.text.split(',').map((e) => e.trim()).toList(),
          email: _emailController.text.isNotEmpty ? _emailController.text : null,
          labelId: _selectedLabelId,
        );
        await contactService.addContact(newContact);
      }

      // 调用回调函数
      if (widget.onContactUpdated != null) {
        widget.onContactUpdated!();
      }

      // 关闭对话框
      if (mounted) {
        Navigator.pop(context);

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(isEditing 
              ? AppLocalizations.of(context)!.contactUpdateSuccess
              : AppLocalizations.of(context)!.contactAddSuccess),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      // 显示错误提示
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(widget.contact != null 
              ? AppLocalizations.of(context)!.updateContactFailed( e.toString())
              : AppLocalizations.of(context)!.addContactFailed(e.toString())),
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
    final bool isEditing = widget.contact != null;
    final String title = isEditing 
      ? AppLocalizations.of(context)!.editContact
      : AppLocalizations.of(context)!.addContactButton;
    final String actionText = isEditing 
      ? AppLocalizations.of(context)!.save
      : AppLocalizations.of(context)!.add;

    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: widget.themeColor)),
            const SizedBox(height: 16),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.name,
                hintText: AppLocalizations.of(context)!.enterContactName,
                border: const OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: widget.themeColor),
                ),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.phoneNumber,
                hintText: AppLocalizations.of(context)!.enterPhoneNumberMultiple,
                border: const OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: widget.themeColor),
                ),
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.email,
                hintText: AppLocalizations.of(context)!.enterEmailOptional,
                border: const OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: widget.themeColor),
                ),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 8),
            PublicSelectLabel(
              initialLabelId: _selectedLabelId,
              onLabelIdChanged: (labelId) {
                setState(() {
                  _selectedLabelId = labelId;
                });
              },
              themeColor: widget.themeColor,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: _isProcessing ? null : () => Navigator.pop(context),
                  child: Text(AppLocalizations.of(context)!.cancelButton),
                ),
                ElevatedButton(
                  onPressed: _isProcessing ? null : _saveContact,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: widget.themeColor,
                    disabledBackgroundColor: widget.themeColor.withValues(alpha:0.5),
                  ),
                  child: _isProcessing
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : Text(actionText),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}