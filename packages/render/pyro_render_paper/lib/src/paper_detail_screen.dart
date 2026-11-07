import 'dart:async';

import 'package:material_ui/material_ui.dart';
import 'package:flutter/rendering.dart';
import 'package:pyro_action_hub/pyro_action_hub.dart';
import 'package:pyro_action_protocol/pyro_action_protocol.dart';
import 'package:pyro_media_models/pyro_media_models.dart';
import 'package:pyro_render_protocol/pyro_render_protocol.dart';
import 'package:pyro_viewer_hub/pyro_viewer_hub.dart';
import 'package:share_plus/share_plus.dart';

import 'paper_intents.dart';
import 'paper_reader_screen.dart';
import 'paper_translation_parser.dart';
import 'package:pyro_render_protocol/pyro_render_protocol.dart';
import 'widgets/paper_detail_widgets.dart';

/// 学术文献二级详情页 (Paper Detail Screen - 100% 强类型)
class PaperDetailScreen extends StatefulWidget {
  final MediaEntity entity;

  const PaperDetailScreen({
    super.key,
    required this.entity,
  });

  @override
  State<PaperDetailScreen> createState() => _PaperDetailScreenState();
}

class _PaperDetailScreenState extends State<PaperDetailScreen> {
  late String _id;
  late String _rawTitle;
  late String _rawAbstractText;
  late List<String> _rawKeywords;

  late String _title;
  late String _authorName;
  late String _authorAvatar;
  late Map<String, dynamic> _authorParams;
  late String _abstractText;
  late String _venue;
  late String _doi;
  late String _url;
  late String _coverUrl;
  late String _year;
  late List<String> _keywords;
  SelectedContent? _selectedContent;
  StreamSubscription<ActionEffect>? _effectSub;

  @override
  void initState() {
    super.initState();
    final entity = widget.entity;
    TemporaryCache.setEntity(
      CacheKeyToken.mediaPrecache(entity.id),
      entity,
    );

    _id = entity.id;
    _rawTitle = entity.title;
    _title = _rawTitle;
    _year = entity.publishDate ?? '';

    final rawAuthor = entity.creators;
    _authorName = AuthorFormatter.formatAuthorName(rawAuthor, defaultName: '');
    _authorAvatar = AuthorFormatter.formatAuthorAvatar(rawAuthor);
    _authorParams = AuthorFormatter.formatAuthorParams(rawAuthor);

    _rawAbstractText = entity.abstract ?? entity.description ?? '';
    _abstractText = _rawAbstractText;

    _venue = entity.journal ?? '';
    _doi = entity.doi ?? '';
    _coverUrl = entity.coverUrl ?? entity.thumbUrl ?? '';

    final rawUrl = entity.contentUrl;
    final rawId = entity.id;

    if (rawUrl.startsWith('http://') || rawUrl.startsWith('https://')) {
      _url = rawUrl.startsWith('http://') ? rawUrl.replaceFirst('http://', 'https://') : rawUrl;
    } else if (_doi.isNotEmpty) {
      _url = (_doi.startsWith('http://') || _doi.startsWith('https://')) ? _doi : 'https://doi.org/$_doi';
    } else if (rawId.startsWith('http://') || rawId.startsWith('https://')) {
      _url = rawId.startsWith('http://') ? rawId.replaceFirst('http://', 'https://') : rawId;
    } else if (rawId.startsWith('10.')) {
      _url = 'https://doi.org/$rawId';
    } else {
      _url = '';
    }

    _rawKeywords = entity.tags;
    _keywords = List<String>.from(_rawKeywords);

    _effectSub = ActionHub.instance.effectStream.listen((effect) {
      if (effect is PaperTranslationEffect && effect.contentId == _id) {
        if (!mounted) return;
        if (effect.isReset) {
          setState(() {
            _title = _rawTitle;
            _abstractText = _rawAbstractText;
            _keywords = _rawKeywords;
          });
          if (effect.error != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Translation failed: ${effect.error}')),
            );
          }
        } else if (effect.title != null || effect.abstractText != null || effect.keywords != null) {
          // 强类型实体数据流，零 JSON 字符串拼接与解析
          setState(() {
            if (effect.title?.isNotEmpty == true) _title = effect.title!;
            if (effect.abstractText?.isNotEmpty == true) _abstractText = effect.abstractText!;
            if (effect.keywords?.isNotEmpty == true) _keywords = effect.keywords!;
          });
        } else if (effect.translatedText != null) {
          _applyTranslation(effect.translatedText!);
        } else {
          ActionHub.instance.dispatchIntent(
            MediaType.academic,
            PaperTranslateAIIntent(_id, title: _rawTitle, abstractText: _rawAbstractText, keywords: _rawKeywords.join(', '), keywordsList: _rawKeywords),
          );
        }
      }
    });

    final cachedTranslated = TemporaryCache.get('paper_translated:$_id');
    if (cachedTranslated != null && cachedTranslated.isNotEmpty) {
      _applyTranslation(cachedTranslated);
    }
  }

  void _applyTranslation(String translated) {
    if (translated.isEmpty || translated == 'REQ_AI_TRANS' || translated == 'RESTORE' || translated == 'CLEAR') return;
    final parsed = PaperTranslationParser.parse(translated);
    if (mounted) {
      setState(() {
        if (parsed.title?.isNotEmpty == true) _title = parsed.title!;
        if (parsed.abstractText?.isNotEmpty == true) _abstractText = parsed.abstractText!;
        if (parsed.keywords?.isNotEmpty == true) _keywords = parsed.keywords!;
      });
    }
  }

  void _sharePaper() {
    Share.share('$_title\n$_authorName\n${_doi.isNotEmpty ? 'DOI: $_doi\n' : ''}$_url');
  }

  void _openPaperSourceUrl() {
    final rawPath = widget.entity.contentUrl;

    if (rawPath.isNotEmpty && !rawPath.startsWith('http://') && !rawPath.startsWith('https://')) {
      final cleanPath = rawPath.startsWith('file://') ? Uri.parse(rawPath).toFilePath() : rawPath;
      if (cleanPath.isNotEmpty && (cleanPath.startsWith('/') || RegExp(r'^[a-zA-Z]:').hasMatch(cleanPath))) {
        _openFullReader();
        return;
      }
    }

    if (_url.isNotEmpty) {
      context.navigate(RouteToken.webBrowser, MediaEntity(id: _url, title: _title, type: MediaType.academic, sourceId: widget.entity.sourceId, contentUrl: _url));
      return;
    }
    _openFullReader();
  }

  void _openFullReader() {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => PaperReaderScreen(entity: widget.entity)));
  }

  @override
  void dispose() {
    _effectSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textPrim = colorScheme.onSurface;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(_venue, style: TextStyle(color: textPrim, fontSize: 13, fontWeight: FontWeight.w600)),
        leading: IconButton(icon: Icon(Icons.arrow_back_ios_new_rounded, color: textPrim, size: 16), onPressed: () => Navigator.of(context).pop()),
        actions: [IconButton(icon: Icon(Icons.share_rounded, color: textPrim, size: 16), onPressed: _sharePaper)],
      ),
      body: Stack(
        children: [
          SelectionArea(
            onSelectionChanged: (content) => _selectedContent = content,
            contextMenuBuilder: (ctx, state) => buildActionContextMenu(ctx, state, selectedText: _selectedContent?.plainText.trim() ?? '', contentType: MediaType.academic, contentId: _id),
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 120),
              children: [
                PaperDetailHeaderCard(title: _title, venue: _venue, doi: _doi, year: _year, coverUrl: _coverUrl),
                const SizedBox(height: 18),
                PaperDetailAuthorBar(authorName: _authorName, authorAvatar: _authorAvatar, authorParams: _authorParams, parentParams: widget.entity.toMap()),
                const SizedBox(height: 18),
                PaperDetailActionBar(entity: widget.entity),
                const SizedBox(height: 18),
                PaperDetailAbstractCard(abstractText: _abstractText),
              ],
            ),
          ),
          Positioned(
            left: 20, right: 20, bottom: 12,
            child: SafeArea(
              top: false,
              child: SizedBox(
                height: 52,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(backgroundColor: theme.colorScheme.primary, foregroundColor: theme.colorScheme.onPrimary, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26))),
                  icon: const Icon(Icons.science_rounded, size: 20),
                  label: Text(ActionLocalizerScope.translate(context, id: ActionId.read.name, defaultText: '')),
                  onPressed: _openPaperSourceUrl,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// 学术文献二级页专属 Action 协同控制栏
class PaperDetailActionBar extends StatelessWidget {
  final MediaEntity entity;

  const PaperDetailActionBar({
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
