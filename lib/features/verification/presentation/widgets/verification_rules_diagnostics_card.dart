import 'package:flutter/material.dart';
import 'package:yourcallyourrule/features/home_elite/theme/elite_dopamine_theme.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 11 项规则拦截诊断卡片（全量国际化，消除硬编码文本）
class VerificationRulesDiagnosticsCard extends StatelessWidget {
  final Map<String, bool> verificationResults;

  const VerificationRulesDiagnosticsCard({
    super.key,
    required this.verificationResults,
  });

  String _getLocalizedRuleName(BuildContext context, String ruleKey) {
    final l10n = AppLocalizations.of(context);
    switch (ruleKey) {
      case 'Allowed':
        return l10n.actionAllow;
      case 'Blocked':
        return l10n.actionBlock;
      case 'Silenced':
        return l10n.actionSilence;
      case 'None Action':
        return l10n.actionNone;
      case 'Global Reject':
        return '${l10n.actionAll} - ${l10n.actionBlock}';
      case 'Blacklist':
        return l10n.blacklist;
      case 'Whitelist':
        return l10n.whitelist;
      case 'Regex':
        return l10n.regexRule;
      case 'Time Rules':
        return l10n.timeInterceptor;
      case 'Local Count Filter':
        return l10n.enableLocalCountFilter;
      case 'Remote Number Filter':
        return l10n.enableRemoteNumberFilter;
      default:
        return ruleKey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: const Color(0xFFEDE8DF),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.rule_folder_rounded,
                size: 18,
                color: EliteDopamineTheme.sunsetTangerine,
              ),
              const SizedBox(width: 8),
              Text(
                l10n.verificationReport,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w900,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(height: 1),
          const SizedBox(height: 10),

          // 诊断项列表（保留全部 11 项并提供国际化的 Blocked / Allowed 状态）
          ...verificationResults.entries.map((entry) {
            final isHit = entry.value;
            final isBlockedAction = isHit &&
                (entry.key.contains('Block') ||
                    entry.key.contains('Reject') ||
                    entry.key.contains('Filter'));

            final Color statusColor = isHit
                ? (isBlockedAction ? Colors.red : Colors.green)
                : Colors.grey;

            final localizedName = _getLocalizedRuleName(context, entry.key);
            final statusText = isHit
                ? (isBlockedAction ? l10n.blocked : l10n.allow)
                : l10n.actionNone;

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                children: [
                  Icon(
                    isHit
                        ? (isBlockedAction ? Icons.block : Icons.check_circle)
                        : Icons.radio_button_unchecked,
                    size: 16,
                    color: statusColor,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      localizedName,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: statusColor.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      statusText,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        color: statusColor,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
