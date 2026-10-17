import 'package:flutter/material.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';
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
    final theme = Theme.of(context);
    final descriptionText = country.description;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isSelected ? theme.colorScheme.primary : theme.colorScheme.outlineVariant,
          width: isSelected ? 1.5 : 1.0,
        ),
      ),
      child: CheckboxListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        activeColor: theme.colorScheme.primary,
        title: Row(
          children: [
            Expanded(
              child: Text(
                country.name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: theme.colorScheme.onSurface,
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
                  color: theme.colorScheme.secondary.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  country.countryCode.toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.secondary,
                  ),
                ),
              ),
            ],
            if (isCurrentLocation) ...[
              const SizedBox(width: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: theme.colorScheme.tertiary.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  l10n.initialSetupDetectedLocation,
                  style: TextStyle(
                    fontSize: 10,
                    color: theme.colorScheme.tertiary,
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
                  style: TextStyle(fontSize: 11, color: theme.colorScheme.onSurfaceVariant),
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
