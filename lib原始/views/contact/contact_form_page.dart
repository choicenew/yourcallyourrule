import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../generated/l10n.dart';
import '../../new_set_icons.dart';
import '../../screens/appstate_provider.dart';
import '../../services/contact_service.dart';
import '../../utils/ad_manager.dart';
import '../../utils/avatar_edit_dialog.dart';
import '../../widgets/google_ad.dart';
import '../../widgets/navigation_bar.dart';
import '../subpage_style.dart';



class ContactFormPage extends StatefulWidget {
  final Contact? contact;
  final String? initialPhoneNumber; // 添加一个用于传递初始号码的参数

  const ContactFormPage({super.key, this.contact, this.initialPhoneNumber});

  @override
  ContactFormPageState createState() => ContactFormPageState();
}

class ContactFormPageState extends State<ContactFormPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  List<TextEditingController> _phoneControllers = [TextEditingController()]; // Change to a list
  late TextEditingController _emailController;
  late TextEditingController _labelController;
  late TextEditingController _groupController;
  late TextEditingController _websiteController;
  late TextEditingController _subscribedLinkController;
  late ContactService _contactService;
  String? _avatar;
  
  bool get isEditing => widget.contact != null;

 @override
  void initState() {
    super.initState();
    final appState = Provider.of<AppState>(context, listen: false);
    _contactService = appState.contactService;
    _initControllers();
  }

  void _initControllers() {
    final nameParts = widget.contact?.name.split(' ') ?? ['', ''];
    _firstNameController = TextEditingController(text: nameParts.first);
    _lastNameController = TextEditingController(text: nameParts.length > 1 ? nameParts.last : '');
    



  // 初始化电话号码控制器
  _phoneControllers = [];
  if (widget.initialPhoneNumber != null) {
    _phoneControllers.add(TextEditingController(text: widget.initialPhoneNumber)); // 使用传递的号码初始化
  } else if (widget.contact != null) {
    for (String phoneNumber in widget.contact!.phoneNumbers) {
      _phoneControllers.add(TextEditingController(text: phoneNumber));
    }
  } else {
    _phoneControllers.add(TextEditingController()); // 添加一个初始空字段
  }


    _emailController = TextEditingController(text: widget.contact?.email ?? '');
    _labelController = TextEditingController(text: widget.contact?.label ?? '');
    _groupController = TextEditingController(text: widget.contact?.group ?? '');
    _websiteController = TextEditingController(text: widget.contact?.website ?? '');
    _subscribedLinkController = TextEditingController(text: widget.contact?.url ?? '');
    _avatar = widget.contact?.avatar;
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    for (var controller in _phoneControllers) {
      // Dispose of all phone controllers
      controller.dispose();
    }
    _emailController.dispose();
    _labelController.dispose();
    _groupController.dispose();
    _websiteController.dispose();
    _subscribedLinkController.dispose();
    super.dispose();
  }

  bool isChinese(String text) {
    return text.codeUnits
        .every((codeUnit) => codeUnit >= 0x4E00 && codeUnit <= 0x9FFF);
  }

  Future<void> _saveContact() async {
    if (_formKey.currentState!.validate()) {
      String firstName = _firstNameController.text.trim();
      String lastName = _lastNameController.text.trim();

      String name = isChinese(firstName) || isChinese(lastName)
          ? "$lastName $firstName"
          : "$firstName $lastName";

      final contact = Contact(
        name: name,
        phoneNumbers: _phoneControllers
            .map((controller) => controller.text.trim())
            .toList(), // Collect all phone numbers
        email: _emailController.text,
        label: _labelController.text,
        group: _groupController.text,
        website: _websiteController.text,
        url: _subscribedLinkController.text,
        avatar: _avatar,
      );

      try {
        await _contactService.addOrUpdateContact(contact);

        // Clear the text fields
        _firstNameController.clear();
        _lastNameController.clear();
        for (var controller in _phoneControllers) {
          // Clear all phone fields
          controller.clear();
        }
        _emailController.clear();
        _labelController.clear();
        _groupController.clear();
        _websiteController.clear();
        _subscribedLinkController.clear();
        _avatar = null;

        // Optionally, fetch the updated contact
        // var result = await _contactService.getContactByName(name);
      } catch (e) {
        //
      }
    }
  }

  Future<void> _pickAvatar() async {
    showDialog(
      context: context,
      builder: (context) => AvatarEditDialog(
        avatarController: TextEditingController(text: _avatar), // 传递当前头像
        onAvatarChanged: (newAvatarPath) {
          setState(() {
            _avatar = newAvatarPath; // 更新头像
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            isEditing ? S.of(context).editContact : S.of(context).addContact),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                GestureDetector(
                  onTap: _pickAvatar,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey[200],
                    backgroundImage:
                        _avatar != null ? FileImage(File(_avatar!)) : null,
                    child: _avatar == null
                        ? Icon(Icons.edit, size: 30, color: Colors.grey[600])
                        : null,
                  ),
                ),
                const SizedBox(height: 16),
                _buildTextField(_firstNameController, S.of(context).firstName,
                    Icons.person),
                _buildTextField(
                    _lastNameController, S.of(context).lastName, Icons.person),

                // Phone number fields
                ..._phoneControllers.asMap().entries.map((entry) {
                  int index = entry.key;
                  TextEditingController controller = entry.value;
                  return _buildTextField(controller,
                      '${S.of(context).phone} ${index + 1}', Icons.phone);
                }),

                // Add button
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      _phoneControllers.add(TextEditingController());
                    });
                  },
                ),

                _buildTextField(
                    _emailController, S.of(context).email, Icons.email),
                _buildTextField(
                    _labelController, S.of(context).label, Icons.label),
                _buildTextField(
                    _groupController, S.of(context).group, Icons.group),
                _buildTextField(
                    _websiteController, S.of(context).website, Icons.language),
                _buildTextField(_subscribedLinkController,
                    S.of(context).subscribedLink, Icons.link),

                // 广告
                const GoogleAdWidget(adInfo: AdManager.bannerAd),
                const SizedBox(height: 16.0),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 16.0, bottom: 5.0, right: 16.0),
        child: Align(
          alignment: Alignment.bottomRight,
          child: ElevatedButton(
            onPressed: _saveContact,
            style: floatingButtonStyle,
            child: Row(
              mainAxisSize: MainAxisSize.min, // Use minimum size
              children: [
                const Icon(NewSet.add),
                const SizedBox(width: 8.0),
                Text(
                  S.of(context).save,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String label, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          filled: true,
          fillColor: Colors.grey[200],
        ),
        validator: (value) {
          if ((label == 'First name' || label == 'Phone') &&
              (value == null || value.isEmpty)) {
            return '${S.of(context).pleaseEnter} $label';
          }
          return null;
        },
      ),
    );
  }
}
