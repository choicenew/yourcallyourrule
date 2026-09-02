import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:yourcallyourrule/core/entities/contact/contact_entry.dart';
import 'package:yourcallyourrule/core/provider/providers/predefined_label_service_provider.dart';
import 'package:yourcallyourrule/features/common/widgets/public_select_label.dart';
import 'package:yourcallyourrule/features/contacts/provider/contact_service_provider.dart';
import 'package:yourcallyourrule/features/contacts/services/contact_service.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:yourcallyourrule/features/common/widgets/partials/avatar_crop_view.dart';

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
  static void show(
    BuildContext context, {
    Contact? contact,
    Function? onContactUpdated,
    Color themeColor = Colors.blue,
  }) {
    showDialog(
      context: context,
      builder:
          (context) => ContactEditDialog(
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
  late List<String> _selectedLabelIds;
  bool _isProcessing = false;

  // Avatar cropping state
  File? _croppingImage;
  bool _isCropping = false;
  Uint8List? _newAvatarBytes;

  Future<void> _pickImage() async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _croppingImage = File(pickedFile.path);
          _isCropping = true;
        });
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed to pick image: $e')));
      }
    }
  }

  void _onCrop(Uint8List bytes) {
    setState(() {
      _newAvatarBytes = bytes;
      _isCropping = false;
      _croppingImage = null;
    });
  }

  void _onCropCancel() {
    setState(() {
      _isCropping = false;
      _croppingImage = null;
    });
  }

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.contact?.name ?? '');
    _phoneController = TextEditingController(
      text: widget.contact?.phoneNumbers.join(', ') ?? '',
    );
    _emailController = TextEditingController(text: widget.contact?.email ?? '');
    _selectedLabelIds = widget.contact?.labelIds?.toList() ?? [];
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
          content: Text(
            AppLocalizations.of(context)!.nameAndPhoneNumberCannotBeEmpty,
          ),
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
        var updatedContact = widget.contact!.copyWith(
          name: _nameController.text,
          phoneNumbers:
              _phoneController.text.split(',').map((e) => e.trim()).toList(),
          email:
              _emailController.text.isNotEmpty ? _emailController.text : null,
          labelIds: _selectedLabelIds,
          avatar: widget.contact!.avatar,
        );

        // 如果有新头像，保存并更新
        if (_newAvatarBytes != null) {
          final directory = await getExternalStorageDirectory();
          if (directory != null) {
            final savedPath = await contactService.saveAvatar(
              _newAvatarBytes,
              directory,
            );
            if (savedPath != null) {
              updatedContact = updatedContact.copyWith(avatar: savedPath);
            }
          }
        }

        await contactService.update(updatedContact);
      } else {
        // 添加新联系人
        String? avatarPath;
        if (_newAvatarBytes != null) {
          final directory = await getExternalStorageDirectory();
          if (directory != null) {
            avatarPath = await contactService.saveAvatar(
              _newAvatarBytes,
              directory,
            );
          }
        }

        final newContact = Contact(
          id: const Uuid().v4(),
          name: _nameController.text,
          phoneNumbers:
              _phoneController.text.split(',').map((e) => e.trim()).toList(),
          email:
              _emailController.text.isNotEmpty ? _emailController.text : null,
          labelIds: _selectedLabelIds,
          avatar: avatarPath,
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
            content: Text(
              isEditing
                  ? AppLocalizations.of(context)!.contactUpdateSuccess
                  : AppLocalizations.of(context)!.contactAddSuccess,
            ),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      // 显示错误提示
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              widget.contact != null
                  ? AppLocalizations.of(
                    context,
                  )!.updateContactFailed(e.toString())
                  : AppLocalizations.of(
                    context,
                  )!.addContactFailed(e.toString()),
            ),
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

  Widget _buildLabelChips() {
    if (_selectedLabelIds.isEmpty) {
      return const SizedBox.shrink();
    }
    return Wrap(
      spacing: 8.0,
      runSpacing: 4.0,
      children:
          _selectedLabelIds.map((labelId) {
            return FutureBuilder<String?>(
              future: ref
                  .read(predefinedLabelServiceProvider)
                  .getLabelById(labelId)
                  .then((label) => label?.text),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Chip(
                    label: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  );
                }
                if (snapshot.hasData && snapshot.data != null) {
                  return Chip(
                    label: Text(snapshot.data!),
                    onDeleted: () {
                      setState(() {
                        _selectedLabelIds.remove(labelId);
                      });
                    },
                    deleteIconColor: widget.themeColor,
                  );
                }
                return const SizedBox.shrink();
              },
            );
          }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isEditing = widget.contact != null;
    final String title =
        isEditing
            ? AppLocalizations.of(context)!.editContact
            : AppLocalizations.of(context)!.addContactButton;
    final String actionText =
        isEditing
            ? AppLocalizations.of(context)!.save
            : AppLocalizations.of(context)!.add;

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
      title: _isCropping
          ? null
          : Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w900,
                color: widget.themeColor,
              ),
            ),
      content: SizedBox(
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _isCropping
                ? [
                    AvatarCropView(
                      imageFile: _croppingImage!,
                      onCrop: _onCrop,
                      onCancel: _onCropCancel,
                      themeColor: widget.themeColor,
                    ),
                  ]
                : [
                    Center(
                      child: GestureDetector(
                        onTap: _pickImage,
                        child: Stack(
                          children: [
                            CircleAvatar(
                              radius: 36,
                              backgroundColor: widget.themeColor.withValues(alpha: 0.1),
                              backgroundImage: _newAvatarBytes != null
                                  ? MemoryImage(_newAvatarBytes!)
                                  : (widget.contact?.avatar != null
                                      ? (widget.contact!.avatar!.startsWith('http')
                                          ? NetworkImage(widget.contact!.avatar!)
                                          : FileImage(File(widget.contact!.avatar!)) as ImageProvider)
                                      : null),
                              child: (_newAvatarBytes == null && widget.contact?.avatar == null)
                                  ? Icon(
                                      Icons.person_rounded,
                                      size: 36,
                                      color: widget.themeColor,
                                    )
                                  : null,
                            ),
                            Positioned(
                              right: 0,
                              bottom: 0,
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.camera_alt_rounded,
                                  size: 14,
                                  color: widget.themeColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.name,
                        hintText: AppLocalizations.of(context)!.enterContactName,
                        filled: true,
                        fillColor: const Color(0xFFF7F5F0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: const BorderSide(color: Color(0xFFEDE8DF)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: const BorderSide(color: Color(0xFFEDE8DF)),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _phoneController,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.phoneNumber,
                        hintText: AppLocalizations.of(context)!.enterPhoneNumberMultiple,
                        filled: true,
                        fillColor: const Color(0xFFF7F5F0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: const BorderSide(color: Color(0xFFEDE8DF)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: const BorderSide(color: Color(0xFFEDE8DF)),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      ),
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.email,
                        hintText: AppLocalizations.of(context)!.enterEmailOptional,
                        filled: true,
                        fillColor: const Color(0xFFF7F5F0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: const BorderSide(color: Color(0xFFEDE8DF)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: const BorderSide(color: Color(0xFFEDE8DF)),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 14),
                    _buildLabelChips(),
                    const SizedBox(height: 8),
                    PublicSelectLabel(
                      initialLabelId: null, // Always allow adding a new label
                      onLabelIdChanged: (labelId) {
                        if (labelId != null && !_selectedLabelIds.contains(labelId)) {
                          setState(() {
                            _selectedLabelIds.add(labelId);
                          });
                        }
                      },
                      themeColor: widget.themeColor,
                    ),
                  ],
          ),
        ),
      ),
      actions: _isCropping
          ? null
          : [
              TextButton(
                onPressed: _isProcessing ? null : () => Navigator.pop(context),
                child: Text(
                  AppLocalizations.of(context)!.cancelButton,
                  style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.w700),
                ),
              ),
              ElevatedButton(
                onPressed: _isProcessing ? null : _saveContact,
                style: ElevatedButton.styleFrom(
                  backgroundColor: widget.themeColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                  elevation: 0,
                ),
                child: _isProcessing
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : Text(actionText, style: const TextStyle(fontWeight: FontWeight.w800)),
              ),
            ],
    );
  }
}
