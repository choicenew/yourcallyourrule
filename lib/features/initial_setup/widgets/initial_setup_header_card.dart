import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';
import '../providers/initial_setup_provider.dart';

/// 顶部控制卡片组件：包含说明文案、数据源（GitHub/CDN）切换与自定义 URL 输入框
class InitialSetupHeaderCard extends ConsumerWidget {
  final bool useCdn;
  final bool useCustomUrl;
  final TextEditingController customUrlController;
  final ValueChanged<bool> onUseCdnChanged;
  final ValueChanged<bool> onUseCustomUrlChanged;
  final VoidCallback onFetchCustomUrl;

  const InitialSetupHeaderCard({
    super.key,
    required this.useCdn,
    required this.useCustomUrl,
    required this.customUrlController,
    required this.onUseCdnChanged,
    required this.onUseCustomUrlChanged,
    required this.onFetchCustomUrl,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: theme.colorScheme.outlineVariant,
          width: 1.0,
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.initialSetupDesc,
            style: TextStyle(
              fontSize: 13.5,
              color: theme.colorScheme.onSurface,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 14),
          // 数据源选择 & 切换器
          Row(
            children: [
              Text(
                l10n.initialSetupSourceTitle,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              const Spacer(),
              // 自定义药丸式分段选择器
              Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: theme.colorScheme.outlineVariant),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildSegmentTab(
                      context: context,
                      ref: ref,
                      label: l10n.initialSetupSourceGithub,
                      isSelected: !useCdn,
                      value: false,
                    ),
                    _buildSegmentTab(
                      context: context,
                      ref: ref,
                      label: l10n.initialSetupSourceCdn,
                      isSelected: useCdn,
                      value: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          // 自定义 URL 复选框
          Row(
            children: [
              SizedBox(
                width: 24,
                height: 24,
                child: Checkbox(
                  value: useCustomUrl,
                  activeColor: theme.colorScheme.primary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                  onChanged: (bool? val) {
                    onUseCustomUrlChanged(val ?? false);
                  },
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () => onUseCustomUrlChanged(!useCustomUrl),
                child: Text(
                  l10n.initialSetupSourceCustom,
                  style: TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ),
            ],
          ),
          if (useCustomUrl)
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: customUrlController,
                      decoration: InputDecoration(
                        hintText: l10n.initialSetupCustomUrlHint,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: theme.colorScheme.outlineVariant),
                        ),
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      ),
                      onSubmitted: (_) => onFetchCustomUrl(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.primary,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    ),
                    onPressed: onFetchCustomUrl,
                    icon: const Icon(Icons.download_rounded, size: 16),
                    label: Text(
                      l10n.initialSetupCustomUrlLoad,
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSegmentTab({
    required BuildContext context,
    required WidgetRef ref,
    required String label,
    required bool isSelected,
    required bool value,
  }) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        onUseCdnChanged(value);
        ref.read(setupUseCdnProvider.notifier).setUseCdn(value);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected
              ? theme.colorScheme.primary.withValues(alpha: 0.15)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(9),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: isSelected
                ? theme.colorScheme.primary
                : theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}
