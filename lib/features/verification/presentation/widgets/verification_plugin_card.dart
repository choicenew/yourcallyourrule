import 'package:flutter/material.dart';
import 'package:yourcallyourrule/core/entities/plugin/plugin_source_data.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 插件扩展数据卡片（全量国际化，消除硬编码文本）
class VerificationPluginCard extends StatelessWidget {
  final PluginSourceData? pluginSourceData;
  final Map<String, dynamic> legacyPluginData;

  const VerificationPluginCard({
    super.key,
    this.pluginSourceData,
    required this.legacyPluginData,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: theme.colorScheme.outlineVariant,
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
          if (pluginSourceData != null) ...[
            Row(
              children: [
                Icon(
                  Icons.extension_rounded,
                  size: 18,
                  color: theme.colorScheme.secondary,
                ),
                const SizedBox(width: 8),
                Text(
                  l10n.pluginLabel,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            _buildInfoText(context, l10n.contactNameLabel, pluginSourceData?.name ?? l10n.unknown),
            _buildInfoText(context, l10n.pluginLabel, pluginSourceData?.sourceLabel ?? l10n.unknown),
            _buildInfoText(
              context,
              l10n.tagLabel(pluginSourceData?.predefinedLabel ?? pluginSourceData?.sourceLabel ?? l10n.unknown),
              pluginSourceData?.predefinedLabel ??
                  pluginSourceData?.sourceLabel ??
                  l10n.unknown,
            ),
            _buildInfoText(
              context,
              l10n.enableLocationSummary,
              [pluginSourceData?.province, pluginSourceData?.city]
                  .where((e) => e != null && e.isNotEmpty)
                  .join(', '),
            ),
            _buildInfoText(context, l10n.carrier, pluginSourceData?.carrier ?? l10n.unknown),
            _buildInfoText(context, l10n.callerIdMarkedByCount(pluginSourceData?.count ?? 0), '${pluginSourceData?.count ?? 0}'),
            _buildInfoText(context, l10n.action, pluginSourceData?.action.toString() ?? l10n.actionNone),
          ],
          if (legacyPluginData.isNotEmpty) ...[
            if (pluginSourceData != null) const Divider(height: 24),
            Row(
              children: [
                Icon(
                  Icons.history_rounded,
                  size: 18,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  '${l10n.pluginLabel} (Legacy)',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ...legacyPluginData.entries.map((e) => _buildInfoText(context, e.key, '${e.value}')),
          ],
        ],
      ),
    );
  }

  Widget _buildInfoText(BuildContext context, String label, String value) {
    if (value.isEmpty) return const SizedBox.shrink();
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w800,
                color: theme.colorScheme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
