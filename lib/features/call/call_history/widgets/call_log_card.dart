// lib/features/call/call_history/widgets/call_log_card.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:yourcallyourrule/common/utils/avatar_utils.dart';
import 'package:yourcallyourrule/core/entities/call/call_log.dart';
import 'package:yourcallyourrule/core/entities/call/local_call_type.dart';
import 'package:yourcallyourrule/features/call/call_history/utils/call_history_action_handler.dart';
import 'package:yourcallyourrule/features/call/call_history/widgets/phone_meta_edit_dialog.dart';
import 'package:yourcallyourrule/features/call/call_history/widgets/rule_action_dialog.dart';
import 'package:yourcallyourrule/features/labels/utils/label_translation_utils.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

class _CallTypeInfo {
  final IconData icon;
  final Color color;
  final String text;
  _CallTypeInfo({required this.icon, required this.color, required this.text});
}

class CallLogCard extends ConsumerWidget {
  final CallLog log;
  final Map<String, String> labelIdToTextMap;
  final Map<String, String>? labelIdToIconMap;
  final VoidCallback onRequiresRefresh;
  final bool isMultiSelectMode;
  final bool isSelected;
  final VoidCallback? onMultiSelectTap;

  const CallLogCard({
    super.key,
    required this.log,
    required this.labelIdToTextMap,
    this.labelIdToIconMap,
    required this.onRequiresRefresh,
    this.isMultiSelectMode = false,
    this.isSelected = false,
    this.onMultiSelectTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final actionHandler = CallHistoryActionHandler(
      context: context,
      ref: ref,
      log: log,
      onRequiresRefresh: onRequiresRefresh,
    );

    final callTypeInfo = _getCallTypeInfo(context, log.callType);
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 5.0),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSelected
              ? theme.colorScheme.primary
              : theme.colorScheme.outlineVariant,
          width: isSelected ? 1.8 : 1.1,
        ),
        boxShadow: [
          BoxShadow(
            color: isSelected
                ? theme.colorScheme.primary.withValues(alpha: 0.16)
                : Colors.black.withValues(alpha: 0.04),
            blurRadius: isSelected ? 14 : 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onMultiSelectTap,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
            child: isMultiSelectMode
                ? Row(
                    children: [
                      Checkbox(
                        value: isSelected,
                        onChanged: (_) => onMultiSelectTap?.call(),
                        activeColor: theme.colorScheme.primary,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _buildCardContent(context, ref, actionHandler, callTypeInfo),
                      ),
                    ],
                  )
                : _buildCardContent(context, ref, actionHandler, callTypeInfo),
          ),
        ),
      ),
    );
  }

  Widget _buildCardContent(
    BuildContext context,
    WidgetRef ref,
    CallHistoryActionHandler actionHandler,
    _CallTypeInfo callTypeInfo,
  ) {
    final theme = Theme.of(context);
    final rawLabelText = labelIdToTextMap[log.labelId];
    final translatedLabelText = rawLabelText != null
        ? LabelTranslationUtils.translateLabelText(context, rawLabelText)
        : null;

    final primaryAvatar = log.matchedContactAvatarPath ?? log.avatarPath;
    final simInfo = '${log.simDisplayName} ${log.carrierName}'.trim();
    final hasSimInfo = simInfo.isNotEmpty;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 44,
          height: 44,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              CircleAvatar(
                radius: 22,
                backgroundImage: AvatarUtils.getAvatarImage(primaryAvatar, translatedLabelText),
                backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.12),
                child: primaryAvatar == null && (translatedLabelText == null || translatedLabelText.isEmpty)
                    ? Icon(Icons.person, size: 24, color: theme.colorScheme.primary)
                    : null,
              ),
              Positioned(
                right: -2,
                bottom: -2,
                child: Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: callTypeInfo.color,
                    shape: BoxShape.circle,
                    border: Border.all(color: theme.colorScheme.surface, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.12),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Icon(
                    callTypeInfo.icon,
                    size: 11,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      log.callerDisplayName.isNotEmpty
                          ? log.callerDisplayName
                          : log.phoneNumber.toString(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 15,
                        letterSpacing: -0.2,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    DateFormat.Hm().format(log.timestamp),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              if (log.callerDisplayName.isNotEmpty) ...[
                const SizedBox(height: 2),
                Text(
                  log.phoneNumber.toString(),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
              const SizedBox(height: 6),
              Wrap(
                spacing: 6,
                runSpacing: 4,
                cross: WrapCrossAlignment.center,
                children: [
                  if (translatedLabelText != null && translatedLabelText.isNotEmpty)
                    _buildLabelChip(context, ref, translatedLabelText),
                  if (log.location.isNotEmpty)
                    _buildRegionChip(context, log.location),
                  if (hasSimInfo)
                    _buildSimChip(context, simInfo),
                ],
              ),
              const SizedBox(height: 10),
              _buildBottomActionRow(context, ref, actionHandler),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBottomActionRow(
    BuildContext context,
    WidgetRef ref,
    CallHistoryActionHandler actionHandler,
  ) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Icon(
          Icons.access_time_rounded,
          size: 12,
          color: theme.colorScheme.onSurfaceVariant,
        ),
        const SizedBox(width: 4),
        Text(
          DateFormat('MM-dd').format(log.timestamp),
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const Spacer(),
        _buildActionButton(
          context: context,
          icon: Icons.info_outline_rounded,
          color: theme.colorScheme.secondary,
          tooltip: AppLocalizations.of(context)!.viewDetails,
          onTap: () => _showCallDetailsDialog(context),
        ),
        const SizedBox(width: 6),
        _buildActionButton(
          context: context,
          icon: Icons.label_outline_rounded,
          color: theme.colorScheme.tertiary,
          tooltip: AppLocalizations.of(context)!.addLabel,
          onTap: () async {
            final updated = await PhoneMetaEditDialog.show(context, log: log);
            if (updated && context.mounted) onRequiresRefresh();
          },
        ),
        const SizedBox(width: 6),
        _buildActionButton(
          context: context,
          icon: log.callType == LocalCallType.blocked ? Icons.lock_open_rounded : Icons.phone_outlined,
          color: log.callType == LocalCallType.blocked ? theme.colorScheme.secondary : theme.colorScheme.primary,
          tooltip: log.callType == LocalCallType.blocked
              ? AppLocalizations.of(context)!.unblock
              : AppLocalizations.of(context)!.call,
          onTap: actionHandler.handleCallAction,
        ),
        const SizedBox(width: 6),
        _buildActionButton(
          context: context,
          icon: Icons.rule_folder_outlined,
          color: theme.colorScheme.primary,
          tooltip: AppLocalizations.of(context)!.addRule,
          onTap: () => _showRuleActionDialog(context),
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required BuildContext context,
    required IconData icon,
    required String tooltip,
    required VoidCallback onTap,
    Color? color,
  }) {
    final activeColor = color ?? Theme.of(context).colorScheme.onSurfaceVariant;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.all(7),
        decoration: BoxDecoration(
          color: activeColor.withValues(alpha: 0.10),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, size: 16, color: activeColor),
      ),
    );
  }

  Widget _buildLabelChip(BuildContext context, WidgetRef ref, String labelText) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
      decoration: BoxDecoration(
        color: theme.colorScheme.error.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: theme.colorScheme.error.withValues(alpha: 0.25),
        ),
      ),
      child: Text(
        labelText,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: theme.colorScheme.error,
        ),
      ),
    );
  }

  Widget _buildRegionChip(BuildContext context, String regionText) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1.5),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        regionText,
        style: TextStyle(
          fontSize: 9.5,
          fontWeight: FontWeight.w700,
          color: theme.colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }

  Widget _buildSimChip(BuildContext context, String simText) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1.5),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.sim_card_outlined,
            size: 10,
            color: theme.colorScheme.onSurfaceVariant,
          ),
          const SizedBox(width: 3),
          Text(
            simText,
            style: TextStyle(
              fontSize: 9.5,
              fontWeight: FontWeight.w700,
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  void _showCallDetailsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.callDetails),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${AppLocalizations.of(context)!.phoneNumber}: ${log.phoneNumber}'),
            Text('${AppLocalizations.of(context)!.time}: ${DateFormat('yyyy-MM-dd HH:mm:ss').format(log.timestamp)}'),
            Text('${AppLocalizations.of(context)!.callType}: ${_getCallTypeInfo(context, log.callType).text}'),
            if (log.location.isNotEmpty) Text('${AppLocalizations.of(context)!.location}: ${log.location}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppLocalizations.of(context)!.closeButton),
          ),
        ],
      ),
    );
  }

  void _showRuleActionDialog(BuildContext context) {
    RuleActionDialog.show(context, log: log);
  }

  _CallTypeInfo _getCallTypeInfo(BuildContext context, LocalCallType type) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    switch (type) {
      case LocalCallType.blocked:
        return _CallTypeInfo(icon: Icons.block_rounded, color: theme.colorScheme.error, text: l10n.callTypeBlocked);
      case LocalCallType.incoming:
        return _CallTypeInfo(icon: Icons.call_received_rounded, color: theme.colorScheme.secondary, text: l10n.callTypeAnswered);
      case LocalCallType.outgoing:
        return _CallTypeInfo(icon: Icons.call_made_rounded, color: theme.colorScheme.tertiary, text: l10n.callTypeOutgoing);
      case LocalCallType.missed:
        return _CallTypeInfo(icon: Icons.call_missed_rounded, color: theme.colorScheme.primary, text: l10n.callTypeMissed);
      case LocalCallType.rejected:
        return _CallTypeInfo(icon: Icons.call_end_rounded, color: theme.colorScheme.onSurfaceVariant, text: l10n.callTypeRejected);
      case LocalCallType.silenced:
        return _CallTypeInfo(icon: Icons.notifications_off_rounded, color: theme.colorScheme.primary, text: l10n.callTypeSilenced);
      case LocalCallType.voicemail:
        return _CallTypeInfo(icon: Icons.voicemail, color: theme.colorScheme.tertiary, text: 'Voicemail');
      default:
        return _CallTypeInfo(icon: Icons.phone_rounded, color: theme.colorScheme.onSurfaceVariant, text: l10n.callTypeUnknown);
    }
  }
}
