import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yourcallyourrule/features/common/router/app_router.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';
import '../models/setup_config.dart';
import '../providers/initial_setup_provider.dart';

/// 扩展插件推荐卡片组件：支持模式一键切换与跳转插件管理
class InitialSetupPluginCard extends ConsumerWidget {
  final PluginRecommendation pluginRec;

  const InitialSetupPluginCard({
    super.key,
    required this.pluginRec,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final isPluginConfig = ref.watch(setupIsPluginConfigProvider);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: isPluginConfig
            ? theme.colorScheme.primaryContainer.withValues(alpha: 0.3)
            : theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isPluginConfig
              ? theme.colorScheme.primary.withValues(alpha: 0.5)
              : theme.colorScheme.outlineVariant,
          width: 1.0,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: (isPluginConfig ? theme.colorScheme.primary : theme.colorScheme.secondary)
                  .withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              Icons.extension_rounded,
              color: isPluginConfig ? theme.colorScheme.primary : theme.colorScheme.secondary,
              size: 20,
            ),
          ),
          title: Text(
            isPluginConfig ? l10n.pluginManagement : pluginRec.title,
            style: TextStyle(
              fontSize: 13.5,
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurface,
            ),
          ),
          subtitle: Text(
            pluginRec.description,
            style: TextStyle(fontSize: 11.5, color: theme.colorScheme.onSurfaceVariant),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  elevation: 0,
                ),
                onPressed: () {
                  ref.read(setupIsPluginConfigProvider.notifier).setIsPluginConfig(!isPluginConfig);
                },
                child: Text(
                  isPluginConfig ? l10n.deepLinkTypeSubscription : l10n.deepLinkTypePlugin,
                  style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(width: 6),
              IconButton(
                icon: const Icon(Icons.open_in_new_rounded, size: 18),
                color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
                tooltip: l10n.pluginManagement,
                onPressed: () {
                  context.pushNamed(AppRouter.pluginManagement);
                },
              ),
            ],
          ),
          onTap: () {
            ref.read(setupIsPluginConfigProvider.notifier).setIsPluginConfig(!isPluginConfig);
          },
        ),
      ),
    );
  }
}
