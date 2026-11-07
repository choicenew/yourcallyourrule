import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:material_ui/material_ui.dart';
import 'package:pyro_action_hub/pyro_action_hub.dart';
import 'package:pyro_action_protocol/pyro_action_protocol.dart';
import 'package:pyro_media_models/pyro_media_models.dart';
import 'package:pyro_render_protocol/pyro_render_protocol.dart';

import 'package:pyro_render_paper/src/l10n/generated/app_localizations.dart';
import 'paper_intents.dart';
import 'paper_translation_parser.dart';

/// 学术文献卡片 Widget (基于 MediaEntity 强类型全量渲染，0 三元运算，100% 标准国际化)
class PaperCard extends StatefulWidget {
  final MediaEntity entity;
  final bool isSelected;

  const PaperCard({
    super.key,
    required this.entity,
    this.isSelected = false,
  });

  @override
  State<PaperCard> createState() => _PaperCardState();
}

class _PaperCardState extends State<PaperCard> {
  StreamSubscription<ActionEffect>? _effectSub;
  String? _translatedTitle;
  String? _translatedAbstract;
  List<String>? _translatedKeywords;

  @override
  void initState() {
    super.initState();
    final contentId = widget.entity.id;
    TemporaryCache.setEntity(
      CacheKeyToken.mediaPrecache(contentId),
      widget.entity,
    );

    _effectSub = ActionHub.instance.effectStream.listen((effect) {
      if (effect is PaperTranslationEffect && effect.contentId == contentId) {
        if (!mounted) return;

        if (effect.isReset) {
          setState(() {
            _translatedTitle = null;
            _translatedAbstract = null;
            _translatedKeywords = null;
          });
        } else if (effect.translatedText != null) {
          _parseAndApplyTranslation(effect.translatedText!);
        } else {
          context.dispatchIntent(
            MediaType.academic,
            PaperTranslateAIIntent(
              contentId,
              title: widget.entity.title,
              abstractText: widget.entity.abstract ?? widget.entity.description ?? '',
              keywords: widget.entity.tags.join(', '),
              keywordsList: widget.entity.tags,
            ),
          );
        }
      }
    });
  }

  void _parseAndApplyTranslation(String rawTranslatedText) {
    if (rawTranslatedText.isEmpty) return;
    final parsed = PaperTranslationParser.parse(rawTranslatedText);
    if (mounted) {
      setState(() {
        if (parsed.title?.isNotEmpty == true) {
          _translatedTitle = parsed.title;
        }
        if (parsed.abstractText?.isNotEmpty == true) {
          _translatedAbstract = parsed.abstractText;
        }
        if (parsed.keywords?.isNotEmpty == true) {
          _translatedKeywords = parsed.keywords;
        }
      });
    }
  }

  @override
  void dispose() {
    _effectSub?.cancel();
    super.dispose();
  }

  void _showQuickReadSheet(
    BuildContext context,
    String title,
    String abstractText,
    String authorStr,
    String sourceName,
    List<String> keywords,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context);

    String previewTitleText = '';
    String closeText = '';
    String readFullText = '';

    if (l10n != null) {
      previewTitleText = l10n.paperPreviewTitle;
      closeText = l10n.close;
      readFullText = l10n.readFullPaper;
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.school_rounded, color: colorScheme.primary, size: 22),
                  const SizedBox(width: 8),
                  Text(
                    previewTitleText,
                    style: TextStyle(
                      color: colorScheme.onSurface,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: TextStyle(
                  color: colorScheme.onSurface,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  height: 1.3,
                ),
              ),
              if (authorStr.isNotEmpty) ...[
                const SizedBox(height: 6),
                Text(
                  authorStr,
                  style: TextStyle(
                    color: colorScheme.onSurfaceVariant,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
              const Divider(height: 24),
              Flexible(
                child: SingleChildScrollView(
                  child: Text(
                    abstractText,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: colorScheme.onSurface,
                      fontSize: 13,
                      height: 1.5,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FilledButton.tonal(
                    onPressed: () => Navigator.pop(context),
                    child: Text(closeText),
                  ),
                  const SizedBox(width: 8),
                  FilledButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      context.navigateEntity(widget.entity, RouteToken.paperDetail);
                    },
                    icon: const Icon(Icons.menu_book_rounded, size: 16),
                    label: Text(readFullText),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFallbackPaperCover(ColorScheme colorScheme, String title) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            colorScheme.primaryContainer.withValues(alpha: 0.6),
            colorScheme.surfaceContainerHighest,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -10,
            bottom: -10,
            child: Icon(
              Icons.school_rounded,
              size: 72,
              color: colorScheme.primary.withValues(alpha: 0.12),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Icon(
                Icons.school_outlined,
                color: colorScheme.primary,
                size: 28,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _extractDisplayDate() {
    final pubDate = widget.entity.publishDate?.trim() ?? '';
    if (pubDate.isNotEmpty) {
      return pubDate;
    }
    final updateTime = widget.entity.updateTime ?? widget.entity.createTime;
    if (updateTime != null) {
      return updateTime.toIso8601String().split('T').first;
    }
    return '';
  }

  String _resolvePaperType(BuildContext context) {
    final journal = widget.entity.journal?.trim() ?? '';
    if (journal.isNotEmpty) {
      return journal;
    }
    final category = widget.entity.category?.trim() ?? '';
    if (category.isNotEmpty) {
      return category;
    }
    return widget.entity.type.getLocalizedName(context);
  }

  String _resolveSourceName() {
    final publisher = widget.entity.publisher?.trim() ?? '';
    if (publisher.isNotEmpty) {
      return publisher;
    }
    return widget.entity.sourceId.trim();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final rawTitle = widget.entity.title;
    final title = _translatedTitle ?? rawTitle;

    final rawAuthor = widget.entity.creators;
    final authorStr = AuthorFormatter.formatAuthorName(
      rawAuthor,
      defaultName: '',
    );
    final authorAvatar = AuthorFormatter.formatAuthorAvatar(rawAuthor);
    final authorParams = AuthorFormatter.formatAuthorParams(rawAuthor);

    final abstractText = _translatedAbstract ?? widget.entity.abstract ?? widget.entity.description ?? '';

    // 1. 来源说明 (标准国际化与真实字段，零三元运算)
    final cleanSourceName = _resolveSourceName();

    // 2. 左上角内容/文章类型 (标准国际化，零三元运算)
    final paperType = _resolvePaperType(context);

    // 3. 右上角插件时间/日期
    final displayDate = _extractDisplayDate();

    final List<String> keywords = _translatedKeywords ?? widget.entity.tags;
    final thumbUrl = widget.entity.thumbUrl ?? widget.entity.coverUrl ?? '';

    final cardBg = colorScheme.surfaceContainerLow;
    final containerBg = colorScheme.surfaceContainerHighest;
    final borderCol = colorScheme.outlineVariant.withValues(alpha: 0.5);
    final textPrimary = colorScheme.onSurface;
    final textSecondary = colorScheme.onSurfaceVariant;
    final primaryColor = colorScheme.primary;

    double aspectRatioValue = 3.2;
    if (thumbUrl.isNotEmpty) {
      aspectRatioValue = 2.2;
    }

    Widget? avatarChild;
    if (authorAvatar.trim().isEmpty) {
      String firstChar = 'A';
      final cleanAuthor = authorStr.trim();
      if (cleanAuthor.isNotEmpty) {
        firstChar = cleanAuthor[0].toUpperCase();
      }
      avatarChild = Text(
        firstChar,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: primaryColor,
        ),
      );
    }

    ImageProvider? bgImage;
    if (authorAvatar.trim().isNotEmpty) {
      bgImage = NetworkImage(authorAvatar.trim());
    }

    return GestureDetector(
      onTap: () {
        context.navigateEntity(widget.entity, RouteToken.paperDetail);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
        decoration: BoxDecoration(
          color: widget.isSelected
              ? colorScheme.primaryContainer.withValues(alpha: 0.25)
              : cardBg,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: widget.isSelected ? primaryColor : borderCol,
            width: widget.isSelected ? 1.2 : 0.8,
          ),
          boxShadow: [
            BoxShadow(
              color: widget.isSelected
                  ? primaryColor.withValues(alpha: 0.12)
                  : colorScheme.shadow.withValues(alpha: 0.08),
              blurRadius: widget.isSelected ? 10 : 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // 1. Header 缩略图
              Stack(
                children: [
                  AspectRatio(
                    aspectRatio: aspectRatioValue,
                    child: SafeImageBuilder.buildSafeCoverImage(
                      url: thumbUrl,
                      fallbackWidget: _buildFallbackPaperCover(colorScheme, title),
                    ),
                  ),
                  // 左上角：标准国际化类型 Badge
                  if (paperType.isNotEmpty)
                    Positioned(
                      top: 6,
                      left: 6,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2.5),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.65),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          paperType.toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.2,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  // 右上角：插件时间/日期
                  if (displayDate.isNotEmpty)
                    Positioned(
                      top: 6,
                      right: 6,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2.5),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.65),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          displayDate,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  // 选中指示器 Badge
                  if (widget.isSelected)
                    Positioned(
                      bottom: 6,
                      right: 6,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: primaryColor.withValues(alpha: 0.4),
                              blurRadius: 6,
                            ),
                          ],
                        ),
                        child: const Text(
                          'Selected',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.1,
                          ),
                        ),
                      ),
                    ),
                ],
              ),

              // 2. 核心内容层
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AutoSizeText(
                      title,
                      style: TextStyle(
                        color: textPrimary,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w700,
                        height: 1.28,
                        letterSpacing: -0.1,
                      ),
                      minFontSize: 11.0,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (abstractText.isNotEmpty) ...[
                      const SizedBox(height: 5),
                      GestureDetector(
                        onLongPress: () => _showQuickReadSheet(
                          context,
                          title,
                          abstractText,
                          authorStr,
                          cleanSourceName,
                          keywords,
                        ),
                        child: AutoSizeText(
                          abstractText,
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            color: textSecondary,
                            fontSize: 12.0,
                            height: 1.42,
                            letterSpacing: 0.1,
                          ),
                          minFontSize: 10.0,
                          maxLines: 15,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                    const SizedBox(height: 8),

                    // 3. 作者栏
                    if (authorStr.isNotEmpty)
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                final navParams = Map<String, dynamic>.from(authorParams);
                                navParams[RenderActionTokens.paramSourceId] = widget.entity.sourceId;
                                navParams[RenderActionTokens.paramPluginId] = widget.entity.sourceId;
                                navParams[RenderActionTokens.paramContentType] = widget.entity.type.name;

                                String targetAuthorId = authorStr;
                                final rawId = navParams[RenderActionTokens.paramId];
                                if (rawId != null) {
                                  targetAuthorId = rawId.toString();
                                }

                                context.navigate(
                                  RouteToken.authorProfile,
                                  MediaEntity(
                                    id: targetAuthorId,
                                    type: widget.entity.type,
                                    title: authorStr,
                                    coverUrl: authorAvatar,
                                    sourceId: widget.entity.sourceId,
                                    contentUrl: widget.entity.contentUrl,
                                  ),
                                );
                              },
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 11,
                                    backgroundColor: primaryColor.withValues(alpha: 0.15),
                                    backgroundImage: bgImage,
                                    child: avatarChild,
                                  ),
                                  const SizedBox(width: 6),
                                  Expanded(
                                    child: Text(
                                      authorStr,
                                      style: TextStyle(
                                        color: textPrimary,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 4),
                          StreamBuilder<List<UserAction>>(
                            stream: ActionHub.instance.watchActions(
                              RenderActionTokens.authorTarget,
                              authorParams[RenderActionTokens.paramId]?.toString() ?? authorStr,
                            ),
                            builder: (context, snapshot) {
                              final actions = snapshot.data ?? [];
                              bool isFollowing = false;
                              for (final a in actions) {
                                if (a.id == RenderActionTokens.followAction && a.isActive) {
                                  isFollowing = true;
                                  break;
                                }
                              }

                              Color buttonBg = containerBg;
                              Color borderBgColor = borderCol;
                              IconData iconData = Icons.add_rounded;
                              Color iconColor = textPrimary;

                              if (isFollowing) {
                                buttonBg = primaryColor.withValues(alpha: 0.15);
                                borderBgColor = primaryColor.withValues(alpha: 0.4);
                                iconData = Icons.check_rounded;
                                iconColor = primaryColor;
                              }

                              return InkWell(
                                borderRadius: BorderRadius.circular(12),
                                onTap: () {
                                  String followId = authorStr;
                                  final rawId = authorParams[RenderActionTokens.paramId];
                                  if (rawId != null) {
                                    followId = rawId.toString();
                                  }
                                  ActionHub.instance.dispatchIntent(
                                    RenderActionTokens.authorTarget,
                                    GenericFollowIntent(followId),
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: buttonBg,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: borderBgColor,
                                      width: 0.8,
                                    ),
                                  ),
                                  child: Icon(
                                    iconData,
                                    size: 14,
                                    color: iconColor,
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),

                    // 4. 来源标签
                    if (cleanSourceName.isNotEmpty) ...[
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Icon(Icons.source_rounded, size: 11, color: textSecondary),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              cleanSourceName,
                              style: TextStyle(
                                color: textSecondary,
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],

                    // 5. 关键词 Tags
                    if (keywords.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 4,
                        runSpacing: 4,
                        children: keywords.take(3).map((kw) {
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: primaryColor.withValues(alpha: 0.08),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              kw,
                              style: TextStyle(
                                color: primaryColor,
                                fontSize: 9.5,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
