import 'package:material_ui/material_ui.dart';
import 'package:pyro_action_hub/pyro_action_hub.dart';
import 'package:pyro_action_protocol/pyro_action_protocol.dart';
import 'package:pyro_render_hub/pyro_render_hub.dart';

import 'l10n/generated/app_localizations.dart';

import 'news_reader_screen.dart';
import 'widgets/news_detail_widgets.dart';

/// 资讯/新闻二级详情页 (News Detail Screen - 100% MediaEntity 强类型)
class NewsDetailScreen extends StatefulWidget {
  final MediaEntity entity;

  const NewsDetailScreen({
    super.key,
    required this.entity,
  });

  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  late final String _title;
  late final String _author;
  late final String _coverUrl;
  late final String _publishTime;
  late final String _description;

  @override
  void initState() {
    super.initState();
    _title = widget.entity.title;
    _author = AuthorFormatter.formatAuthorName(widget.entity.creators, defaultName: '');
    _coverUrl = widget.entity.coverUrl ?? widget.entity.thumbUrl ?? widget.entity.contentUrl;
    _publishTime = widget.entity.publishDate ?? '';
    _description = widget.entity.description ?? '';
  }

  void _openReader() {
    final handled = RenderHub.instance.openReader(context, widget.entity.type, widget.entity);

    if (!handled) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => NewsReaderScreen(entity: widget.entity),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(_title)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          NewsDetailHeader(
            title: _title,
            author: _author,
            date: _publishTime,
            coverUrl: _coverUrl,
          ),
          if (_description.isNotEmpty) ...[
            const SizedBox(height: 16),
            Text(
              _description,
              style: TextStyle(fontSize: 14, height: 1.6, color: theme.colorScheme.onSurface),
            ),
          ],
          const SizedBox(height: 20),
          NewsDetailActionBar(entity: widget.entity),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colorScheme.primary,
              foregroundColor: theme.colorScheme.onPrimary,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            ),
            icon: const Icon(Icons.article_rounded),
            label: Text(l10n.read),
            onPressed: _openReader,
          ),
        ],
      ),
    );
  }
}

/// 新闻/资讯二级页 Action 协同控制栏
class NewsDetailActionBar extends StatelessWidget {
  final MediaEntity entity;

  const NewsDetailActionBar({
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
