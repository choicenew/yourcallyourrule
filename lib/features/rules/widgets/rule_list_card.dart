import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/common/utils/avatar_utils.dart';
import 'package:yourcallyourrule/core/value_objects/phone_number.dart';
import 'package:yourcallyourrule/core/value_objects/rule_action.dart';
import 'package:yourcallyourrule/features/labels/utils/label_translation_utils.dart';
import 'package:yourcallyourrule/features/rules/utils/rule_action_display_utils.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

class RuleListCard extends ConsumerWidget {
  final String id;
  final String name;
  final PhoneNumber phoneNumber;
  final String labelId;
  final String? avatar;
  final bool isEnabled;
  final RuleAction action;
  final Map<String, String> labelIdToTextMap;
  final bool isMultiSelectMode;
  final bool isSelected;
  final Function(String, bool) onToggleStatus;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
//  final Function(String) onToggleSelection;
  final Color themeColor;

  const RuleListCard({
    super.key,
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.labelId,
    this.avatar,
    required this.isEnabled,
    required this.action,
    required this.labelIdToTextMap,
    required this.isMultiSelectMode,
    required this.isSelected,
    required this.onToggleStatus,
    required this.onEdit,
    required this.onDelete,
   // required this.onToggleSelection,
    this.themeColor = Colors.green,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final actionText =
        RuleActionDisplayUtils.getActionTypeName(context, action.type);
    final actionColor = RuleActionDisplayUtils.getActionTypeColor(action.type);

    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: AvatarUtils.getAvatarImage(avatar, labelIdToTextMap[labelId]),
                  child: const Icon(Icons.person), // Default icon
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        phoneNumber.value,
                        style: const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: isEnabled,
                  onChanged: (value) => onToggleStatus(id, value),
                  activeColor: themeColor,
                ),
                if (!isMultiSelectMode)
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: onEdit,
                  ),
                if (!isMultiSelectMode)
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: onDelete,
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Wrap(
                spacing: 8,
                children: [
                  Chip(
                    avatar: Icon(
                        RuleActionDisplayUtils.getActionTypeIcon(action.type),
                        color: actionColor,
                        size: 16),
                    label: Text('${AppLocalizations.of(context)!.actionType}: ${actionText}'),
                    backgroundColor: actionColor.withOpacity(0.1),
                    labelStyle: TextStyle(color: actionColor),
                  ),
                  if (labelId.isNotEmpty && labelIdToTextMap.containsKey(labelId))
                    Chip(
                      label: Text(
                          '${AppLocalizations.of(context)!.label}: ${LabelTranslationUtils.translateLabelText(context, labelIdToTextMap[labelId]!)}'),
                      backgroundColor: themeColor.withOpacity(0.1),
                      labelStyle: TextStyle(color: themeColor),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}