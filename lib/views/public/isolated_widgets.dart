import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import '../../generated/l10n.dart';
import 'label_translation_extension.dart';


import '../../new_set_icons.dart';
import '../../utils/avatar_edit_dialog.dart';
import '../shield_switch_style.dart';
import '../subpage_style.dart';
// Import other necessary packages

// Avatar Widget
class AvatarWidget extends StatelessWidget {
  final String? avatar;
  final String label;
  final double size;

  const AvatarWidget({
    super.key,
    this.avatar,
    required this.label,
    this.size = 80.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.green,
          width: 2.0,
        ),
        image: DecorationImage(
          alignment: Alignment.center,
          image: _buildAvatarImage(),
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  ImageProvider _buildAvatarImage() {
    if (avatar != null && avatar!.isNotEmpty) {
      return avatar!.startsWith('http')
          ? NetworkImage(avatar!)
         // : AssetImage(avatar!) as ImageProvider;
         : AssetImage(
            avatar!.contains('assets/') ? avatar! : 'assets/avatars/$avatar.png',
          ) as ImageProvider;
    } else {
      return AssetImage('assets/avatars/$label.png');
    }
  }
}

// Phone Number Widget
class PhoneNumberWidget extends StatelessWidget {
  final String phoneNumber;

  const PhoneNumberWidget({super.key, required this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    return Text(
      phoneNumber,
      style: entryTitleStyle,
      overflow: TextOverflow.ellipsis,
    );
  }
}

// keyword Widget
class KeywordWidget extends StatelessWidget {
  final String keyword;

  const KeywordWidget({super.key, required this.keyword});

  @override
  Widget build(BuildContext context) {
    return Text(
      keyword,
      style: entryTitleStyle,
      overflow: TextOverflow.ellipsis,
    );
  }
}




// Label and Name Widget
class LabelAndNameWidget extends StatelessWidget {
  final String? label;
  final String? name;

  const LabelAndNameWidget({super.key, this.label, this.name});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (label != null) ...[
          Text(
            label!.translate(context),  // 使用扩展方法翻译标签
            style: entryLabelStyle,
          ),
          const SizedBox(width: 8.0),
        ],
        Expanded(
          child: Text(
            name ?? '',
            style: entryNameStyle,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}



// Status Icon Widget
class StatusIconWidget extends StatelessWidget {
  final bool isSubscribed;

  const StatusIconWidget({super.key, required this.isSubscribed});

  @override
  Widget build(BuildContext context) {
    return Icon(
      isSubscribed ? NewSet.link : NewSet.link_off,
      color: isSubscribed ? onlineStatusIconColor : offlineStatusIconColor,
      size: statusIconSize,
    );
  }
}

// Status Icon Widget
class TypeStatusIconWidget extends StatelessWidget {
  final bool isNumberType;

  const TypeStatusIconWidget({super.key, required this.isNumberType});

  @override
  Widget build(BuildContext context) {
    return Icon(
      isNumberType ? Icons.onetwothree_outlined : Icons.translate_outlined,
      color: isNumberType ? onlineStatusIconColor : offlineStatusIconColor,
      size: statusIconSize,
    );
  }
}





// Delete Button Widget
class DeleteButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;

  const DeleteButtonWidget({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.delete),
      iconSize: 32.0,
      style: deleteButtonStyle,
      onPressed: onPressed,
    );
  }
}

// Expansion Icon Widget
class ExpansionIconWidget extends StatelessWidget {
  final bool isExpanded;

  const ExpansionIconWidget({super.key, required this.isExpanded});

  @override
  Widget build(BuildContext context) {
    return Icon(isExpanded ? Icons.expand_less : Icons.expand_more);
  }
}


class ShieldSwitchWidget extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final String title;
  final Color titleColor;

  const ShieldSwitchWidget({
    super.key,
    required this.value,
    required this.onChanged,
    required this.title,
    required this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: AppSwitchTheme.apply(context, shieldSwitchTheme),
      child: SwitchListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        value: value,
        onChanged: onChanged,
        title: Text(
          title,
          style: TextStyle(color: titleColor),
        ),
      ),
    );
  }
}

// Switch Row Widget
class SwitchRowWidget extends StatelessWidget {
  final bool isAllowed;
  final bool isBlocked;
  final Function(bool) onSwitchChanged;
  final String allowedType; // 新增参数：允许类型（"Whitelist" 或 "Allowed"）
  final String blockedType; // 新增参数：阻止类型（"Blacklist" 或 "Blocked"）

  const SwitchRowWidget({
    super.key,
    required this.isAllowed,
    required this.isBlocked,
    required this.onSwitchChanged,
    required this.allowedType, // 必须传入
    required this.blockedType, // 必须传入
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Theme(
            data: AppSwitchTheme.apply(context, shieldSwitchTheme),
            child: SwitchListTile(
              contentPadding: const EdgeInsets.only(top: 16, left: 16),
              value: isAllowed,
              onChanged: onSwitchChanged,
title: Text(
  isAllowed
      ? S.of(context).addToAllowedtype(allowedType)
      : S.of(context).removeAllowedtype(allowedType),
  style: whiteTextStyle,
),
            ),
          ),
        ),
        Expanded(
          child: Theme(
            data: AppSwitchTheme.apply(context, shieldSwitchTheme),
            child: SwitchListTile(
              contentPadding: const EdgeInsets.only(top: 16, right: 16),
              value: isBlocked,
              onChanged: onSwitchChanged,
   title: Text(
  isBlocked
      ? S.of(context).addToBlockedtype(blockedType) // isAllowed 为 true
      : S.of(context).removeBlockedtype(blockedType), // isAllowed 为 false
  style: whiteTextStyle,
),           


            ),
          ),
        ),
      ],
    );
  }
}

class AvatarEditSectionWidget extends StatefulWidget {
  final String? avatar; // 传入当前头像路径
  final String label; // 传入默认头像标签
  final Function(String) onAvatarChanged; // 回调函数，用于更新头像路径

  const AvatarEditSectionWidget({
    super.key,
    required this.avatar,
    required this.label,
    required this.onAvatarChanged,
  });

  @override
  State<AvatarEditSectionWidget> createState() =>
      _AvatarEditSectionWidgetState();
}

class _AvatarEditSectionWidgetState extends State<AvatarEditSectionWidget> {
  late TextEditingController _avatarController;

  @override
  void initState() {
    super.initState();
    _avatarController = TextEditingController(text: widget.avatar);
  }

  @override
  void dispose() {
    _avatarController.dispose();
    super.dispose();
  }

  void _showAvatarEditDialog() {
    showDialog(
      context: context,
      builder: (context) => AvatarEditDialog(
        avatarController: _avatarController,
        onAvatarChanged: (newAvatarPath) {
          setState(() {
            _avatarController.text = newAvatarPath;
            widget.onAvatarChanged(newAvatarPath); // 调用回调函数更新头像路径
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(S.of(context).chooseAvatarLocalOrNetwork),
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: _showAvatarEditDialog,
            ),
          ],
        ),
        TextFormField(
          controller: _avatarController,
          decoration:
              InputDecoration(labelText: S.of(context).avatarUrlOrPath),
          readOnly: true, // 设置为只读，防止用户手动输入
        ),
      ],
    );
  }
}

// Name Input Widget
class NameInputWidget extends StatelessWidget {
  final TextEditingController nameController;

  const NameInputWidget({super.key, required this.nameController});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0),
      child: TextFormField(
        controller: nameController,
        decoration: showmoreinputBoxDecoration.copyWith(
          labelText: S.of(context).name,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}


// Phonenumber Input Widget
class PhoneNumberInputWidget extends StatelessWidget {
  final TextEditingController phoneNumberController;

  const PhoneNumberInputWidget({super.key, required this.phoneNumberController});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0),
      child: TextFormField(
        controller: phoneNumberController,
        decoration: showmoreinputBoxDecoration.copyWith(
          labelText: S.of(context).phonenumber,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}

// Phonenumber Input Widget
class KeywordInputWidget extends StatelessWidget {
  final TextEditingController keywordController;

  const KeywordInputWidget({super.key, required this.keywordController});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0),
      child: TextFormField(
        controller: keywordController,
        decoration: showmoreinputBoxDecoration.copyWith(
          labelText: S.of(context).keyword,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}

// Pattern Input Widget
class PatternInputWidget extends StatelessWidget {
  final TextEditingController patternController;

  const PatternInputWidget({super.key, required this.patternController});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0),
      child: TextFormField(
        controller: patternController,
        decoration: showmoreinputBoxDecoration.copyWith(
          labelText: S.of(context).pattern,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}


// Action Button Widget
class ActionButtonWidget extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  final Color? pressedColor;

  const ActionButtonWidget({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressed,
    this.pressedColor,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: 
      
      showmoreButtonStyle.copyWith(
        foregroundColor:
            WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
          if (states.contains(WidgetState.pressed)) {
            return pressedColor ?? Colors.green;
          }
          return null;
        }),
      ),
      
      
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon),
          const SizedBox(width: 8.0),
          Text(label),
        ],
      ),
    );
  }
}



// Subscription Title Widget
class SubscriptionTitleWidget extends StatelessWidget {
  final String name;

  const SubscriptionTitleWidget({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      style: entryTitleStyle,
      overflow: TextOverflow.ellipsis,
    );
  }
}

// Subscription Url Widget
class SubscriptionUrlWidget extends StatelessWidget {
  final String url;

  const SubscriptionUrlWidget({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Text(
        url,
        style: entryLabelStyle,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

// Subscription Status Icon Widget
class SubscriptionStatusIconWidget extends StatelessWidget {
  final bool isBlacklist;
  final bool isWhitelist;

  const SubscriptionStatusIconWidget({
    super.key,
    required this.isBlacklist,
    required this.isWhitelist,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      isBlacklist
          ? NewSet.blacklist_fill
          : isWhitelist
              ? NewSet.whitelist_fill
              : null,
      color: isBlacklist
          ? blackStatusIconColor
          : isWhitelist
              ? whiteStatusIconColor
              : offlineStatusIconColor,
      size: statusIconSize,
    );
  }
}

// Auto Update Button Widget
class AutoUpdateButtonWidget extends StatelessWidget {
  final bool isAutoUpdate;
  final VoidCallback onPressed;

  const AutoUpdateButtonWidget({
    super.key,
    required this.isAutoUpdate,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isAutoUpdate ? NewSet.autorenew : NewSet.sync_disabled,
        color: isAutoUpdate ? onlineStatusIconColor : offlineStatusIconColor,
        size: statusIconSize,
      ),
      onPressed: onPressed,
    );
  }
}



// EnableDisableButtonWidget 不需要修改
class EnableDisableButtonWidget extends StatelessWidget {
  final bool isEnabled;
  final VoidCallback onPressed;

  const EnableDisableButtonWidget({
    super.key,
    required this.isEnabled,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: isEnabled
          ? const Icon(Icons.toggle_on)
          : const Icon(Icons.toggle_off),
      color: isEnabled ? Colors.green : Colors.grey,
      onPressed: onPressed,
    );
  }
}


// ... 其他公共 Widget ...

// 提取 _toggleSubscriptionEnabled 方法到 common_widgets.dart


// Subscription List Actions Widget
class SubscriptionListActionsWidget extends StatelessWidget {
  final VoidCallback onDeletePressed;
  final VoidCallback onSavePressed;

  const SubscriptionListActionsWidget({
    super.key,
    required this.onDeletePressed,
    required this.onSavePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        FilledButton(
          style: showmoreButtonStyle.copyWith(
            foregroundColor: WidgetStateProperty.resolveWith<Color?>(
              (Set<WidgetState> states) {
                if (states.contains(WidgetState.pressed)) {
                  return Colors.green;
                }
                return null;
              },
            ),
          ),
          onPressed: onDeletePressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(NewSet.delete),
              const SizedBox(width: 8.0),
              Text(
                S.of(context).delete,
              ),
            ],
          ),
        ),
        const SizedBox(width: 16.0),
        FilledButton(
          onPressed: onSavePressed,
          style: showmoreButtonStyle,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(NewSet.check),
              const SizedBox(width: 8.0),
              Text(
                S.of(context).save,
              ),
            ],
          ),
        ),
      ],
    );
  }
}





// 新增: SubscriptionUrlInputWidget
class UrlInputWidget extends StatelessWidget {
  final TextEditingController urlController;

  const UrlInputWidget({super.key, required this.urlController});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0),
      child: TextFormField(
        controller: urlController,
        decoration: showmoreinputBoxDecoration.copyWith(
          labelText: S.of(context).url,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}

// 新增: SubscriptionAutoUpdateSwitchWidget
class SubscriptionAutoUpdateSwitchWidget extends StatelessWidget {
  final bool isAutoUpdate;
  final ValueChanged<bool> onChanged;

  const SubscriptionAutoUpdateSwitchWidget({
    super.key,
    required this.isAutoUpdate,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: AppSwitchTheme.apply(context, switchTheme),
      child: SwitchListTile(
        title: Text(
          isAutoUpdate
              ? S.of(context).autoUpdateEnabled
              : S.of(context).autoUpdateDisabled,
        ),
        value: isAutoUpdate,
        onChanged: onChanged,
      ),
    );
  }
}

// 新增: SubscriptionNumberTypeSwitchWidget
class SubscriptionNumberTypeSwitchWidget extends StatelessWidget {
  final bool isNumberType;
  final ValueChanged<bool> onChanged;

  const SubscriptionNumberTypeSwitchWidget({
    super.key,
    required this.isNumberType,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: AppSwitchTheme.apply(context, switchTheme),
      child: SwitchListTile(
        title: Text(
          isNumberType
              ? S.of(context).numberType
              : S.of(context).textType,
        ),
        value: isNumberType,
        onChanged: onChanged,
      ),
    );
  }
} 

// 新增: SubscriptionNumberTypeSwitchWidget
class SubscriptionEnabledSwitchWidget extends StatelessWidget {
  final bool enabled;
  final ValueChanged<bool> onChanged;

  const SubscriptionEnabledSwitchWidget({
    super.key,
    required this.enabled,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: AppSwitchTheme.apply(context, switchTheme),
      child: SwitchListTile(
        title: Text(
          enabled
              ? S.of(context).enabled
              : S.of(context).disabled,
        ),
        value: enabled,
        onChanged: onChanged,
      ),
    );
  }
}


// Subscription Status Switch Widget
class SubscribedSwitchWidget extends StatelessWidget {
  final bool isSubscribed;
  final ValueChanged<bool> onChanged;

  const SubscribedSwitchWidget({
    super.key,
    required this.isSubscribed,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: AppSwitchTheme.apply(context, shieldSwitchTheme), // 你可以在 common_widgets.dart 中定义这个主题
      child: SwitchListTile(
        title: Text(
          isSubscribed
              ? S.of(context).isSubscribed
              : S.of(context).isNotSubscribed,
          style: whiteTextStyle, // 你可以在 common_widgets.dart 中定义这个样式
        ),
        value: isSubscribed,
        onChanged: onChanged,
      ),
    );
  }
}

// 独立的文件选择器 Widget
class FilePickerWidget extends StatelessWidget {
  final Function(String?) onFilePathChanged;
  final String? filePath; // 当前文件路径
  final double? textFieldHeight;
  final BoxDecoration? inputBoxDecoration;
  final TextStyle? inputTextStyle;


  const FilePickerWidget({
    super.key,
    required this.onFilePathChanged,
    this.filePath,
    this.textFieldHeight, // 不再设置默认值
    this.inputBoxDecoration,
    this.inputTextStyle,

  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          child: Container(
            height: textFieldHeight ?? 68.0, // 使用 ?? 运算符设置默认值
            decoration: inputBoxDecoration,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left:16),
                  child: Text(
                    S.of(context).openLocalFolder,
                    style: inputTextStyle,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 16.0),
                  child: Icon(Icons.folder_open, color: Colors.blue),
                ),
              ],
            ),
          ),
          onTap: () async {
            FilePickerResult? result = await FilePicker.platform.pickFiles(
              type: FileType.any,
            );

            if (result != null && result.files.isNotEmpty) {
              final file = result.files.single;
              onFilePathChanged(file.path);
            }
          },
        ),
        const SizedBox(height: 16.0),
        if (filePath != null)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
child: Text(filePath!),
            ),
          ),
      ],
    );
  }
}




// Generic Delete Confirmation Dialog
Future<void> showDeleteConfirmationDialog<T>(
    BuildContext context,
    T entry,
    Future<void> Function(T) removeEntry,
    {String? displayText}) async {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(S.of(context).confirmDeletion),
      content: Text(
          '${S.of(context).areYouSureYouWantToDeleteTheItem} ${displayText ?? entry}?'),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(S.of(context).cancel),
        ),
        TextButton(
          onPressed: () async {
            Navigator.of(context).pop();
            await removeEntry(entry);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text(
                      '${S.of(context).deleted} ${displayText ?? entry} ${S.of(context).successfully}'
                      )),
            );
          },
          child: Text(S.of(context).ok),
        ),
      ],
    ),
  );
}



