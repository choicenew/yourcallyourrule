import 'dart:async';
import 'dart:convert';

import 'package:material_ui/material_ui.dart';
import 'package:pyro_render_paper/src/l10n/generated/app_localizations.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_action_hub/pyro_action_hub.dart';
import 'package:pyro_action_protocol/pyro_action_protocol.dart';
import 'package:pyro_api_translate/pyro_api_translate.dart';
import 'package:pyro_translation_cache/pyro_translation_cache.dart';
import 'package:pyro_edge_ai_orchestrator/pyro_edge_ai_orchestrator.dart';
import 'package:pyro_media_mapper/pyro_media_mapper.dart';
import 'package:pyro_media_models/pyro_media_models.dart';
import 'package:share_plus/share_plus.dart';

import 'package:pyro_render_protocol/pyro_render_protocol.dart' hide AppLocalizations;

import 'paper_intents.dart';
import 'paper_translation_parser.dart';

part 'paper_action_provider.g.dart';

/// 学术文献动作提供者 (Riverpod 3 自动生成 Notifier)
@Riverpod(keepAlive: true)
class PaperActions extends _$PaperActions implements ActionProvider {
  final Map<String, bool> _pushedMap = {};
  final Map<String, bool> _favoritesMap = {};
  final Map<String, bool> _aiTranslatedMap = {};
  final Map<String, ActionStatus> _pushStatuses = {};
  final Map<String, ActionStatus> _ocrStatuses = {};

  final _orchestrator = PyroTranslateOrchestrator();

  static String? _sanitizeResult(String res) {
    final cleaned = PaperTranslationParser.sanitizeText(res);
    if (cleaned.isEmpty || cleaned.startsWith('{') || cleaned.startsWith('[')) {
      return null;
    }
    return cleaned;
  }

  static Future<String> _safeTranslate(
    String text, {
    required String targetLanguage,
  }) async {
    final trimmed = text.trim();
    if (trimmed.isEmpty) return '';

    // 1. 优先检索 PyroTranslationCacheEngine L1/L2 双级专职缓存
    final cached = await PyroTranslationCacheEngine.instance.get(
      trimmed,
      targetLang: targetLanguage,
    );
    if (cached != null && cached.isNotEmpty) {
      return cached;
    }

    // 2. 缓存未命中，发起真实翻译请求
    String translatedResult = '';
    if (trimmed.length <= 1500) {
      final res = await TranslationService.instance.translate(
        trimmed,
        targetLanguage: targetLanguage,
      );
      final sanitized = _sanitizeResult(res);
      if (sanitized != null && sanitized.isNotEmpty) {
        translatedResult = sanitized;
      } else {
        translatedResult = trimmed;
      }
    } else {
      final chunks = _splitTextChunks(trimmed, maxChunkSize: 1500);
      final translatedChunks = <String>[];
      for (final chunk in chunks) {
        if (chunk.trim().isEmpty) continue;
        try {
          final res = await TranslationService.instance.translate(
            chunk.trim(),
            targetLanguage: targetLanguage,
          );
          final sanitized = _sanitizeResult(res);
          translatedChunks.add((sanitized != null && sanitized.isNotEmpty) ? sanitized : chunk);
        } catch (e) {
          debugPrint('⚠️ [PaperActions] translate failed for chunk: $e');
          translatedChunks.add(chunk);
        }
      }
      translatedResult = translatedChunks.join('\n\n');
    }

    // 3. 写入双级专职翻译缓存 (只存纯文本，严禁写入任何 JSON 包裹)
    if (translatedResult.isNotEmpty &&
        !translatedResult.startsWith('{') &&
        !translatedResult.startsWith('[')) {
      PyroTranslationCacheEngine.instance.put(
        trimmed,
        translatedResult,
        targetLang: targetLanguage,
      );
    }

    return translatedResult;
  }

  static List<String> _splitTextChunks(
    String text, {
    required int maxChunkSize,
  }) {
    final paragraphs = text.split(RegExp(r'\n+'));
    final List<String> chunks = [];
    String currentChunk = '';

    for (final p in paragraphs) {
      if (p.length <= maxChunkSize) {
        if ((currentChunk.length + p.length + 1) <= maxChunkSize) {
          currentChunk = currentChunk.isEmpty ? p : '$currentChunk\n$p';
        } else {
          if (currentChunk.isNotEmpty) chunks.add(currentChunk);
          currentChunk = p;
        }
      } else {
        final sentences = p.split(RegExp(r'(?<=[.!?。！？;；])\s+'));
        for (final s in sentences) {
          if ((currentChunk.length + s.length + 1) <= maxChunkSize) {
            currentChunk = currentChunk.isEmpty ? s : '$currentChunk $s';
          } else {
            if (currentChunk.isNotEmpty) chunks.add(currentChunk);
            if (s.length > maxChunkSize) {
              for (var i = 0; i < s.length; i += maxChunkSize) {
                final end =
                    (i + maxChunkSize < s.length) ? i + maxChunkSize : s.length;
                chunks.add(s.substring(i, end));
              }
              currentChunk = '';
            } else {
              currentChunk = s;
            }
          }
        }
      }
    }
    if (currentChunk.isNotEmpty) {
      chunks.add(currentChunk);
    }
    return chunks.isNotEmpty ? chunks : [text];
  }

  MediaEntity? _getCachedEntity(String cid) {
    return TemporaryCache.getEntity(CacheKeyToken.mediaPrecache(cid));
  }

  @override
  List<UserAction> build(String contentId) {
    final pushStatus = _pushStatuses[contentId] ?? ActionStatus.idle;
    final isPushed = _pushedMap[contentId] ?? false;
    final isFavorite = _favoritesMap[contentId] ?? false;
    final isAiTranslated = _aiTranslatedMap[contentId] ?? false;
    final cachedEntity = _getCachedEntity(contentId);

    final translateSubActions = [
      UserAction(
        id: ActionId.paperTranslateAi,
        icon: Icons.auto_awesome_rounded,
        label: ActionId.paperTranslateAi.name,
        isActive: isAiTranslated,
        order: 1000,
        intent: PaperTranslateAIIntent(contentId),
      ),
      UserAction(
        id: ActionId.paperTranslateEngine,
        icon: Icons.g_translate_rounded,
        label: ActionId.paperTranslateEngine.name,
        order: 900,
        intent: PaperTranslateEngineIntent(contentId),
      ),
    ];

    return [
      UserAction(
        id: ActionId.push,
        icon: isPushed ? Icons.cloud_done_rounded : Icons.cloud_upload_rounded,
        label: ActionId.push.name,
        status: pushStatus,
        isActive: isPushed,
        order: 1000,
        intent: PaperPushIntent(
          contentId,
          entity: cachedEntity ?? MediaEntity(
            id: contentId,
            title: contentId,
            type: MediaType.academic,
            sourceId: const UserActionSourceToken().toString(),
            contentUrl: contentId,
            createTime: DateTime.now(),
            updateTime: DateTime.now(),
          ),
        ),
      ),
      UserAction(
        id: ActionId.favorite,
        icon: isFavorite ? Icons.star_rounded : Icons.star_border_rounded,
        label: ActionId.favorite.name,
        isActive: isFavorite,
        order: 900,
        intent: PaperFavoriteIntent(contentId),
      ),
      UserAction(
        id: ActionId.translate,
        icon: Icons.translate_rounded,
        label: ActionId.translate.name,
        isActive: isAiTranslated,
        order: 800,
        subActions: translateSubActions,
      ),
      UserAction(
        id: ActionId.share,
        icon: Icons.share_rounded,
        label: ActionId.share.name,
        order: 700,
        intent: PaperShareIntent(contentId),
      ),
    ];
  }

  void _safeInvalidateSelf() {
    try {
      ref.invalidateSelf();
    } catch (_) {}
  }

  @override
  Stream<List<UserAction>> watchActions(String contentId, {MediaEntity? entity}) {
    if (entity != null) {
      TemporaryCache.setEntity(CacheKeyToken.mediaPrecache(contentId), entity);
    }
    return Stream.value(build(contentId));
  }

  @override
  void handleIntent(UserIntent intent) async {
    final contentId = intent.contentId;
    if (intent is PaperFavoriteIntent) {
      final isFav = !(_favoritesMap[contentId] ?? false);
      _favoritesMap[contentId] = isFav;
      _safeInvalidateSelf();
      ActionHub.instance.dispatchIntent(MediaType.academic, GenericLikeIntent(contentId));
    } else if (intent is GenericPushIntent) {
      _pushedMap[contentId] = true;
      _pushStatuses[contentId] = ActionStatus.idle;
      _safeInvalidateSelf();
    } else if (intent is PaperReadIntent) {
      if (contentId.startsWith('http://') || contentId.startsWith('https://')) {
        final safeUrl = contentId.startsWith('http://')
            ? contentId.replaceFirst('http://', 'https://')
            : contentId;
        final uri = Uri.tryParse(safeUrl);
        if (uri != null) {
          ActionHub.instance.emitEffect(OpenUrlEffect(uri));
        }
      } else {
        final urlStr =
            contentId.contains('/')
                ? 'https://doi.org/$contentId'
                : 'https://scholar.google.com/scholar?q=$contentId';
        final uri = Uri.tryParse(urlStr);
        if (uri != null) {
          ActionHub.instance.emitEffect(OpenUrlEffect(uri));
        }
      }
    } else if (intent is PaperShareIntent) {
      if (contentId.isNotEmpty) {
        Share.share(contentId);
      } else {
        ActionHub.instance.emitEffect(
          ToastEffect((context) => AppLocalizations.of(context).share),
        );
      }
    } else if (intent is PaperPushIntent) {
      _pushedMap[contentId] = true;
      _pushStatuses[contentId] = ActionStatus.idle;
      _safeInvalidateSelf();
    } else if (intent is PaperCitationExportIntent) {
      ActionHub.instance.emitEffect(
        ToastEffect((context) => AppLocalizations.of(context)?.cite ?? 'Cite'),
      );
    } else if (intent is PaperOCRIntent) {
      _ocrStatuses[contentId] = ActionStatus.loading;
      _safeInvalidateSelf();

      Future.delayed(const Duration(seconds: 1), () {
        _ocrStatuses[contentId] = ActionStatus.idle;
        _safeInvalidateSelf();
        ActionHub.instance.emitEffect(
          ToastEffect((context) => AppLocalizations.of(context)?.ocr ?? 'OCR'),
        );
      });
    } else if (intent is PrecacheIntent) {
      _handlePaperPrecache(intent);
    } else if (intent is PaperTranslateAIIntent ||
        intent is PaperTranslateEngineIntent) {
      final String title =
          intent is PaperTranslateAIIntent
              ? intent.title
              : (intent as PaperTranslateEngineIntent).title;
      final String abstractText =
          intent is PaperTranslateAIIntent
              ? intent.abstractText
              : (intent as PaperTranslateEngineIntent).abstractText;
      final String keywords =
          intent is PaperTranslateAIIntent
              ? intent.keywords
              : (intent as PaperTranslateEngineIntent).keywords;
      final List<String> keywordsList =
          intent is PaperTranslateAIIntent
              ? intent.keywordsList
              : (intent as PaperTranslateEngineIntent).keywordsList;
      final String content =
          intent is PaperTranslateAIIntent
              ? intent.content
              : (intent as PaperTranslateEngineIntent).content;

      final bool currentActive = _aiTranslatedMap[contentId] ?? false;

      if (title.isEmpty &&
          abstractText.isEmpty &&
          keywords.isEmpty &&
          keywordsList.isEmpty &&
          content.isEmpty) {
        if (currentActive) {
          _aiTranslatedMap[contentId] = false;
          _safeInvalidateSelf();
          TemporaryCache.remove(CacheKeyToken.paperTranslation(contentId));
          ActionHub.instance.emitEffect(
            PaperTranslationEffect(contentId: contentId, isReset: true),
          );
          return;
        } else {
          _aiTranslatedMap[contentId] = true;
          _safeInvalidateSelf();
          ActionHub.instance.emitEffect(
            PaperTranslationEffect(contentId: contentId),
          );
          return;
        }
      }

      _aiTranslatedMap[contentId] = true;
      _safeInvalidateSelf();

      try {
        String? transTitle;
        String? transAbstract;
        List<String>? transKeywords;
        String? transContent;

        final futures = <Future<void>>[];

        if (title.isNotEmpty) {
          futures.add(
            _safeTranslate(title, targetLanguage: 'zh').then((val) {
              transTitle = val;
            }),
          );
        }
        if (abstractText.isNotEmpty) {
          futures.add(
            _safeTranslate(abstractText, targetLanguage: 'zh').then((val) {
              transAbstract = val;
            }),
          );
        }
        if (keywordsList.isNotEmpty) {
          futures.add(
            Future.wait(
              keywordsList.map(
                (kw) => _safeTranslate(kw, targetLanguage: 'zh'),
              ),
            ).then((val) {
              transKeywords = val;
            }),
          );
        } else if (keywords.isNotEmpty) {
          futures.add(
            _safeTranslate(keywords, targetLanguage: 'zh').then((val) {
              transKeywords = [val];
            }),
          );
        }
        if (content.isNotEmpty) {
          futures.add(
            _safeTranslate(content, targetLanguage: 'zh').then((val) {
              transContent = val;
            }),
          );
        }

        await Future.wait(futures);

        final resultObj = PaperTranslationResult(
          title: transTitle,
          abstractText: transAbstract,
          keywords: transKeywords,
          content: transContent,
        );

        final translated = jsonEncode(resultObj.toJson());

        TemporaryCache.setText(CacheKeyToken.paperTranslation(contentId), translated);
        ActionHub.instance.emitEffect(
          PaperTranslationEffect(
            contentId: contentId,
            title: transTitle,
            abstractText: transAbstract,
            keywords: transKeywords,
            translatedText: translated,
          ),
        );
      } catch (e) {
        debugPrint('⚠️ [PaperActions] 翻译异常: $e');
        _aiTranslatedMap[contentId] = false;
        _safeInvalidateSelf();
        TemporaryCache.remove(CacheKeyToken.paperTranslation(contentId));
        ActionHub.instance.emitEffect(
          PaperTranslationEffect(contentId: contentId, isReset: true, error: e),
        );
      }
    }
  }

  void _handlePaperPrecache(PrecacheIntent intent) async {
    final contentId = intent.contentId;
    if (contentId.isEmpty) return;

    if (intent.entity != null) {
      TemporaryCache.setEntity(
        CacheKeyToken.mediaPrecache(contentId),
        intent.entity!,
      );
    }

    if (TemporaryCache.getText(CacheKeyToken.paperTranslation(contentId)) != null) {
      return;
    }

    final entity = intent.entity;
    final String title = entity?.title ?? '';
    final String abstractText = entity?.description ?? '';
    final List<String> rawKwList = entity?.tags ?? const [];
    final String content = entity?.contentUrl ?? '';

    try {
      String? transTitle;
      String? transAbstract;
      List<String>? transKeywords;
      String? transContent;

      final futures = <Future<void>>[];

      if (title.isNotEmpty) {
        futures.add(
          _safeTranslate(title, targetLanguage: 'zh').then((val) {
            transTitle = val;
          }),
        );
      }
      if (abstractText.isNotEmpty) {
        futures.add(
          _safeTranslate(abstractText, targetLanguage: 'zh').then((val) {
            transAbstract = val;
          }),
        );
      }
      if (rawKwList.isNotEmpty) {
        futures.add(
          Future.wait(
            rawKwList.map((kw) => _safeTranslate(kw, targetLanguage: 'zh')),
          ).then((val) {
            transKeywords = val;
          }),
        );
      }
      if (content.isNotEmpty) {
        futures.add(
          _safeTranslate(content, targetLanguage: 'zh').then((val) {
            transContent = val;
          }),
        );
      }

      if (futures.isEmpty) return;

      await Future.wait(futures);

      final resultObj = PaperTranslationResult(
        title: transTitle,
        abstractText: transAbstract,
        keywords: transKeywords,
        content: transContent,
      );

      final translated = jsonEncode(resultObj.toJson());

      TemporaryCache.setText(CacheKeyToken.paperTranslation(contentId), translated);
      _aiTranslatedMap[contentId] = true;
      _safeInvalidateSelf();
      ActionHub.instance.emitEffect(
        PaperTranslationEffect(
          contentId: contentId,
          title: transTitle,
          abstractText: transAbstract,
          keywords: transKeywords,
          translatedText: translated,
        ),
      );
    } catch (e) {
      debugPrint('⚠️ [PaperActions] 静默预翻译异常 ($contentId): $e');
    }
  }
}
