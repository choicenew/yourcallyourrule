// 协调管理和WebView服务
class PluginInvokerService {
  final PluginManagerService _manager;
  final PluginWebViewService _webview;
  
  Future<void> loadEnabledPlugins() async {
    final plugins = await _manager.getAllEnabled();
    for (final plugin in plugins) {
      await _webview.evaluateJavaScript(plugin.script);
    }
  }
  
  // 业务调用入口...
}