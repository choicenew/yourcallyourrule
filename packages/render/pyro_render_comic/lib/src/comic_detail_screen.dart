import 'package:material_ui/material_ui.dart';
import 'package:pyro_action_hub/pyro_action_hub.dart';
import 'package:pyro_action_protocol/pyro_action_protocol.dart';
import 'package:pyro_media_models/pyro_media_models.dart';
import 'package:pyro_render_hub/pyro_render_hub.dart';
import 'package:pyro_source_download_ui/pyro_source_download_ui.dart' as download_ui;

import 'l10n/generated/app_localizations.dart';
import 'comic_reader_screen.dart';
import 'widgets/comic_detail_widgets.dart';

/// 漫画二级详情页 (Comic Detail Screen - 100% MediaEntity 强类型)
class ComicDetailScreen extends StatefulWidget {
  final MediaEntity entity;

  const ComicDetailScreen({
    super.key,
    required this.entity,
  });

  @override
  State<ComicDetailScreen> createState() => _ComicDetailScreenState();
}

class _ComicDetailScreenState extends State<ComicDetailScreen> {
  late final String _title;
  late final String _artist;
  late final String _coverUrl;
  late final String _description;

  @override
  void initState() {
    super.initState();
    _title = widget.entity.title;
    _artist = AuthorFormatter.formatAuthorName(widget.entity.creators, defaultName: '');
    _coverUrl = widget.entity.coverUrl ?? widget.entity.thumbUrl ?? widget.entity.contentUrl;
    _description = widget.entity.description ?? '';
  }

  void _openReader() {
    final handled = RenderHub.instance.openReader(context, widget.entity.type, widget.entity);

    if (!handled) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => ComicReaderScreen(entity: widget.entity),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    final downloadL10n = download_ui.AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(_title)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ComicDetailHeader(
            title: _title,
            author: _artist,
            coverUrl: _coverUrl,
          ),
          if (_description.isNotEmpty) ...[
            const SizedBox(height: 16),
            Text(_description, style: TextStyle(fontSize: 14, color: theme.colorScheme.onSurface)),
          ],
          const SizedBox(height: 20),
          ComicDetailActionBar(entity: widget.entity),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    foregroundColor: theme.colorScheme.onPrimary,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  icon: const Icon(Icons.menu_book_rounded),
                  label: Text(l10n.read),
                  onPressed: _openReader,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  icon: const Icon(Icons.download_for_offline_rounded),
                  label: Text(downloadL10n.offlineDownload),
                  onPressed: () {
                    download_ui.ReaderDownloadWidget.showOptions(
                      context,
                      entity: widget.entity,
                      allChapters: [
                        ChapterEntity(
                          id: 'ch_1',
                          bookId: widget.entity.id,
                          title: widget.entity.title,
                          index: 1,
                        ),
                      ],
                      currentChapterIndex: 0,
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// 漫画二级页 Action 协同控制栏
class ComicDetailActionBar extends StatelessWidget {
  final MediaEntity entity;

  const ComicDetailActionBar({
    super.key,
    required this.entity,
  });

  void _showSubActionsMenu(BuildContext context, UserAction parentAction) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerHigh,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 36,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: colorScheme.onSurfaceVariant.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12, left: 8),
                  child: Text(
                    parentAction.localizedLabel(context),
                    style: TextStyle(
                      color: colorScheme.onSurface,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ...?parentAction.subActions?.map(
                  (sub) => ListTile(
                    leading: sub.status == ActionStatus.loading
                        ? SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: colorScheme.primary,
                            ),
                          )
                        : Icon(sub.icon, color: colorScheme.primary),
                    title: Text(
                      sub.localizedLabel(context),
                      style: TextStyle(
                        color: sub.isEnabled ? colorScheme.onSurface : colorScheme.onSurface.withValues(alpha: 0.38),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      if (sub.intent != null) {
                        ActionHub.instance.dispatchIntent(entity.type, sub.intent!, entity: entity);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final primaryColor = colorScheme.primary;

    return StreamBuilder<List<UserAction>>(
      stream: ActionHub.instance.watchActions(entity.type, entity.id, entity: entity),
      builder: (context, snapshot) {
        final actions = snapshot.data ?? [];
        if (actions.isEmpty) return const SizedBox.shrink();

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerLow,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: colorScheme.outlineVariant.withValues(alpha: 0.5),
              width: 0.8,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: actions.map((action) {
              final isComposite = action.subActions != null && action.subActions!.isNotEmpty;
              final label = action.localizedLabel(context);

              return Flexible(
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () {
                    if (!action.isEnabled || action.status == ActionStatus.loading) return;
                    if (isComposite) {
                      _showSubActionsMenu(context, action);
                    } else if (action.intent != null) {
                      ActionHub.instance.dispatchIntent(entity.type, action.intent!, entity: entity);
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 42,
                          height: 42,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: action.isActive
                                ? primaryColor.withValues(alpha: 0.2)
                                : colorScheme.surfaceContainerHighest,
                            border: Border.all(
                              color: action.isActive ? primaryColor : colorScheme.outlineVariant.withValues(alpha: 0.5),
                              width: 0.8,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: action.status == ActionStatus.loading
                              ? SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(strokeWidth: 2, color: primaryColor),
                                )
                              : Icon(
                                  action.icon,
                                  color: action.isActive ? primaryColor : colorScheme.onSurfaceVariant,
                                  size: 20,
                                ),
                        ),
                        if (label.isNotEmpty) ...[
                          const SizedBox(height: 4),
                          Text(
                            label,
                            style: TextStyle(
                              color: action.isActive ? primaryColor : colorScheme.onSurfaceVariant,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
