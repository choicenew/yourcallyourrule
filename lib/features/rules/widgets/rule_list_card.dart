import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/common/utils/avatar_utils.dart';
import 'package:yourcallyourrule/core/value_objects/phone_number.dart';
import 'package:yourcallyourrule/core/value_objects/rule_action.dart';
import 'package:yourcallyourrule/features/home_elite/theme/elite_dopamine_theme.dart';
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
    this.themeColor = Colors.green,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final actionText =
        RuleActionDisplayUtils.getActionTypeName(context, action.type);
    final actionColor = RuleActionDisplayUtils.getActionTypeColor(action.type);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: EliteDopamineTheme.warmCardDecoration(
        context: context,
        borderRadius: BorderRadius.circular(20),
        glowColor: isSelected ? themeColor : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                key: ValueKey(avatar ?? labelId),
                backgroundColor: AvatarUtils.getColorFromName(labelId),
                radius: 24,
                backgroundImage: AvatarUtils.getAvatarImage(avatar, labelIdToTextMap[labelId]),
                child: const Icon(Icons.person, color: Colors.white),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      phoneNumber.value,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Switch(
                value: isEnabled,
                onChanged: (value) => onToggleStatus(id, value),
                activeThumbColor: themeColor,
              ),
              if (!isMultiSelectMode) ...[
                IconButton(
                  icon: const Icon(Icons.edit_rounded, size: 20, color: Color(0xFF2D9CDB)),
                  onPressed: onEdit,
                  tooltip: AppLocalizations.of(context)!.edit,
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline_rounded, size: 20, color: Colors.redAccent),
                  onPressed: onDelete,
                  tooltip: AppLocalizations.of(context)!.delete,
                ),
              ],
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                decoration: BoxDecoration(
                  color: actionColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      RuleActionDisplayUtils.getActionTypeIcon(action.type),
                      color: actionColor,
                      size: 14,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      actionText,
                      style: TextStyle(
                        color: actionColor,
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
              if (labelId.isNotEmpty) ...[
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF7F5F0),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFEDE8DF)),
                  ),
                  child: Text(
                    labelIdToTextMap[labelId] ?? labelId,
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}