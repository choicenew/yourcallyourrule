import 'package:flutter/material.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';
import 'package:yourcallyourrule/features/home_elite/theme/elite_dopamine_theme.dart';
import '../models/setup_config.dart';

/// 规则集/国家多巴胺长卡片组件：支持选定高亮、分类 Badge 及系统自动定位 Badge 展示
class InitialSetupTile extends StatelessWidget {
  final CountryData country;
  final bool isSelected;
  final bool isCurrentLocation;
  final ValueChanged<bool?> onChanged;

  const InitialSetupTile({
    super.key,
    required this.country,
    required this.isSelected,
    required this.isCurrentLocation,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    final descriptionText = country.description.isNotEmpty
        ? country.description
        : (country.ruleType.isNotEmpty ? '${l10n.ruleType}: ${country.ruleType}' : '');

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: EliteDopamineTheme.warmCardDecoration(
        context: context,
        glowColor: isSelected ? EliteDopamineTheme.sunsetTangerine : Colors.transparent,
      ),
      child: CheckboxListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        activeColor: EliteDopamineTheme.sunsetTangerine,
        title: Row(
          children: [
            Expanded(
              child: Text(
                country.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: EliteDopamineTheme.textPrimary,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (country.countryCode.isNotEmpty) ...[
              const SizedBox(width: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: EliteDopamineTheme.softLilac.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  country.countryCode.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: EliteDopamineTheme.softLilac,
                  ),
                ),
              ),
            ],
            if (isCurrentLocation) ...[
              const SizedBox(width: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: EliteDopamineTheme.freshMint.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  l10n.initialSetupDetectedLocation,
                  style: const TextStyle(
                    fontSize: 10,
                    color: EliteDopamineTheme.freshMint,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ],
        ),
        subtitle: descriptionText.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  descriptionText,
                  style: const TextStyle(fontSize: 11, color: EliteDopamineTheme.textSecondary),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            : null,
        value: isSelected,
        onChanged: onChanged,
      ),
    );
  }
}
