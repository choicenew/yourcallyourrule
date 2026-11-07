import 'package:material_ui/material_ui.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:pyro_action_hub/pyro_action_hub.dart';
import 'package:pyro_action_protocol/pyro_action_protocol.dart';
import 'package:pyro_media_models/pyro_media_models.dart';
import 'package:pyro_render_protocol/pyro_render_protocol.dart';
import 'package:share_plus/share_plus.dart';

import 'l10n/generated/app_localizations.dart';
import 'news_intents.dart';

/// 资讯/文章深度全屏阅读器屏幕 (100% 强类型)
class NewsReaderScreen extends StatefulWidget {
  final MediaEntity entity;

  const NewsReaderScreen({
    super.key,
    required this.entity,
  });

  @override
  State<NewsReaderScreen> createState() => _NewsReaderScreenState();
}

class _NewsReaderScreenState extends State<NewsReaderScreen> {
  late String _id;
  late String _title;
  late String _source;
  late String _publishTime;
  late String _coverUrl;
  late String _category;
  late String _url;
  late List<String> _paragraphs;
  double _fontSizeDelta = 0.0;
  SelectedContent? _selectedContent;

  @override
  void initState() {
    super.initState();
    _id = widget.entity.id;
    _title = widget.entity.title;
    final rawAuthor = widget.entity.creators;
    final authorName = AuthorFormatter.formatAuthorName(rawAuthor, defaultName: '');
    _source = widget.entity.publisher ?? (authorName.isNotEmpty ? authorName : widget.entity.sourceId);
    _publishTime = widget.entity.publishDate ?? '';
    _coverUrl = widget.entity.coverUrl ?? widget.entity.thumbUrl ?? '';
    _category = widget.entity.category ?? '';
    _url = widget.entity.contentUrl;

    final desc = widget.entity.description ?? '';
    _paragraphs = desc.split('\n\n').where((p) => p.trim().isNotEmpty).toList();
    if (_paragraphs.isEmpty && desc.isNotEmpty) {
      _paragraphs = [desc];
    }
  }

  void _shareArticle() {
    Share.share('$_title\n$_source\n$_url');
  }

  void _copyArticleLink() {
    Clipboard.setData(ClipboardData(text: _url));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(ActionLocalizerScope.translate(context, id: ActionId.read.name, defaultText: '')),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _source.isNotEmpty ? _source : _title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        actions: [
          if (_url.isNotEmpty && l10n != null)
            IconButton(
              icon: const Icon(Icons.language_rounded),
              tooltip: l10n.read,
              onPressed: () {
                context.navigate(RouteToken.webBrowser, widget.entity);
              },
            ),
          if (l10n != null)
            IconButton(
              icon: const Icon(Icons.link_rounded),
              tooltip: l10n.copiedLink,
              onPressed: _copyArticleLink,
            ),
          if (l10n != null)
            IconButton(
              icon: const Icon(Icons.share_outlined),
              tooltip: l10n.share,
              onPressed: _shareArticle,
            ),
        ],
      ),
      body: SelectionArea(
        onSelectionChanged: (content) => _selectedContent = content,
        contextMenuBuilder: (context, state) => buildActionContextMenu(
          context,
          state,
          selectedText: _selectedContent?.plainText.trim() ?? '',
          contentType: widget.entity.type,
          contentId: _id,
        ),
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          children: [
            if (_category.isNotEmpty) ...[
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    _category.toUpperCase(),
                    style: TextStyle(
                      color: theme.colorScheme.onPrimaryContainer,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.8,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
            ],

            Text(
              _title,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                height: 1.3,
              ),
            ),
            const SizedBox(height: 12),

            if (_source.isNotEmpty) ...[
              Row(
                children: [
                  CircleAvatar(
                    radius: 12,
                    backgroundColor: theme.colorScheme.primary.withValues(
                      alpha: 0.15,
                    ),
                    child: Text(
                      _source[0].toUpperCase(),
                      style: TextStyle(
                        color: theme.colorScheme.primary,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    _source,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (_publishTime.isNotEmpty) ...[
                    const SizedBox(width: 12),
                    Text(
                      '•  $_publishTime',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.outline,
                      ),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 16),
            ],

            if (_coverUrl.isNotEmpty) ...[
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Image.network(
                    _coverUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const SizedBox.shrink(),
                  ),
                ),
              ),
              const SizedBox(height: 18),
            ],

            const Divider(height: 24),

            ..._paragraphs.map((para) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Text(
                  para,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontSize:
                        (theme.textTheme.bodyLarge?.fontSize ?? 16) +
                        _fontSizeDelta,
                    height: 1.75,
                    letterSpacing: 0.2,
                  ),
                ),
              );
            }),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 8,
          bottom: MediaQuery.of(context).padding.bottom + 8,
        ),
        decoration: BoxDecoration(
          color: theme.scaffoldBackgroundColor,
          border: Border(
            top: BorderSide(color: theme.dividerColor.withValues(alpha: 0.3)),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.text_decrease),
                  onPressed: () {
                    setState(() {
                      if (_fontSizeDelta > -4) _fontSizeDelta -= 1.0;
                    });
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.text_increase),
                  onPressed: () {
                    setState(() {
                      if (_fontSizeDelta < 8) _fontSizeDelta += 1.0;
                    });
                  },
                ),
              ],
            ),
            if (l10n != null)
              Row(
                children: [
                  OutlinedButton.icon(
                    icon: const Icon(Icons.document_scanner_outlined, size: 16),
                    label: Text(l10n.ocr),
                    onPressed: () {
                      context.dispatchIntent(
                        MediaType.news,
                        NewsOCRIntent(_id),
                      );
                    },
                  ),
                  const SizedBox(width: 8),
                  FilledButton.tonalIcon(
                    icon: const Icon(Icons.translate, size: 16),
                    label: Text(l10n.translate),
                    onPressed: () {
                      context.dispatchIntent(
                        MediaType.news,
                        NewsTranslateAIIntent(_id),
                      );
                    },
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
