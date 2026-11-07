import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter/rendering.dart';
import 'package:pyro_action_hub/pyro_action_hub.dart';
import 'package:pyro_action_protocol/pyro_action_protocol.dart';
import 'package:pyro_media_models/pyro_media_models.dart';
import 'package:pyro_render_protocol/pyro_render_protocol.dart';
import 'package:pyro_source_download_engine/pyro_source_download_engine.dart';
import 'package:pyro_source_download_ui/pyro_source_download_ui.dart' as download_ui;
import 'package:pyro_viewer_hub/pyro_viewer_hub.dart';
import 'package:pyro_viewer_protocol/pyro_viewer_protocol.dart';
import 'l10n/generated/app_localizations.dart';

enum NovelReaderTheme {
  pureWhite,
  parchment,
  midnight,
}

class NovelReaderScreen extends StatefulWidget {
  final MediaEntity entity;

  const NovelReaderScreen({
    super.key,
    required this.entity,
  });

  @override
  State<NovelReaderScreen> createState() => _NovelReaderScreenState();
}

class _NovelReaderScreenState extends State<NovelReaderScreen> {
  late String _title;
  late String _author;
  double _fontSize = 18.0;
  NovelReaderTheme _theme = NovelReaderTheme.midnight;
  int _currentChapterIndex = 0;
  SelectedContent? _selectedContent;
  List<String> _paragraphs = [];
  List<String> _chapters = [];
  bool _showControls = true;
  final ScrollController _scrollController = ScrollController();
  static const int _pageSize = 25;

  @override
  void initState() {
    super.initState();
    _title = widget.entity.title;
    _author = AuthorFormatter.formatAuthorName(widget.entity.creators, defaultName: '');

    final content = widget.entity.description ?? '';
    if (content.isNotEmpty) {
      _paragraphs = content.split(RegExp(r'\r?\n+')).where((l) => l.trim().isNotEmpty).toList();
    }

    _loadLocalFileContent();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  List<ChapterEntity> _getGeneratedChapters(BuildContext context) {
    final downloadL10n = download_ui.AppLocalizations.of(context);
    final chapterCount = _totalChapters;
    return List.generate(
      chapterCount,
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
        currentIndex: _currentChapterIndex,
      );
    }
  }

  Future<void> _loadLocalFileContent() async {
    try {
      final String rawPath = widget.entity.contentUrl;
      if (rawPath.isEmpty) return;
      final String filePath = sanitizePhysicalPath(rawPath);
      if (filePath.toLowerCase().endsWith('.pdf')) {
        return;
      }
      final file = File(filePath);
      if (await file.exists()) {
        List<String> loadedLines = [];
        try {
          final ext = filePath.split('.').last.toLowerCase();
          if (['txt', 'md', 'log', 'ht', 'json'].contains(ext)) {
            final text = await file.readAsString();
            if (text.trim().isNotEmpty) {
              loadedLines = text.split(RegExp(r'\r?\n+')).where((l) => l.trim().isNotEmpty).toList();
            }
          }
        } catch (e) {
          debugPrint('[NovelReaderScreen] Skipping binary file: $filePath');
        }

        if (loadedLines.isNotEmpty && mounted) {
          setState(() {
            _paragraphs = loadedLines;
            final pageSize = _paragraphs.length > 30 ? _pageSize : 5;
            final chapterCount = (_paragraphs.length / pageSize).ceil().clamp(1, 9999);
            final secLabel = ActionLocalizerScope.translate(context, id: ActionId.read.name, defaultText: '');
            _chapters = List.generate(chapterCount, (i) => '$secLabel ${i + 1} / $chapterCount');
          });
          _triggerAutoPreload(context);
        }
      }
    } catch (e) {
      debugPrint('[NovelReaderScreen] Failed to read local file: $e');
    }
  }

  (Color bg, Color textPrim, Color textSec) _resolveThemeColors() {
    switch (_theme) {
      case NovelReaderTheme.pureWhite:
        return (const Color(0xFFFFFFFF), const Color(0xFF1E1E1E), const Color(0xFF757575));
      case NovelReaderTheme.parchment:
        return (const Color(0xFFF6F1E5), const Color(0xFF2B1810), const Color(0xFF6E5346));
      case NovelReaderTheme.midnight:
        return (const Color(0xFF161318), const Color(0xFFF2ECF4), const Color(0xFF9E8F9F));
    }
  }

  int get _totalChapters {
    if (_chapters.isNotEmpty) return _chapters.length;
    final pageSize = _paragraphs.length > 30 ? _pageSize : 5;
    return (_paragraphs.length / pageSize).ceil().clamp(1, 9999);
  }

  void _nextChapter() {
    if (_currentChapterIndex < _totalChapters - 1) {
      setState(() => _currentChapterIndex++);
      if (_scrollController.hasClients) _scrollController.jumpTo(0);
      _triggerAutoPreload(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(ActionLocalizerScope.translate(context, id: ActionId.read.name, defaultText: ''))),
      );
    }
  }

  void _previousChapter() {
    if (_currentChapterIndex > 0) {
      setState(() => _currentChapterIndex--);
      if (_scrollController.hasClients) _scrollController.jumpTo(0);
      _triggerAutoPreload(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(ActionLocalizerScope.translate(context, id: ActionId.read.name, defaultText: ''))),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final downloadL10n = download_ui.AppLocalizations.of(context);
    final (bg, textPrim, textSec) = _resolveThemeColors();

    final String rawPath = widget.entity.contentUrl;
    if (rawPath.isNotEmpty) {
      final cleanPath = sanitizePhysicalPath(rawPath);
      final viewerWidget = ViewerHub.instance.buildViewer(context, cleanPath, entity: widget.entity);
      if (viewerWidget != null) {
        return viewerWidget;
      }
    }

    final int startIdx = _currentChapterIndex * _pageSize;
    final displayParagraphs = _paragraphs.length > _pageSize
        ? _paragraphs.skip(startIdx).take(_pageSize).toList()
        : _paragraphs;

    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: Stack(
          children: [
            GestureDetector(
              onTap: () => setState(() => _showControls = !_showControls),
              child: SelectionArea(
                onSelectionChanged: (content) => _selectedContent = content,
                contextMenuBuilder: (context, state) => buildActionContextMenu(
                  context,
                  state,
                  selectedText: _selectedContent?.plainText.trim() ?? '',
                  contentType: widget.entity.type,
                  contentId: widget.entity.id,
                ),
                child: ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 64),
                  itemCount: displayParagraphs.isNotEmpty ? displayParagraphs.length : 1,
                  itemBuilder: (context, index) {
                    if (displayParagraphs.isEmpty) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 40),
                          child: Text(
                            _title,
                            style: TextStyle(color: textSec, fontSize: 16),
                          ),
                        ),
                      );
                    }
                    final para = displayParagraphs[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        '    $para',
                        style: TextStyle(
                          color: textPrim,
                          fontSize: _fontSize,
                          height: 1.8,
                          letterSpacing: 0.3,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            if (_showControls)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  color: bg.withValues(alpha: 0.95),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios_new_rounded, color: textPrim, size: 20),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              _title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: textPrim, fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            if (_author.isNotEmpty)
                              Text(
                                _author,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(color: textSec, fontSize: 12),
                              ),
                          ],
                        ),
                      ),
                      // 离线下载与导出微组件按钮
                      IconButton(
                        icon: Icon(Icons.download_for_offline_rounded, color: textPrim, size: 20),
                        tooltip: downloadL10n.downloadOfflineChapters,
                        onPressed: () {
                          download_ui.ReaderDownloadWidget.showOptions(
                            context,
                            entity: widget.entity,
                            allChapters: _getGeneratedChapters(context),
                            currentChapterIndex: _currentChapterIndex,
                          );
                        },
                      ),
                      // 预加载与存储配额设置按钮
                      IconButton(
                        icon: Icon(Icons.tune_rounded, color: textPrim, size: 20),
                        tooltip: downloadL10n.preloadSettingsTitle,
                        onPressed: () {
                          download_ui.PreloadSettingsSheet.show(context);
                        },
                      ),
                      if (l10n != null)
                        IconButton(
                          icon: Icon(Icons.format_size_rounded, color: textPrim, size: 20),
                          tooltip: l10n.fontSize,
                          onPressed: () {
                            setState(() {
                              _fontSize = _fontSize >= 26.0 ? 14.0 : _fontSize + 2.0;
                            });
                          },
                        ),
                      IconButton(
                        icon: Icon(
                          _theme == NovelReaderTheme.midnight
                              ? Icons.dark_mode_rounded
                              : (_theme == NovelReaderTheme.parchment ? Icons.menu_book_rounded : Icons.light_mode_rounded),
                          color: textPrim,
                          size: 20,
                        ),
                        onPressed: () {
                          setState(() {
                            if (_theme == NovelReaderTheme.midnight) {
                              _theme = NovelReaderTheme.parchment;
                            } else if (_theme == NovelReaderTheme.parchment) {
                              _theme = NovelReaderTheme.pureWhite;
                            } else {
                              _theme = NovelReaderTheme.midnight;
                            }
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),

            if (_showControls && l10n != null)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  color: bg.withValues(alpha: 0.95),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton.icon(
                        icon: Icon(Icons.skip_previous_rounded, size: 18, color: textPrim),
                        label: Text(l10n.previousChapter, style: TextStyle(color: textPrim)),
                        onPressed: _previousChapter,
                      ),
                      Text(
                        '${l10n.chapter} ${_currentChapterIndex + 1} / $_totalChapters',
                        style: TextStyle(color: textSec, fontSize: 13, fontWeight: FontWeight.w600),
                      ),
                      TextButton.icon(
                        icon: Icon(Icons.skip_next_rounded, size: 18, color: textPrim),
                        label: Text(l10n.nextChapter, style: TextStyle(color: textPrim)),
                        onPressed: _nextChapter,
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
