import 'dart:async';
import 'dart:convert';
import 'package:pyro_api_translate/pyro_api_translate.dart';

/// 网页专属并发与批量翻译引擎（完全独立的纯能力微包，绝对零依赖 pyro_render_hub）
class WebTranslationEngine {
  static final WebTranslationEngine instance = WebTranslationEngine();

  /// 批量对网页文本块 (Paragraphs/DOM Blocks) 进行并发翻译
  Future<List<String>> translateBlocks(
    List<String> textBlocks, {
    required String targetLanguage,
    String sourceLanguage = 'auto',
    int batchSize = 5,
  }) async {
    if (textBlocks.isEmpty) return [];

    final List<String> results = List.filled(textBlocks.length, '');

    for (int i = 0; i < textBlocks.length; i += batchSize) {
      final end = (i + batchSize < textBlocks.length) ? i + batchSize : textBlocks.length;
      final chunkIndices = List.generate(end - i, (index) => i + index);

      final chunkFutures = chunkIndices.map((idx) async {
        final block = textBlocks[idx].trim();
        if (block.isEmpty) {
          results[idx] = '';
          return;
        }
        try {
          final translated = await TranslationService.instance.translate(
            block,
            targetLanguage: targetLanguage,
            sourceLanguage: sourceLanguage,
          );
          results[idx] = translated;
        } catch (e, stack) {
          print('⚠️ [WebTranslationEngine] Block translation failed: $e\n$stack');
          results[idx] = block;
        }
      });

      await Future.wait(chunkFutures);
      await Future.delayed(const Duration(milliseconds: 20));
    }

    return results;
  }

  /// 基于 TreeWalker 遍历的全网页可见文本块精准提炼脚本
  static const String extractDomNodesScript = '''
    (function() {
      var nodes = [];
      var index = 0;
      var skipTags = ['SCRIPT', 'STYLE', 'NOSCRIPT', 'SVG', 'CODE', 'IFRAME', 'CANVAS', 'NAV', 'FOOTER', 'HEADER', 'BUTTON', 'INPUT', 'TEXTAREA', 'FORM', 'OPTION'];

      var root = document.body || document.documentElement;
      var walker = document.createTreeWalker(
        root,
        NodeFilter.SHOW_TEXT,
        {
          acceptNode: function(node) {
            if (!node || !node.nodeValue) return NodeFilter.FILTER_REJECT;
            var parent = node.parentElement;
            if (!parent) return NodeFilter.FILTER_REJECT;
            if (skipTags.indexOf(parent.tagName) !== -1) return NodeFilter.FILTER_REJECT;
            if (parent.closest && parent.closest('nav, footer, header, button, [aria-hidden="true"]')) {
              return NodeFilter.FILTER_REJECT;
            }
            var txt = node.nodeValue.trim();
            if (txt.length < 3) return NodeFilter.FILTER_SKIP;
            return NodeFilter.FILTER_ACCEPT;
          }
        },
        false
      );

      var blockContainers = [];
      var blockSet = new Set();

      var currentNode;
      while ((currentNode = walker.nextNode())) {
        var parent = currentNode.parentElement;
        var block = parent;
        while (block && block !== root) {
          var tag = block.tagName ? block.tagName.toUpperCase() : '';
          var display = '';
          try {
            display = window.getComputedStyle(block).display;
          } catch(e) {}
          
          if (['P', 'H1', 'H2', 'H3', 'H4', 'H5', 'H6', 'LI', 'BLOCKQUOTE', 'TD', 'DT', 'DD', 'ARTICLE', 'SECTION'].indexOf(tag) !== -1 || display === 'block' || display === 'flex' || display === 'grid') {
            break;
          }
          block = block.parentElement;
        }
        if (!block) block = parent;

        if (!blockSet.has(block)) {
          blockSet.add(block);
          blockContainers.push(block);
        }
      }

      for (var i = 0; i < blockContainers.length; i++) {
        var el = blockContainers[i];
        if (el.getAttribute('data-pyro-id')) continue;
        if (el.closest && el.closest('[data-pyro-id]')) continue;

        var text = el.textContent ? el.textContent.trim() : '';
        if (text.length >= 8 && text.length < 4000) {
          el.setAttribute('data-pyro-id', index.toString());
          nodes.push({ id: index.toString(), text: text });
          index++;
        }
      }

      return JSON.stringify(nodes);
    })();
  ''';

  /// 将译文双语对照内嵌回网页 DOM 节点的 JS 脚本生成器
  static String generateApplyDomTranslationScript(Map<String, String> translations) {
    final jsonStr = jsonEncode(translations);
    return '''
      (function() {
        var map = $jsonStr;
        for (var id in map) {
          if (!map.hasOwnProperty(id)) continue;
          var translatedText = map[id];
          var el = document.querySelector('[data-pyro-id="' + id + '"]');
          if (el && !el.getAttribute('data-pyro-translated')) {
            el.setAttribute('data-pyro-translated', 'true');
            var transDiv = document.createElement('div');
            transDiv.className = 'pyro-bilingual-trans';
            transDiv.style.color = '#1DA1F2';
            transDiv.style.fontSize = '0.92em';
            transDiv.style.marginTop = '4px';
            transDiv.style.marginBottom = '8px';
            transDiv.style.lineHeight = '1.5';
            transDiv.style.fontFamily = 'system-ui, -apple-system, sans-serif';
            transDiv.innerText = translatedText;
            el.appendChild(transDiv);
          }
        }
      })();
    ''';
  }
}
