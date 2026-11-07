import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';
import 'package:pyro_action_hub/pyro_action_hub.dart';
import 'package:pyro_action_protocol/pyro_action_protocol.dart';
import 'package:pyro_api_translate/pyro_api_translate.dart';
import 'package:pyro_web_translator/pyro_web_translator.dart';
import 'package:pyro_dictionary/pyro_dictionary.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'l10n/generated/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_browser_engine/pyro_browser_engine.dart';

import 'browser_action_provider.dart';
import 'widgets/browser_widgets.dart';

/// 全功能应用内嵌入式网页浏览器 (AppWebBrowserScreen)
/// 严格遵循解耦规范下沉至 [pyro_render_hub]，复用 [ActionHub]、[DictionaryService] 与 [TranslationService] 底层资产。
class AppWebBrowserScreen extends ConsumerStatefulWidget {
  final String initialUrl;
  final String? title;
  final Map<String, dynamic>? params;

  const AppWebBrowserScreen({
    super.key,
    required this.initialUrl,
    this.title,
    this.params,
  });

  /// 通用工厂与直接跳转唤起
  static void open(
    BuildContext context, {
    required String url,
    String? title,
    Map<String, dynamic>? params,
  }) {
    final sanitizedUrl = UrlUtils.sanitizeUrl(url);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => AppWebBrowserScreen(
          initialUrl: sanitizedUrl,
          title: title,
          params: params,
        ),
      ),
    );
  }

  @override
  ConsumerState<AppWebBrowserScreen> createState() => _AppWebBrowserScreenState();
}

class _AppWebBrowserScreenState extends ConsumerState<AppWebBrowserScreen> {
  late final WebViewController _controller;
  late String _currentUrl;
  late String _currentTitle;
  final ValueNotifier<double> _loadingProgressNotifier = ValueNotifier<double>(0.0);
  final ValueNotifier<bool> _isLoadingNotifier = ValueNotifier<bool>(true);
  bool _canGoBack = false;
  bool _canGoForward = false;
  bool _isTranslating = false;

  StreamSubscription<ActionEffect>? _effectSub;

  @override
  void initState() {
    super.initState();
    _currentUrl = UrlUtils.sanitizeUrl(widget.initialUrl);
    _currentTitle = widget.title ?? '';
    
    // 注册动作提供者（如果尚未注册）
    if (!ActionHub.instance.registeredContentTypes.contains(MediaTypeToken.browser)) {
      registerActionProvider(MediaTypeToken.browser, BrowserActions());
    }

    _effectSub = ActionHub.instance.effectStream.listen((effect) {
      if (effect is BrowserActionEvent) {
        switch (effect.action) {
          case BrowserActionType.dictionary:
            _handleDictionaryAction();
          case BrowserActionType.translateDom:
          case BrowserActionType.translate:
            _translateFullPageDom();
          case BrowserActionType.translateExtract:
            _extractAndTranslatePageText();
          case BrowserActionType.aiQa:
            _handleAiQaAction();
          case BrowserActionType.share:
            Share.share(_currentUrl);
        }
      }
    });

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            _loadingProgressNotifier.value = progress / 100.0;
            _isLoadingNotifier.value = progress < 100;
          },
          onPageStarted: (String url) {
            _isLoadingNotifier.value = true;
            if (mounted && _currentUrl != url) {
              setState(() {
                _currentUrl = url;
              });
            }
          },
          onPageFinished: (String url) async {
            _isLoadingNotifier.value = false;
            if (mounted) {
              final pageTitle = await _controller.getTitle() ?? '';
              final canBack = await _controller.canGoBack();
              final canForward = await _controller.canGoForward();
              
              // 注入纯 Dart 层的 JS 脚本
              _controller.runJavaScript(BrowserJsBridge.selectionListenerScript);
              _controller.runJavaScript(BrowserJsBridge.extractArticleScript);
              
              final isSmartMenu = ref.read(browserEngineProvider).useCustomSelectionMenu;
              if (isSmartMenu) {
                _controller.runJavaScript(BrowserJsBridge.suppressContextMenuScript);
              }

              setState(() {
                _currentUrl = url;
                if (pageTitle.isNotEmpty) {
                  _currentTitle = pageTitle;
                }
                _canGoBack = canBack;
                _canGoForward = canForward;
              });
            }
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('🔥 [AppWebBrowser] WebResourceError: ${error.description}');
          },
        ))
      ..addJavaScriptChannel(
        'SelectionBridge',
        onMessageReceived: (JavaScriptMessage message) {
          if (mounted) {
            ref.read(browserEngineProvider.notifier).updateSelectedText(message.message);
            // 如果选中了文字，可以自动弹出悬浮查词栏（后续可通过 Provider 状态在 UI 中呈现）
            debugPrint('🔥 [BrowserEngine] 用户选中文字: ${message.message}');
          }
        },
      );

    final uri = Uri.tryParse(_currentUrl);
    if (uri != null) {
      _controller.loadRequest(uri);
    }
  }

  void _handleDictionaryAction() async {
    final selectedText = ref.read(browserEngineProvider).selectedText;
    if (selectedText.isNotEmpty) {
      _lookupWord(selectedText);
    } else {
      try {
        final Object rawText = await _controller.runJavaScriptReturningResult(
          BrowserJsBridge.extractArticleScript,
        );
        String text = rawText.toString();
        if (text.startsWith('"') && text.endsWith('"')) {
          try {
            text = jsonDecode(text) as String;
          } catch (_) {
            text = text.substring(1, text.length - 1);
          }
        }
        final queryWord = _currentTitle.isNotEmpty ? _currentTitle.split(' ').first : (text.isNotEmpty ? text.split(' ').first : '');
        if (queryWord.isNotEmpty && queryWord.length > 2) {
          _lookupWord(queryWord);
        } else {
          _showDictionarySearchDialog();
        }
      } catch (_) {
        if (_currentTitle.isNotEmpty) {
          _lookupWord(_currentTitle.split(' ').first);
        } else {
          _showDictionarySearchDialog();
        }
      }
    }
  }

  void _handleAiQaAction() {
    final selectedText = ref.read(browserEngineProvider).selectedText;
    final contextText = selectedText.isNotEmpty ? selectedText : '分析此网页概括核心要点: $_currentTitle';
    ActionHub.instance.dispatchIntent(
      'web',
      SelectionAiIntent(_currentUrl, contextText),
    );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(ActionLocalizerScope.translate(context, id: 'demandSentToAi', defaultText: 'Demand Sent to AI'))),
    );
  }

  void _shareCurrentPage() {
    final titleToShare = _currentTitle.isNotEmpty ? _currentTitle : '网页分享';
    Share.share('$titleToShare\n$_currentUrl');
  }

  void _copyLinkToClipboard() {
    Clipboard.setData(ClipboardData(text: _currentUrl));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(ActionLocalizerScope.translate(context, id: 'urlCopiedToClipboard', defaultText: 'URL Copied to Clipboard')),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _openInExternalBrowser() async {
    final uri = Uri.tryParse(_currentUrl);
    if (uri != null && await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(ActionLocalizerScope.translate(context, id: 'cannotOpenExternalUrl', defaultText: 'Cannot Open External URL')),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }



  List<dynamic> _parseJsonList(Object rawJson) {
    dynamic decoded = rawJson;
    int maxDepth = 4;
    while (maxDepth > 0 && decoded is String) {
      maxDepth--;
      var str = decoded.trim();
      if (str.startsWith('"') && str.endsWith('"') && str.length > 2) {
        try {
          decoded = jsonDecode(str);
          continue;
        } catch (_) {
          str = str.substring(1, str.length - 1);
        }
      }
      try {
        decoded = jsonDecode(str);
      } catch (_) {
        break;
      }
    }
    if (decoded is List) {
      return decoded;
    }
    return [];
  }

  /// 沉浸式网页 DOM 节点双语对照翻译
  Future<void> _translateFullPageDom() async {
    if (_isTranslating) return;
    setState(() => _isTranslating = true);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
              ),
              const SizedBox(width: 12),
              Text(ActionLocalizerScope.translate(context, id: 'scanningWebTextNodes', defaultText: 'Scanning web text nodes...')),
            ],
          ),
          duration: const Duration(seconds: 2),
        ),
      );
    }

    // 先给 UI 线程一帧回绘制缓冲，防止跨进程 JS 挂起导致界面感觉“未响应”
    await Future.delayed(const Duration(milliseconds: 100));

    try {
      final Object rawJson = await _controller.runJavaScriptReturningResult(
        WebTranslationEngine.extractDomNodesScript,
      );

      final List<dynamic> rawList = _parseJsonList(rawJson);
      final List<String> texts = rawList.map((e) => e['text'].toString()).toList();
      final List<String> ids = rawList.map((e) => e['id'].toString()).toList();

      if (texts.isEmpty) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(ActionLocalizerScope.translate(context, id: 'noTranslatableWebNodesFound', defaultText: 'No translatable text nodes found'))),
          );
        }
        return;
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(ActionLocalizerScope.translate(context, id: 'scannedParagraphsTranslating', defaultText: 'Translating scanned paragraphs...')),
            duration: const Duration(seconds: 3),
          ),
        );
      }

      final targetLang = Localizations.localeOf(context).languageCode;

      final translatedList = await WebTranslationEngine.instance.translateBlocks(
        texts,
        targetLanguage: targetLang,
      );

      final Map<String, String> transMap = {};
      for (int i = 0; i < ids.length; i++) {
        if (i < translatedList.length && translatedList[i].isNotEmpty) {
          transMap[ids[i]] = translatedList[i];
        }
      }

      final applyScript = WebTranslationEngine.generateApplyDomTranslationScript(transMap);
      await _controller.runJavaScript(applyScript);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(ActionLocalizerScope.translate(context, id: 'bilingualTranslationComplete', defaultText: 'Bilingual translation complete'))),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(ActionLocalizerScope.translate(context, id: 'failedToTranslateWebPage', defaultText: 'Failed to translate web page: $e'))),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isTranslating = false);
      }
    }
  }

  /// 模式 B: 智能提取网页正文并通过 [TranslationService] 翻译
  Future<void> _extractAndTranslatePageText() async {
    ref.read(browserEngineProvider.notifier).startExtraction();
    setState(() => _isTranslating = true);
    try {
      final Object rawText = await _controller.runJavaScriptReturningResult(
        BrowserJsBridge.extractArticleScript,
      );

      String bodyText = rawText.toString();
      if (bodyText.startsWith('"') && bodyText.endsWith('"')) {
        try {
          bodyText = jsonDecode(bodyText) as String;
        } catch (_) {
          bodyText = bodyText.substring(1, bodyText.length - 1);
        }
      }

      if (bodyText.length > 2000) {
        bodyText = bodyText.substring(0, 2000); // 截取前 2000 字符
      }

      if (bodyText.trim().isEmpty && _currentTitle.isNotEmpty) {
        bodyText = _currentTitle;
      }

      if (bodyText.trim().isEmpty) {
        if (mounted) {
          ref.read(browserEngineProvider.notifier).extractionFailed('未能提取到正文');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(ActionLocalizerScope.translate(context, id: 'failedToExtractWebText', defaultText: 'Failed to extract web text'))),
          );
        }
        return;
      }
      
      ref.read(browserEngineProvider.notifier).completeExtraction(bodyText);

      final targetLang = Localizations.localeOf(context).languageCode;

      final translated = await TranslationService.instance.translate(
        bodyText,
        targetLanguage: targetLang,
      );

      if (mounted) {
        ref.read(browserEngineProvider.notifier).setTranslationResult(translated);
        _showTranslationResultModal(_currentTitle, translated);
      }
    } catch (e) {
      if (mounted) {
        ref.read(browserEngineProvider.notifier).extractionFailed(e.toString());
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(ActionLocalizerScope.translate(context, id: 'webPageTranslationError', defaultText: 'Web page translation error: $e'))),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isTranslating = false);
      }
    }
  }

  /// 展示 AI 翻译结果弹窗
  void _showTranslationResultModal(String title, String translatedText) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerHigh,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.65,
        maxChildSize: 0.9,
        minChildSize: 0.4,
        expand: false,
        builder: (_, scrollController) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: ListView(
            controller: scrollController,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.g_translate_rounded, color: Color(0xFF1DA1F2)),
                      SizedBox(width: 8),
                      Text(
                        '网页核心译文',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.close_rounded),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const Divider(height: 20),
              if (title.isNotEmpty) ...[
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
              ],
              SelectableText(
                translatedText,
                style: const TextStyle(fontSize: 14, height: 1.6),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 唤起词典查词弹窗
  void _showDictionarySearchDialog() {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            children: [
              const Icon(Icons.menu_book_rounded, color: Color(0xFF1DA1F2)),
              const SizedBox(width: 8),
              Text(ActionLocalizerScope.translate(context, id: 'webDictionarySearchTitle', defaultText: 'Web Dictionary Search')),
            ],
          ),
          content: TextField(
            controller: controller,
            autofocus: true,
            decoration: InputDecoration(
              hintText: ActionLocalizerScope.translate(context, id: 'inputLookupHint', defaultText: 'Enter word to lookup...'),
              border: const OutlineInputBorder(),
            ),
            onSubmitted: (word) {
              Navigator.pop(context);
              if (word.trim().isNotEmpty) {
                _lookupWord(word.trim());
              }
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(ActionLocalizerScope.translate(context, id: 'cancel', defaultText: 'Cancel')),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                if (controller.text.trim().isNotEmpty) {
                  _lookupWord(controller.text.trim());
                }
              },
              child: Text(ActionLocalizerScope.translate(context, id: 'search', defaultText: 'Search')),
            ),
          ],
        );
      },
    );
  }

  /// 执行词典查询并展示既有 [DictionaryResultView]
  void _lookupWord(String word) async {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          child: Scaffold(
            appBar: AppBar(
              title: Text(ActionLocalizerScope.translate(context, id: 'dictionaryLookupTitle', defaultText: 'Dictionary Lookup: $word')),
              leading: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            body: FutureBuilder<DictResult>(
              future: DictionaryService().lookup(word, targetLanguage: 'zh'),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasError || !snapshot.hasData) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(ActionLocalizerScope.translate(context, id: 'lookupFailed', defaultText: 'Lookup failed: ${snapshot.error ?? "No result"}')),
                    ),
                  );
                }
                return DictionaryResultView(
                  result: snapshot.data!,
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _effectSub?.cancel();
    _loadingProgressNotifier.dispose();
    _isLoadingNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hostDomain = Uri.tryParse(_currentUrl)?.host ?? '';

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close_rounded, size: 24),
          tooltip: 'Close',
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              _currentTitle.isNotEmpty ? _currentTitle : 'Web View',
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            if (hostDomain.isNotEmpty) ...[
              Row(
                children: [
                  const Icon(Icons.lock_outline_rounded, size: 10, color: Colors.green),
                  const SizedBox(width: 3),
                  Expanded(
                    child: Text(
                      hostDomain,
                      style: TextStyle(
                        fontSize: 10,
                        color: theme.textTheme.bodySmall?.color?.withValues(alpha: 0.7),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.chevron_left_rounded, size: 26),
            tooltip: 'Back',
            onPressed: _canGoBack ? () => _controller.goBack() : null,
          ),
          IconButton(
            icon: const Icon(Icons.chevron_right_rounded, size: 26),
            tooltip: 'Forward',
            onPressed: _canGoForward ? () => _controller.goForward() : null,
          ),
          IconButton(
            icon: const Icon(Icons.refresh_rounded, size: 22),
            tooltip: 'Refresh',
            onPressed: () => _controller.reload(),
          ),
          IconButton(
            icon: const Icon(Icons.share_outlined, size: 20),
            tooltip: 'Share',
            onPressed: _shareCurrentPage,
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert_rounded, size: 22),
            onSelected: (value) {
              switch (value) {
                case 'copy':
                  _copyLinkToClipboard();
                  break;
                case 'external':
                  _openInExternalBrowser();
                  break;
                case 'translate_dom':
                  _translateFullPageDom();
                  break;
                case 'translate_extract':
                  _extractAndTranslatePageText();
                  break;
                case 'ai_qa':
                  _handleAiQaAction();
                  break;
                case 'toggle_selection_menu':
                  ref.read(browserEngineProvider.notifier).toggleSelectionMenuMode();
                  final newMode = ref.read(browserEngineProvider).useCustomSelectionMenu;
                  if (newMode) {
                    _controller.runJavaScript(BrowserJsBridge.suppressContextMenuScript);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(ActionLocalizerScope.translate(context, id: 'smartSelectionEnabled', defaultText: 'Smart Selection Enabled'))),
                    );
                  } else {
                    _controller.runJavaScript(BrowserJsBridge.allowContextMenuScript);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(ActionLocalizerScope.translate(context, id: 'systemMenuRestored', defaultText: 'System Menu Restored'))),
                    );
                  }
                  break;
              }
            },
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  value: 'copy',
                  child: Row(
                    children: [
                      const Icon(Icons.copy_rounded, size: 18),
                      const SizedBox(width: 10),
                      Text(AppLocalizations.of(context)?.copyLink ?? 'Copy Link'),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 'external',
                  child: Row(
                    children: [
                      const Icon(Icons.open_in_browser_rounded, size: 18),
                      const SizedBox(width: 10),
                      Text(AppLocalizations.of(context)?.openInSystemBrowser ?? 'Open in Browser'),
                    ],
                  ),
                ),
                const PopupMenuDivider(),
                PopupMenuItem(
                  value: 'toggle_selection_menu',
                  child: Consumer(
                    builder: (context, ref, _) {
                      final isSmart = ref.watch(browserEngineProvider).useCustomSelectionMenu;
                      return Row(
                        children: [
                          Icon(
                            isSmart ? Icons.touch_app_rounded : Icons.crop_free_rounded,
                            size: 18,
                            color: const Color(0xFF1DA1F2),
                          ),
                          const SizedBox(width: 10),
                          Text(isSmart ? ActionId.read.name : ActionId.read.name),
                        ],
                      );
                    },
                  ),
                ),
                PopupMenuItem(
                  value: 'translate_dom',
                  child: Row(
                    children: [
                      const Icon(Icons.g_translate_rounded, size: 18, color: Color(0xFF1DA1F2)),
                      const SizedBox(width: 10),
                      Text(ActionId.browserTranslateDom.name),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 'translate_extract',
                  child: Row(
                    children: [
                      const Icon(Icons.article_outlined, size: 18),
                      const SizedBox(width: 10),
                      Text(ActionId.browserTranslateExtract.name),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 'ai_qa',
                  child: Row(
                    children: [
                      const Icon(Icons.smart_toy_outlined, size: 18, color: Color(0xFF1DA1F2)),
                      const SizedBox(width: 10),
                      Text(ActionId.browserAiQa.name),
                    ],
                  ),
                ),
              ];
            },
          ),
        ],
      ),
      body: Column(
        children: [
          ValueListenableBuilder<bool>(
            valueListenable: _isLoadingNotifier,
            builder: (context, isLoading, _) {
              if (!isLoading && !_isTranslating) {
                return const SizedBox(height: 3);
              }
              return ValueListenableBuilder<double>(
                valueListenable: _loadingProgressNotifier,
                builder: (context, progress, _) {
                  return LinearProgressIndicator(
                    value: isLoading ? (progress > 0 ? progress : null) : null,
                    minHeight: 3,
                    color: theme.colorScheme.primary,
                    backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.15),
                  );
                },
              );
            },
          ),
          Expanded(
            child: Stack(
              children: [
                WebViewWidget(
                  controller: _controller,
                  gestureRecognizers: {
                    Factory<OneSequenceGestureRecognizer>(
                      () => EagerGestureRecognizer(),
                    ),
                  },
                ),
                Consumer(
                  builder: (context, ref, _) {
                    final engineState = ref.watch(browserEngineProvider);
                    if (!engineState.useCustomSelectionMenu || engineState.selectedText.isEmpty) {
                      return const SizedBox.shrink();
                    }
                    final selectedText = engineState.selectedText;
                    return BrowserSelectionOverlay(
                      selectedText: selectedText,
                      onLookup: () => _lookupWord(selectedText),
                      onTranslate: () {
                        ActionHub.instance.dispatchIntent(
                          MediaTypeToken.browser,
                          SelectionTranslateIntent(_currentUrl, selectedText),
                        );
                      },
                      onClose: () => ref.read(browserEngineProvider.notifier).clearSelection(),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BrowserBottomActionBar(
        actionStream: ActionHub.instance.watchActions(MediaTypeToken.browser, _currentUrl),
        onClose: () => Navigator.of(context).pop(),
      ),
    );
  }
}
