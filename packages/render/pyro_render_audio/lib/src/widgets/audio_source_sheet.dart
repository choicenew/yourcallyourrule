import 'package:material_ui/material_ui.dart';
import '../l10n/generated/app_localizations.dart';
import 'package:pyro_source_match/pyro_source_match.dart';

/// 切换音源与人工纠错 Modal Bottom Sheet
class AudioSourceSheet extends StatelessWidget {
  final SiblingsSwapper swapper;
  final ValueChanged<int> onSelectCandidate;

  const AudioSourceSheet({
    super.key,
    required this.swapper,
    required this.onSelectCandidate,
  });

  static Future<void> show(
    BuildContext context, {
    required SiblingsSwapper swapper,
    required ValueChanged<int> onSelectCandidate,
  }) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => AudioSourceSheet(
        swapper: swapper,
        onSelectCandidate: onSelectCandidate,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final active = swapper.activeCandidate;
    final candidates = [active, ...swapper.siblings];
    final l10n = AppLocalizations.of(context);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 36,
                height: 4,
                decoration: BoxDecoration(
                  color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Icon(Icons.tune_rounded, color: theme.colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  l10n != null ? l10n.switchSource : '',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Flexible(
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: candidates.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final item = candidates[index];
                  final isCurrent = index == 0;
                  final title = item['title']?.toString() ?? 'Option';
                  final author = (item['artists'] as List?)?.join(', ') ?? item['author']?.toString() ?? '';

                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(
                      isCurrent ? Icons.radio_button_checked_rounded : Icons.radio_button_off_rounded,
                      color: isCurrent ? theme.colorScheme.primary : theme.colorScheme.onSurfaceVariant,
                    ),
                    title: Text(
                      title,
                      style: TextStyle(
                        fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
                        color: isCurrent ? theme.colorScheme.primary : theme.colorScheme.onSurface,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: author.isNotEmpty
                        ? Text(
                            author,
                            style: theme.textTheme.bodySmall,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          )
                        : null,
                    trailing: isCurrent
                        ? Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primaryContainer,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              'Selected',
                              style: TextStyle(
                                fontSize: 11,
                                color: theme.colorScheme.onPrimaryContainer,
                              ),
                            ),
                          )
                        : null,
                    onTap: () {
                      Navigator.pop(context);
                      if (!isCurrent) {
                        onSelectCandidate(index - 1);
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
