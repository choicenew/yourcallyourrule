import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';
import 'package:yourcallyourrule/features/home_elite/theme/elite_dopamine_theme.dart';
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

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: EliteDopamineTheme.warmCardDecoration(
        context: context,
        glowColor: EliteDopamineTheme.warmSunAmber,
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.initialSetupDesc,
            style: const TextStyle(
              fontSize: 13,
              color: EliteDopamineTheme.textBody,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 12),
          // 数据源选择 & 切换器
          Row(
            children: [
              Text(
                l10n.initialSetupSourceTitle,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: EliteDopamineTheme.textPrimary,
                ),
              ),
              const Spacer(),
              SegmentedButton<bool>(
                showSelectedIcon: false,
                segments: [
                  ButtonSegment<bool>(
                    value: false,
                    label: Text(l10n.initialSetupSourceGithub, style: const TextStyle(fontSize: 12)),
                  ),
                  ButtonSegment<bool>(
                    value: true,
                    label: Text(l10n.initialSetupSourceCdn, style: const TextStyle(fontSize: 12)),
                  ),
                ],
                selected: {useCdn},
                onSelectionChanged: (Set<bool> newSelection) {
                  final val = newSelection.first;
                  onUseCdnChanged(val);
                  ref.read(setupUseCdnProvider.notifier).setUseCdn(val);
                },
              ),
            ],
          ),
          const SizedBox(height: 8),
          // 自定义 URL 输入与专属【加载配置】按钮
          Row(
            children: [
              Checkbox(
                value: useCustomUrl,
                activeColor: EliteDopamineTheme.sunsetTangerine,
                onChanged: (bool? val) {
                  onUseCustomUrlChanged(val ?? false);
                },
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => onUseCustomUrlChanged(!useCustomUrl),
                  child: Text(
                    l10n.initialSetupSourceCustom,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: EliteDopamineTheme.textPrimary,
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (useCustomUrl)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: customUrlController,
                      decoration: InputDecoration(
                        hintText: l10n.initialSetupCustomUrlHint,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: EliteDopamineTheme.slateBorder),
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
                      backgroundColor: EliteDopamineTheme.sunsetTangerine,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    ),
                    onPressed: onFetchCustomUrl,
                    icon: const Icon(Icons.download_rounded, size: 16),
                    label: Text(l10n.initialSetupCustomUrlLoad, style: const TextStyle(fontSize: 12)),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
