// lib/features/call/call_history/widgets/call_log_card.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:yourcallyourrule/common/utils/avatar_utils.dart';
import 'package:yourcallyourrule/core/entities/call/call_log.dart';
import 'package:yourcallyourrule/features/call/call_history/utils/call_history_action_handler.dart';
import 'package:yourcallyourrule/features/call/call_history/widgets/call_log_dialogs.dart';
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
  final String? avatarPath;
  final String? region;
  final bool isSelected;
  final VoidCallback? onMultiSelectTap;
  final CallHistoryActionHandler actionHandler;
  final VoidCallback onRequiresRefresh;

  const CallLogCard({
    super.key,
    required this.log,
    required this.labelIdToTextMap,
    this.avatarPath,
    this.region,
    required this.actionHandler,
    required this.onRequiresRefresh,
    this.isSelected = false,
    this.onMultiSelectTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dialogs = CallLogDialogs(
        context: context,
        ref: ref,
        log: log,
        labelIdToTextMap: labelIdToTextMap,
        region: region);
        
    final callTypeInfo = _getCallTypeInfo(context, log.callType);
    final timeFormat = DateFormat('HH:mm');
    final timeString = timeFormat.format(log.timestamp);
    final primaryLabelId = log.labelIds?.firstOrNull;
    final rawLabelText = primaryLabelId != null ? labelIdToTextMap[primaryLabelId] : null;
    final translatedLabelText = rawLabelText != null ? LabelTranslationUtils.translateLabelText(context, rawLabelText) : null;
    final hasLabels = translatedLabelText != null && translatedLabelText.isNotEmpty;
    final hasLocation = region != null && region!.isNotEmpty;

    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        side: isSelected ? BorderSide(color: Theme.of(context).primaryColor, width: 2) : BorderSide.none,
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onMultiSelectTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCardHeader(context, dialogs, callTypeInfo, avatarPath, translatedLabelText, hasLabels, region, hasLocation),
              _buildCardActions(context, dialogs),
              _buildFooterInfo(context, timeString, callTypeInfo),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCardHeader(BuildContext context, CallLogDialogs dialogs, _CallTypeInfo callTypeInfo, String? primaryAvatar, String? translatedLabelText, bool hasLabels, String? locationText, bool hasLocation) {
     return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 48,
          height: 48,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              CircleAvatar(
                radius: 24,
                backgroundImage: AvatarUtils.getAvatarImage(primaryAvatar, translatedLabelText),
                backgroundColor: Colors.grey[200],
                child: primaryAvatar == null && (translatedLabelText == null || translatedLabelText.isEmpty)
                    ? Icon(Icons.person, size: 28, color: Colors.grey[400])
                    : null,
              ),
              Positioned(
                right: -2, bottom: -2,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: callTypeInfo.color, shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: Icon(callTypeInfo.icon, size: 12, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: Text(
                            log.name ?? log.phoneNumber,
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: InkWell(
                            onTap: () async {
                              final updated = await dialogs.showNameEditDialog();
                              if (updated && context.mounted) onRequiresRefresh();
                            },
                            borderRadius: BorderRadius.circular(16),
                            child: Icon(Icons.edit, size: 16, color: Colors.grey[600]),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      if (hasLabels)
                        InkWell(
                          onTap: () async {
                            final updated = await dialogs.showLabelSelectionDialog();
                            if (updated && context.mounted) onRequiresRefresh();
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF5A623).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              translatedLabelText ?? '',
                              style: const TextStyle(fontSize: 12, color: Color(0xFFF5A623)),
                            ),
                          ),
                        ),
                      if (hasLocation)
                        Padding(
                          padding: EdgeInsets.only(top: hasLabels ? 4.0 : 0),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              locationText!,
                              style: const TextStyle(fontSize: 12, color: Colors.blue),
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
              if (log.name != null)
                Padding(
                  padding: const EdgeInsets.only(top: 2.0),
                  child: Text(
                    log.phoneNumber,
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCardActions(BuildContext context, CallLogDialogs dialogs) {
    return SizedBox(
      height: 40,
      child: Padding(
        padding: const EdgeInsets.only(left: 56.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.info_outline, size: 20),
              color: Colors.grey,
              onPressed: dialogs.showCallDetailsDialog,
              tooltip: AppLocalizations.of(context)!.viewDetails,
            ),
            IconButton(
              icon: const Icon(Icons.label, size: 20),
              color: Colors.grey,
              onPressed: () async {
                 final updated = await dialogs.showLabelSelectionDialog();
                 if (updated && context.mounted) onRequiresRefresh();
              },
              tooltip: AppLocalizations.of(context)!.addLabel,
            ),
            IconButton(
              icon: Icon(log.callType == 'blocked' ? Icons.block : Icons.phone, size: 20),
              color: Colors.grey,
              onPressed: actionHandler.handleCallAction,
              tooltip: log.callType == 'blocked' ? AppLocalizations.of(context)!.unblock : AppLocalizations.of(context)!.call,
            ),
            IconButton(
              icon: const Icon(Icons.rule, size: 20),
              color: Colors.grey,
              onPressed: dialogs.showRuleActionDialog,
              tooltip: AppLocalizations.of(context)!.addRule,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooterInfo(BuildContext context, String timeString, _CallTypeInfo callTypeInfo) {
    final simInfo = '${log.simDisplayName} ${log.carrierName ?? ''}'.trim();
    final hasSimInfo = simInfo.isNotEmpty;

    Widget buildSeparator() => const Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.0),
      child: Text('•', style: TextStyle(fontSize: 12, color: Colors.grey)),
    );

    return Padding(
      padding: const EdgeInsets.only(left: 64.0),
      child: Row(
        children: [
          Text(callTypeInfo.text, style: TextStyle(fontSize: 13, color: callTypeInfo.color, fontWeight: FontWeight.bold)),
          buildSeparator(),
          Text(timeString, style: TextStyle(fontSize: 13, color: Colors.grey[600])),
          if (hasSimInfo) ...[
            buildSeparator(),
            Flexible(
              child: Text(simInfo, style: TextStyle(fontSize: 13, color: Colors.grey[600]), overflow: TextOverflow.ellipsis),
            ),
          ],
        ],
      ),
    );
  }

  _CallTypeInfo _getCallTypeInfo(BuildContext context, String callType) {
    final localizations = AppLocalizations.of(context)!;
    switch (callType) {
      case 'incoming': return _CallTypeInfo(icon: Icons.phone, color: Colors.green, text: localizations.callTypeAnswered);
      case 'outgoing': return _CallTypeInfo(icon: Icons.call_made, color: Colors.blue, text: localizations.callTypeOutgoing);
      case 'missed': return _CallTypeInfo(icon: Icons.phone_missed, color: Colors.orange, text: localizations.callTypeMissed);
      case 'blocked': return _CallTypeInfo(icon: Icons.block, color: Colors.red, text: localizations.callTypeBlocked);
      default: return _CallTypeInfo(icon: Icons.phone, color: Colors.grey, text: localizations.callTypeUnknown);
    }
  }
}