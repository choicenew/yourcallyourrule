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
import 'package:yourcallyourrule/features/home_elite/theme/elite_dopamine_theme.dart';
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
    final callTypeInfo = _getCallTypeInfo(context, log.callType);
    final timeFormat = DateFormat('HH:mm');
    final timeString = timeFormat.format(log.timestamp);
    final primaryLabelId = log.labelIds?.firstOrNull;
    final rawLabelText = primaryLabelId != null ? labelIdToTextMap[primaryLabelId] : null;
    final translatedLabelText = rawLabelText != null ? LabelTranslationUtils.translateLabelText(context, rawLabelText) : null;
    final hasLabels = translatedLabelText != null && translatedLabelText.isNotEmpty;
    final hasLocation = region != null && region!.isNotEmpty;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 5.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSelected
              ? EliteDopamineTheme.sunsetTangerine
              : const Color(0xFFEDE8DF),
          width: isSelected ? 1.8 : 1.1,
        ),
        boxShadow: [
          BoxShadow(
            color: isSelected
                ? EliteDopamineTheme.sunsetTangerine.withValues(alpha: 0.16)
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCardHeader(
                  context,
                  ref,
                  callTypeInfo,
                  avatarPath,
                  translatedLabelText,
                  hasLabels,
                  region,
                  hasLocation,
                  timeString,
                ),
                const SizedBox(height: 10),
                _buildFooterAndActions(context, callTypeInfo),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// 构建卡片头部（右侧展示时间，中间展示姓名、号码、标签、归属地与运营商）
  Widget _buildCardHeader(
    BuildContext context,
    WidgetRef ref,
    _CallTypeInfo callTypeInfo,
    String? primaryAvatar,
    String? translatedLabelText,
    bool hasLabels,
    String? locationText,
    bool hasLocation,
    String timeString,
  ) {
    final simInfo = '${log.simDisplayName} ${log.carrierName}'.trim();
    final hasSimInfo = simInfo.isNotEmpty;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 头像与来电类型微型角标
        SizedBox(
          width: 44,
          height: 44,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              CircleAvatar(
                radius: 22,
                backgroundImage: AvatarUtils.getAvatarImage(primaryAvatar, translatedLabelText),
                backgroundColor: EliteDopamineTheme.warmSunAmber.withValues(alpha: 0.12),
                child: primaryAvatar == null && (translatedLabelText == null || translatedLabelText.isEmpty)
                    ? const Icon(Icons.person, size: 24, color: EliteDopamineTheme.warmSunAmber)
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
                    border: Border.all(color: Colors.white, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: callTypeInfo.color.withValues(alpha: 0.4),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: Icon(callTypeInfo.icon, size: 10, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),

        // 中间：姓名、号码、标签、归属地、运营商
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Flexible(
                    child: Text(
                      (log.name != null && log.name!.isNotEmpty)
                          ? log.name!
                          : AppLocalizations.of(context)!.unknown,
                      style: const TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 15,
                        color: Colors.black87,
                        letterSpacing: -0.2,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (hasLabels) ...[
                    const SizedBox(width: 6),
                    _buildLabelChip(context, ref, translatedLabelText!),
                  ],
                  Padding(
                    padding: const EdgeInsets.only(left: 4.0),
                    child: InkWell(
                      onTap: () async {
                        final updated = await PhoneMetaEditDialog.show(context, log: log);
                        if (updated && context.mounted) onRequiresRefresh();
                      },
                      borderRadius: BorderRadius.circular(8),
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Icon(Icons.edit_note_rounded, size: 16, color: Colors.grey[400]),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 3),
              Text(
                log.phoneNumber,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[600],
                ),
              ),
              if (hasLocation || hasSimInfo) ...[
                const SizedBox(height: 4),
                Wrap(
                  spacing: 6,
                  runSpacing: 4,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    if (hasLocation)
                      _buildRegionChip(context, locationText!),
                    if (hasSimInfo)
                      _buildSimInfoChip(simInfo),
                  ],
                ),
              ],
            ],
          ),
        ),

        const SizedBox(width: 8),

        // 右侧：时间
        Text(
          timeString,
          style: TextStyle(
            fontSize: 12.5,
            fontWeight: FontWeight.w800,
            color: Colors.grey[800],
          ),
        ),
      ],
    );
  }

  /// 构建底部信息与操作按钮组合栏
  Widget _buildFooterAndActions(
    BuildContext context,
    _CallTypeInfo callTypeInfo,
  ) {
    return Row(
      children: [
        // 状态胶囊标签
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: callTypeInfo.color.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(callTypeInfo.icon, size: 12, color: callTypeInfo.color),
              const SizedBox(width: 4),
              Text(
                callTypeInfo.text,
                style: TextStyle(
                  fontSize: 10.5,
                  color: callTypeInfo.color,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),

        const Spacer(),

        // 快速操作图标按钮组（独立温润容器，宽松间距）
        _buildActionButton(
          icon: Icons.info_outline_rounded,
          color: EliteDopamineTheme.skyAzure,
          tooltip: AppLocalizations.of(context)!.viewDetails,
          onTap: () => _showCallDetailsDialog(context),
        ),
        const SizedBox(width: 6),
        _buildActionButton(
          icon: Icons.label_outline_rounded,
          color: EliteDopamineTheme.softLilac,
          tooltip: AppLocalizations.of(context)!.addLabel,
          onTap: () async {
            final updated = await PhoneMetaEditDialog.show(context, log: log);
            if (updated && context.mounted) onRequiresRefresh();
          },
        ),
        const SizedBox(width: 6),
        _buildActionButton(
          icon: log.callType == LocalCallType.blocked ? Icons.lock_open_rounded : Icons.phone_outlined,
          color: log.callType == LocalCallType.blocked ? EliteDopamineTheme.freshMint : EliteDopamineTheme.sunsetTangerine,
          tooltip: log.callType == LocalCallType.blocked
              ? AppLocalizations.of(context)!.unblock
              : AppLocalizations.of(context)!.call,
          onTap: actionHandler.handleCallAction,
        ),
        const SizedBox(width: 6),
        _buildActionButton(
          icon: Icons.rule_folder_outlined,
          color: EliteDopamineTheme.warmSunAmber,
          tooltip: AppLocalizations.of(context)!.addRule,
          onTap: () => _showRuleActionDialog(context),
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String tooltip,
    required VoidCallback onTap,
    Color? color,
  }) {
    final activeColor = color ?? Colors.grey[700]!;

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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
      decoration: BoxDecoration(
        color: EliteDopamineTheme.vibrantCoral.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: EliteDopamineTheme.vibrantCoral.withValues(alpha: 0.25),
        ),
      ),
      child: Text(
        labelText,
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: EliteDopamineTheme.vibrantCoral,
        ),
      ),
    );
  }

  Widget _buildRegionChip(BuildContext context, String regionText) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1.5),
      decoration: BoxDecoration(
        color: const Color(0xFFF0EDE6),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        regionText,
        style: TextStyle(
          fontSize: 9.5,
          fontWeight: FontWeight.w500,
          color: Colors.grey[700],
        ),
      ),
    );
  }

  Widget _buildSimInfoChip(String simInfo) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F5F0),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: const Color(0xFFEDE8DF),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.sim_card_outlined,
            size: 10,
            color: EliteDopamineTheme.sunsetTangerine,
          ),
          const SizedBox(width: 2),
          Text(
            simInfo,
            style: TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.w800,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }

  void _showRuleActionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => RuleActionDialog(log: log),
    );
  }

  void _showCallDetailsDialog(BuildContext context) {
    final dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
    final formattedTime = dateFormat.format(log.timestamp);
    final primaryLabelId = log.labelIds?.firstOrNull;
    final rawLabelText = primaryLabelId != null ? labelIdToTextMap[primaryLabelId] : null;
    final translatedLabelText = rawLabelText != null ? LabelTranslationUtils.translateLabelText(context, rawLabelText) : '-';
    final callTypeInfo = _getCallTypeInfo(context, log.callType);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Icon(Icons.info_outline_rounded, color: EliteDopamineTheme.sunsetTangerine, size: 22),
            const SizedBox(width: 8),
            Text(
              AppLocalizations.of(context)!.callDetails,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow(AppLocalizations.of(context)!.phoneNumber, log.phoneNumber),
            if (log.name != null) _buildDetailRow(AppLocalizations.of(context)!.name, log.name!),
            _buildDetailRow(AppLocalizations.of(context)!.callType, callTypeInfo.text),
            _buildDetailRow(AppLocalizations.of(context)!.callTime, formattedTime),
            _buildDetailRow(AppLocalizations.of(context)!.label, translatedLabelText),
            if (region != null && region!.isNotEmpty)
              _buildDetailRow(AppLocalizations.of(context)!.region, region!),
            if (log.carrierName.isNotEmpty)
              _buildDetailRow(AppLocalizations.of(context)!.carrier, log.carrierName),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              AppLocalizations.of(context)!.confirm,
              style: const TextStyle(fontWeight: FontWeight.bold, color: EliteDopamineTheme.sunsetTangerine),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              '$label:',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 12.5,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _CallTypeInfo _getCallTypeInfo(BuildContext context, LocalCallType type) {
    final l10n = AppLocalizations.of(context)!;
    switch (type) {
      case LocalCallType.blocked:
        return _CallTypeInfo(icon: Icons.block_rounded, color: EliteDopamineTheme.vibrantCoral, text: l10n.callTypeBlocked);
      case LocalCallType.incoming:
        return _CallTypeInfo(icon: Icons.call_received_rounded, color: EliteDopamineTheme.freshMint, text: l10n.callTypeAnswered);
      case LocalCallType.outgoing:
        return _CallTypeInfo(icon: Icons.call_made_rounded, color: EliteDopamineTheme.skyAzure, text: l10n.callTypeOutgoing);
      case LocalCallType.missed:
        return _CallTypeInfo(icon: Icons.call_missed_rounded, color: EliteDopamineTheme.sunsetTangerine, text: l10n.callTypeMissed);
      case LocalCallType.rejected:
        return _CallTypeInfo(icon: Icons.call_end_rounded, color: Colors.grey, text: l10n.callTypeRejected);
      case LocalCallType.silenced:
        return _CallTypeInfo(icon: Icons.notifications_off_rounded, color: EliteDopamineTheme.warmSunAmber, text: l10n.callTypeSilenced);
      case LocalCallType.voicemail:
        return _CallTypeInfo(icon: Icons.voicemail, color: Colors.purple, text: 'Voicemail');
      default:
        return _CallTypeInfo(icon: Icons.phone_rounded, color: Colors.grey, text: l10n.callTypeUnknown);
    }
  }
}