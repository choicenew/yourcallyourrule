/// 纯 Dart 层: 浏览器 JS 注入桥接与提取引擎
/// 负责处理划词监听、获取当前正文内容的脚本
class BrowserJsBridge {
  /// 用于获取网页核心正文的 JS 脚本 (DOM 智能提取算法简化版)
  static const String extractArticleScript = '''
    (function() {
      // 优先寻找 article 标签，或者主要内容区，退而求其次使用 body
      var article = document.querySelector('article') || document.querySelector('main') || document.querySelector('.content');
      var text = article ? article.innerText : document.body.innerText;
      return text || '';
    })();
  ''';

  /// 用于注入到 WebView 监听用户文本选中的脚本
  static const String selectionListenerScript = '''
    (function() {
      document.addEventListener('selectionchange', function() {
        var selection = window.getSelection();
        var selectedText = selection.toString().trim();
        // 只有当选中文字长度大于0且小于500（避免全选发送大量无用数据）时才发送
        if (selectedText.length > 0 && selectedText.length < 500) {
          if (window.SelectionBridge) {
             window.SelectionBridge.postMessage(selectedText);
          }
        } else if (selectedText.length === 0) {
          if (window.SelectionBridge) {
             window.SelectionBridge.postMessage('');
          }
        }
      });
    })();
  ''';

  /// 屏蔽系统默认右键/长按菜单的 JS 脚本
  static const String suppressContextMenuScript = '''
    (function() {
      window.__pyro_suppress_menu = function(e) { e.preventDefault(); };
      document.addEventListener('contextmenu', window.__pyro_suppress_menu, true);
    })();
  ''';

  /// 恢复系统默认右键/长按菜单的 JS 脚本
  static const String allowContextMenuScript = '''
    (function() {
      if (window.__pyro_suppress_menu) {
        document.removeEventListener('contextmenu', window.__pyro_suppress_menu, true);
      }
    })();
  ''';
}
