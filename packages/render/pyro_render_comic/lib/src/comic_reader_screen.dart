import 'package:flutter/foundation.dart';
import 'package:material_ui/material_ui.dart';
import 'package:pyro_action_hub/pyro_action_hub.dart';
import 'package:pyro_action_protocol/pyro_action_protocol.dart';
import 'package:pyro_media_models/pyro_media_models.dart';
import 'package:pyro_render_protocol/pyro_render_protocol.dart';
import 'package:pyro_source_download_engine/pyro_source_download_engine.dart';
import 'package:pyro_source_download_ui/pyro_source_download_ui.dart' as download_ui;
import 'package:pyro_viewer_hub/pyro_viewer_hub.dart';
import 'package:pyro_viewer_protocol/pyro_viewer_protocol.dart';

import 'l10n/generated/app_localizations.dart';

/// 漫画/画集深度全屏阅读器屏幕 (100% 强类型)
class ComicReaderScreen extends StatefulWidget {
  final MediaEntity entity;

  const ComicReaderScreen({
    super.key,
    required this.entity,
  });

  @override
  State<ComicReaderScreen> createState() => _ComicReaderScreenState();
}

class _ComicReaderScreenState extends State<ComicReaderScreen> {
  late String _title;
  late String _artist;
  late List<String> _imageUrls;
  bool _isContinuous = true;
  bool _showOverlays = true;
  int _currentPage = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _title = widget.entity.title;
    _artist = AuthorFormatter.formatAuthorName(widget.entity.creators, defaultName: '');
    final cover = widget.entity.coverUrl ?? widget.entity.thumbUrl ?? widget.entity.contentUrl;
    if (widget.entity.itemIds.isNotEmpty) {
      _imageUrls = widget.entity.itemIds;
    } else if (cover.isNotEmpty) {
      _imageUrls = [cover];
    } else {
      _imageUrls = [];
    }

    _pageController = PageController(initialPage: _currentPage);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  List<ChapterEntity> _getGeneratedChapters(BuildContext context) {
    final downloadL10n = download_ui.AppLocalizations.of(context);
    final count = _imageUrls.isNotEmpty ? _imageUrls.length : 1;
    return List.generate(
      count,
      (i) => ChapterEntity(
        id: 'ch_${i + 1}',
        bookId: widget.entity.id,
        title: downloadL10n.chapterTitle(i + 1),
        index: i + 1,
      ),
    );
  }

  void _triggerAutoPreload(BuildContext context) {
    final chapterList = _getGeneratedChapters(context);
    if (chapterList.isNotEmpty) {
      PyroDownloadCacheHub.instance.triggerReaderPreload(
        sourceId: widget.entity.sourceId ?? '',
        bookId: widget.entity.id,
        allChapters: chapterList,
        currentIndex: _currentPage,
      );
    }
  }

  void _toggleOverlays() {
    setState(() {
      _showOverlays = !_showOverlays;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final downloadL10n = download_ui.AppLocalizations.of(context);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // 优先尝试通过 ViewerHub 调用原生漫画/连环画/PDF/EPUB 渲染引擎
    final String rawPath = widget.entity.contentUrl;

    if (rawPath.isNotEmpty) {
      final cleanPath = sanitizePhysicalPath(rawPath);
      if (ViewerHub.instance.supports(cleanPath)) {
        final viewerWidget = ViewerHub.instance.buildViewer(
          context,
          cleanPath,
          entity: widget.entity,
        );
        if (viewerWidget != null) {
          return viewerWidget;
        }
      }
    }

    final totalPages = _imageUrls.isNotEmpty ? _imageUrls.length : 1;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          GestureDetector(
            onTap: _toggleOverlays,
            behavior: HitTestBehavior.opaque,
            child: _imageUrls.isEmpty
                ? _buildEmptyState(theme, _title)
                : _isContinuous
                    ? _buildContinuousView()
                    : _buildPagedView(),
          ),

          AnimatedPositioned(
            duration: const Duration(milliseconds: 200),
            top: _showOverlays ? 0 : -100,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 4,
                bottom: 8,
                left: 8,
                right: 8,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withValues(alpha: 0.85),
                    Colors.transparent,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: colorScheme.onSurface),
                    onPressed: () => Navigator.of(context).maybePop(),
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _title,
                          style: TextStyle(
                            color: colorScheme.onSurface,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (_artist.isNotEmpty)
                          Text(
                            _artist,
                            style: TextStyle(
                              color: colorScheme.onSurfaceVariant,
                              fontSize: 12,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                      ],
                    ),
                  ),
                  // 离线下载与导出按钮
                  IconButton(
                    icon: Icon(Icons.download_for_offline_rounded, color: colorScheme.onSurface),
                    tooltip: downloadL10n.downloadOfflineChapters,
                    onPressed: () {
                      download_ui.ReaderDownloadWidget.showOptions(
                        context,
                        entity: widget.entity,
                        allChapters: _getGeneratedChapters(context),
                        currentChapterIndex: _currentPage,
                      );
                    },
                  ),
                  // 预加载设置按钮
                  IconButton(
                    icon: Icon(Icons.tune_rounded, color: colorScheme.onSurface),
                    tooltip: downloadL10n.preloadSettingsTitle,
                    onPressed: () {
                      download_ui.PreloadSettingsSheet.show(context);
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      _isContinuous
                          ? Icons.view_day_outlined
                          : Icons.menu_book_outlined,
                      color: colorScheme.onSurface,
                    ),
                    tooltip: _isContinuous ? (l10n.pageMode) : (l10n.stripMode),
                    onPressed: () {
                      setState(() {
                        _isContinuous = !_isContinuous;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),

          AnimatedPositioned(
            duration: const Duration(milliseconds: 200),
            bottom: _showOverlays ? 0 : -100,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).padding.bottom + 8,
                top: 8,
                left: 16,
                right: 16,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.85),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.7),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${_currentPage + 1} / $totalPages',
                      style: TextStyle(color: colorScheme.onSurface, fontSize: 12),
                    ),
                  ),
                  Row(
                    children: [
                      TextButton.icon(
                        icon: Icon(
                          Icons.document_scanner_outlined,
                          size: 16,
                          color: colorScheme.primary,
                        ),
                        label: Text(
                          l10n.ocr,
                          style: TextStyle(
                            color: colorScheme.primary,
                            fontSize: 12,
                          ),
                        ),
                        onPressed: () {
                          context.dispatchIntent(
                            MediaType.manga,
                            ComicOCRIntent(widget.entity.id),
                          );
                        },
                      ),
                      const SizedBox(width: 8),
                      TextButton.icon(
                        icon: Icon(
                          Icons.translate,
                          size: 16,
                          color: colorScheme.onSurface,
                        ),
                        label: Text(
                          l10n.translate,
                          style: TextStyle(
                            color: colorScheme.onSurface,
                            fontSize: 12,
                          ),
                        ),
                        onPressed: () {
                          context.dispatchIntent(
                            MediaType.manga,
                            ComicTranslateAIIntent(widget.entity.id),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContinuousView() {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: _imageUrls.length,
      itemBuilder: (context, index) {
        return InteractiveViewer(
          minScale: 1.0,
          maxScale: 3.0,
          child: Image.network(
            _imageUrls[index],
            fit: BoxFit.fitWidth,
            errorBuilder: (_, __, ___) => _buildPlaceholderPanel(index + 1),
          ),
        );
      },
    );
  }

  Widget _buildPagedView() {
    return PageView.builder(
      controller: _pageController,
      itemCount: _imageUrls.length,
      onPageChanged: (index) {
        setState(() {
          _currentPage = index;
        });
        _triggerAutoPreload(context);
      },
      itemBuilder: (context, index) {
        return InteractiveViewer(
          minScale: 1.0,
          maxScale: 3.5,
          child: Center(
            child: Image.network(
              _imageUrls[index],
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) => _buildPlaceholderPanel(index + 1),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPlaceholderPanel(int pageNum) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      height: 480,
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHigh,
        border: Border.all(
          color: colorScheme.outlineVariant.withValues(alpha: 0.5),
        ),
      ),
      child: Center(
        child: Icon(
          Icons.broken_image_outlined,
          color: colorScheme.primary,
          size: 48,
        ),
      ),
    );
  }

  Widget _buildEmptyState(ThemeData theme, String title) {
    final colorScheme = theme.colorScheme;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.auto_stories_outlined, color: colorScheme.outline, size: 64),
          const SizedBox(height: 16),
          Text(
            title,
            style: TextStyle(
              color: colorScheme.onSurface,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (_artist.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              _artist,
              style: TextStyle(
                color: colorScheme.onSurfaceVariant,
                fontSize: 14,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
