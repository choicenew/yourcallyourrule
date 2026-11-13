import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:pyro_phone_contacts_protocol/pyro_phone_contacts_protocol.dart';
import 'package:yourcallyourrule/features/common/widgets/public_select_label.dart';
import 'package:yourcallyourrule/features/contacts/services/contact_service.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'package:yourcallyourrule/features/common/widgets/partials/avatar_crop_view.dart';

class ContactEditDialog extends ConsumerStatefulWidget {
  final PhoneContactEntry? contact;
  final Function? onContactUpdated;
  final Color? themeColor;

  const ContactEditDialog({
    super.key,
    this.contact,
    this.onContactUpdated,
    this.themeColor,
  });

  @override
  ConsumerState<ContactEditDialog> createState() => _ContactEditDialogState();

  static void show(
    BuildContext context, {
    PhoneContactEntry? contact,
    Function? onContactUpdated,
    Color? themeColor,
  }) {
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
  bool _isProcessing = false;

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
    _nameController = TextEditingController(text: widget.contact?.displayName ?? '');
    _phoneController = TextEditingController(
      text: widget.contact?.phoneNumbers.join(', ') ?? '',
    );
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _saveContact() async {
    if (_nameController.text.isEmpty || _phoneController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            AppLocalizations.of(context).nameAndPhoneNumberCannotBeEmpty,
          ),
          backgroundColor: Theme.of(context).colorScheme.secondary,
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
        var updatedContact = widget.contact!.copyWith(
          displayName: _nameController.text,
          phoneNumbers: _phoneController.text.split(',').map((e) => e.trim()).toList(),
        );

        await contactService.editContact(updatedContact);
      } else {
        final newContact = PhoneContactEntry(
          id: const Uuid().v4(),
          displayName: _nameController.text,
          phoneNumbers: _phoneController.text.split(',').map((e) => e.trim()).toList(),
        );
        await contactService.addEntry(newContact);
      }

      if (widget.onContactUpdated != null) {
        widget.onContactUpdated!();
      }

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              isEditing
                  ? AppLocalizations.of(context).contactUpdateSuccess
                  : AppLocalizations.of(context).contactAddSuccess,
            ),
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              widget.contact != null
                  ? AppLocalizations.of(context).updateContactFailed(e.toString())
                  : AppLocalizations.of(context).addContactFailed(e.toString()),
            ),
            backgroundColor: Theme.of(context).colorScheme.error,
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
        ? AppLocalizations.of(context).editContact
        : AppLocalizations.of(context).addContactButton;
    final String actionText = isEditing
        ? AppLocalizations.of(context).save
        : AppLocalizations.of(context).add;

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Theme.of(context).colorScheme.outlineVariant, width: 1.0),
      ),
      contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
      title: _isCropping
          ? null
          : Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w900,
                color: widget.themeColor ?? Theme.of(context).colorScheme.primary,
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
                              backgroundColor: (widget.themeColor ?? Theme.of(context).colorScheme.primary).withValues(
                                alpha: 0.1,
                              ),
                              backgroundImage: _newAvatarBytes != null
                                  ? MemoryImage(_newAvatarBytes!)
                                  : null,
                              child: _newAvatarBytes == null
                                  ? Icon(
                                      Icons.person_rounded,
                                      size: 36,
                                      color: widget.themeColor ?? Theme.of(context).colorScheme.primary,
                                    )
                                  : null,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context).name,
                        hintText: AppLocalizations.of(context).enterContactName,
                        filled: true,
                        fillColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _phoneController,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context).phoneNumber,
                        hintText: AppLocalizations.of(context).enterPhoneNumberMultiple,
                        filled: true,
                        fillColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      keyboardType: TextInputType.phone,
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
                  AppLocalizations.of(context).cancelButton,
                ),
              ),
              ElevatedButton(
                onPressed: _isProcessing ? null : _saveContact,
                child: _isProcessing
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      )
                    : Text(actionText),
              ),
            ],
    );
  }
}
