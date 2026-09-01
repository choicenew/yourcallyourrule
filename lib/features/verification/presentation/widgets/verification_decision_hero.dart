import 'package:flutter/material.dart';
import 'package:yourcallyourrule/features/home_elite/theme/elite_dopamine_theme.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 总体拦截判决 Hero 卡片
class VerificationDecisionHero extends StatelessWidget {
  final Map<String, bool> verificationResults;

  const VerificationDecisionHero({
    super.key,
    required this.verificationResults,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    final isBlocked = verificationResults['Blocked'] == true ||
        verificationResults['Blacklist'] == true ||
        verificationResults['Global Reject'] == true;
    final isSilenced = verificationResults['Silenced'] == true;
    final isAllowed = verificationResults['Allowed'] == true ||
        verificationResults['Whitelist'] == true;

    final Color badgeColor;
    final IconData badgeIcon;
    final String decisionTitle;
    final String decisionSub;

    if (isBlocked) {
      badgeColor = EliteDopamineTheme.vibrantCoral;
      badgeIcon = Icons.shield_rounded;
      decisionTitle = l10n.actionBlock;
      decisionSub = l10n.blockActionDescription;
    } else if (isSilenced) {
      badgeColor = EliteDopamineTheme.warmSunAmber;
      badgeIcon = Icons.notifications_off_rounded;
      decisionTitle = l10n.actionSilence;
      decisionSub = l10n.silenceActionDescription;
    } else if (isAllowed) {
      badgeColor = EliteDopamineTheme.freshMint;
      badgeIcon = Icons.verified_rounded;
      decisionTitle = l10n.actionAllow;
      decisionSub = l10n.allowActionDescription;
    } else {
      badgeColor = EliteDopamineTheme.skyAzure;
      badgeIcon = Icons.info_outline_rounded;
      decisionTitle = l10n.actionNone;
      decisionSub = l10n.noneActionDescription;
    }

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            badgeColor.withValues(alpha: 0.16),
            badgeColor.withValues(alpha: 0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: badgeColor.withValues(alpha: 0.3),
          width: 1.5,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: badgeColor,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: badgeColor.withValues(alpha: 0.35),
                  blurRadius: 14,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(badgeIcon, color: Colors.white, size: 30),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  decisionTitle,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: badgeColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  decisionSub,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
