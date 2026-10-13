import 'package:flutter/material.dart';
import 'package:yourcallyourrule/features/home_elite/theme/elite_dopamine_theme.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 过滤器头部组件 (包含标题与 Separate SIMs 联动开关)
class PrimaryFilterHeaderTile extends StatelessWidget {
  final AppLocalizations l10n;
  final bool separateSims;
  final ValueChanged<bool> onSeparateSimsChanged;
  final VoidCallback onNavigateSettings;

  const PrimaryFilterHeaderTile({
    super.key,
    required this.l10n,
    required this.separateSims,
    required this.onSeparateSimsChanged,
    required this.onNavigateSettings,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    gradient: EliteDopamineTheme.coralSunsetGradient,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.tune_rounded,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.callFilterRules,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: EliteDopamineTheme.textPrimary,
                      ),
                    ),
                    Text(
                      l10n.callFilterRulesDescription,
                      style: const TextStyle(
                        fontSize: 10,
                        color: EliteDopamineTheme.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            InkWell(
              onTap: onNavigateSettings,
              borderRadius: BorderRadius.circular(8),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                child: Row(
                  children: [
                    const Icon(
                      Icons.settings_suggest_rounded,
                      size: 14,
                      color: EliteDopamineTheme.sunsetTangerine,
                    ),
                    const SizedBox(width: 3),
                    Text(
                      l10n.filterSettingsTitle,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: EliteDopamineTheme.sunsetTangerine,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Icon(Icons.signal_cellular_alt_rounded, size: 14, color: EliteDopamineTheme.amberIcon),
            const SizedBox(width: 4),
            Text(
              l10n.separateSims,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: EliteDopamineTheme.textPrimary,
              ),
            ),
            const SizedBox(width: 6),
            Transform.scale(
              scale: 0.85,
              child: Switch.adaptive(
                value: separateSims,
                activeColor: EliteDopamineTheme.amberIcon,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                onChanged: onSeparateSimsChanged,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
