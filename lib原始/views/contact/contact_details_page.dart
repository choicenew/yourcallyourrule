

import 'dart:io';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../../generated/l10n.dart';
import '../../new_set_icons.dart';

import '../../screens/appstate_provider.dart';
import '../../services/allowed_blocked_service.dart';

import '../../services/contact_service.dart';
import '../../services/instant_app_service.dart';

import '../../widgets/navigation_bar.dart';

import '../label/add_label.dart';


import 'contact_form_page.dart';
import 'contact_style.dart';

class ContactDetailsPage extends StatefulWidget {
  final Contact contact;


  const ContactDetailsPage({super.key, required this.contact});
  @override
  ContactDetailsPageState createState() => ContactDetailsPageState();
}

class ContactDetailsPageState extends State<ContactDetailsPage> {
  bool _showWhatsApp = true;
  bool _showTelegram = true;

  late AllowedService _allowedService;
  late BlockedService _blockedService;
  late ContactService _contactService;
 @override
  void initState() {
    super.initState();
       _loadSettings();
    final appState = Provider.of<AppState>(context, listen: false);
    _allowedService = appState.allowedService;
    _blockedService = appState.blockedService;
     _contactService = appState.contactService; 
  }
 
bool _isAllowed = false;
bool _isBlocked = false;

void _onSwitchChanged(bool newValue) {
  setState(() {
    if (_isAllowed == _isBlocked) {
      // 当两个开关状态相同时（都为 false，因为它们不能同时为 true）
      if (newValue) {
        // 如果新值为 true，我们需要确定哪个开关被点击
        if (_isAllowed != newValue) {
          _isAllowed = true;
          _isBlocked = false;
        } else {
          _isBlocked = true;
          _isAllowed = false;
        }
      }
      // 如果新值为 false，不需要做任何改变，因为两个开关已经是 false
    } else {
      // 当两个开关状态不同时（一个为 true，一个为 false）
      if (newValue) {
        // 如果新值为 true，我们需要切换状态
        _isAllowed = !_isAllowed;
        _isBlocked = !_isBlocked;
      } else {
        // 如果新值为 false，我们只需要将当前为 true 的开关设为 false
        _isAllowed = false;
        _isBlocked = false;
      }
    }
  });
}



Future<void>  _loadSettings() async {
final SharedPreferencesAsync asyncPrefs = SharedPreferencesAsync();
    
      _showWhatsApp = await asyncPrefs.getBool('show_whatsapp') ?? true;
      _showTelegram = await asyncPrefs.getBool('show_telegram') ?? true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(S.of(context).contacts),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => _deleteContact(context),
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () => _shareContact(widget.contact),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildContactHeader(),
            _buildPrimaryActionButtons(),
            SizedBox(height: 16,),
            _buildSecondaryActionButtons(context),
           // _buildAllowBlockToggles(),
          // _buildLabelWidget(context, widget.contact.phoneNumbers[0]),
            _buildContactInfoFields(),
          ],
        ),
        
      ),
      
bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }

  Widget _buildContactHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: widget.contact.avatar != null
                ? FileImage(File(widget.contact.avatar!))
                : null,
            child: widget.contact.avatar == null
                ? Text(widget.contact.name[0], style: const TextStyle(fontSize: 40))
                : null,
          ),
          const SizedBox(height: 16),
          Text(widget.contact.name, style: ContactStyles.nameStyle),
          Text(widget.contact.phoneNumbers[0], style: ContactStyles.phoneStyle),
        ],
      ),
    );
  }

  Widget _buildPrimaryActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ActionButton(
          icon: Icons.video_call,
          label: S.of(context).video,
          onTap: () => openPhoneDialer(widget.contact.phoneNumbers[0]),
        ),
        ActionButton(
          icon: Icons.call,
          label: S.of(context).call,
          onTap: () => openPhoneDialer(widget.contact.phoneNumbers[0]),
        ),
        ActionButton(
          icon: Icons.message,
          label: S.of(context).message,
          onTap: () => openSMSMessage(widget.contact.phoneNumbers[0]),
        ),
      ],
    );
  }

  Widget _buildSecondaryActionButtons(BuildContext context) {
    List<Widget> buttons = [];

    if (_showWhatsApp) {
      buttons.add(ActionButton(
        icon: NewSet.whatsapp,
        label: S.of(context).whatsapp,
        onTap: () => openWhatsApp(
            context: context, phoneNumber: widget.contact.phoneNumbers[0]),
      ));
    }

    if (_showTelegram) {
      buttons.add(ActionButton(
        icon: Icons.telegram,
        label: S.of(context).telegram,
        onTap: () => openTelegram(
            context: context, phoneNumber: widget.contact.phoneNumbers[0]),
      ));
    }

    buttons.add(ActionButton(
      icon: Icons.edit,
      label: S.of(context).edit,
      onTap: () => _editContact(context),
    ));

    return Row(
      mainAxisAlignment: buttons.length == 1
          ? MainAxisAlignment.center
          : MainAxisAlignment.spaceEvenly,
      children: buttons,
    );
  }



//自定义添加labelpage 跳转
Widget _buildLabelWidget(BuildContext context, String phoneNumber) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Align( // 使用 Align 组件
      alignment: Alignment.topCenter, // 设置顶部对齐
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddLabelPage(initialPhoneNumber: phoneNumber),
                ),
              );
            },
            child: Text(S.of(context).addToLabel),
          ),

        ],
      ),
    ),
  );
}


  Widget _buildContactInfoFields() {
    return Column(
      children: [
        _buildInfoField(Icons.email, S.of(context).email, widget.contact.email ?? '',
            onTap: () {
          if (widget.contact.email != null &&
              widget.contact.email!.isNotEmpty) {
            openEmail(
                'mailto:${widget.contact.email}'); // 使用url_launcher打开邮件客户端
          }
        }),
        _buildInfoField(Icons.label, S.of(context).label, widget.contact.label ?? ''),
        _buildInfoField(Icons.group, S.of(context).group, widget.contact.group ?? ''),
        _buildInfoField(Icons.language, S.of(context).website, widget.contact.website ?? '',
            onTap: () {
          if (widget.contact.website != null &&
              widget.contact.website!.isNotEmpty) {
            launchInBrowser(
                Uri.parse(widget.contact.website!)); // 使用url_launcher打开链接
          }
        }),
        _buildInfoField(Icons.link, S.of(context).subscribedLink, widget.contact.url ?? '',
            onTap: () {
          if (widget.contact.url != null && widget.contact.url!.isNotEmpty) {
            launchInBrowser(
                Uri.parse(widget.contact.url!)); // 使用url_launcher打开链接
          }
        }),
      ],
    );
  }

  Widget _buildInfoField(IconData icon, String label, String value,
      {VoidCallback? onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: ContactStyles.iconColor),
          const SizedBox(width: 16),
          Expanded(
            child: InkWell(
              onTap: onTap, // 在这里设置点击事件
              child: Text(
                value,
                style: ContactStyles.fieldTextStyle.copyWith(
                  color: onTap != null
                      ? Colors.blue
                      : ContactStyles.fieldTextStyle.color,
                  decoration: onTap != null
                      ? TextDecoration.underline
                      : TextDecoration.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _deleteContact(BuildContext context) async {
    // Implement delete confirmation dialog
    bool confirmDelete = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(S.of(context).deleteContact),
          content: Text(S.of(context).areYouSureYouWantToDeleteThisContact),
          actions: <Widget>[
            TextButton(
              child: Text(S.of(context).cancel),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            TextButton(
              child: Text(S.of(context).delete),
              onPressed: () => Navigator.of(context).pop(true),
            ),
          ],
        );
      },
    );

    if (confirmDelete) {
      await _contactService.deleteContact(widget.contact.phoneNumbers[0]);
      Navigator.pop(context);
    }
  }

  void _shareContact(Contact contact) async {
    // Generate the .vcf file
    File vcfFile = await _contactService.generateVCFFile(contact);

    // Share the .vcf file
    await Share.shareXFiles(
      [XFile(vcfFile.path)],
      text: '${S.of(context).sharing} ${contact.name}.vcf',
      subject: S.of(context).contactFile,
    );
  }

  void _editContact(BuildContext context) {
    // Navigate to edit contact page
    // Navigator.push(context, MaterialPageRoute(builder: (context) => EditContactPage(contact: widget.contact)));
    // 编辑现有联系人
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ContactFormPage(contact: widget.contact)));
  }
}

class ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const ActionButton({super.key, required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: ContactStyles.actionButtonColor,
            child: Icon(icon, color: Colors.white),
          ),
          const SizedBox(height: 4),
          Text(label, style: ContactStyles.actionLabelStyle),
        ],
      ),
    );
  }
}
