import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

/// 一个纯粹的UI组件，用于显示WebView和处理URL加载。
///
/// 支持两种模式:
/// 1. **手动模式**: 提供一个地址栏，让用户可以手动输入并加载URL。
/// 2. **参数模式**: 接收一个初始URL，并自动加载。
class PluginUrlWebviewPage extends StatefulWidget {
  /// 初始URL，如果提供，页面将直接加载此URL。
  final String? initialUrl;

  /// 需要添加到请求中的头信息。
  final Map<String, String>? headers;

  const PluginUrlWebviewPage({
    Key? key,
    this.initialUrl,
    this.headers,
  }) : super(key: key);

  @override
  State<PluginUrlWebviewPage> createState() => _PluginUrlWebviewPageState();
}

class _PluginUrlWebviewPageState extends State<PluginUrlWebviewPage> {
  final TextEditingController _urlController = TextEditingController();
  InAppWebViewController? _webViewController;
  PullToRefreshController? _pullToRefreshController;
  double _progress = 0;
  String _currentUrl = '';

  @override
  void initState() {
    super.initState();

    if (widget.initialUrl != null) {
      _currentUrl = widget.initialUrl!;
      _urlController.text = _currentUrl;
    }

    _pullToRefreshController = PullToRefreshController(
      onRefresh: () async {
        if (_webViewController != null) {
          _webViewController!.reload();
        }
      },
    );
  }

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  void _loadUrl(String url) {
    if (_webViewController != null) {
      final uri = Uri.tryParse(url);
      if (uri != null && uri.isAbsolute) {
        _webViewController!.loadUrl(
          urlRequest: URLRequest(
            url: WebUri(url),
            headers: widget.headers,
          ),
        );
      } else {
        // Handle invalid URL
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid URL')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WebView Tester'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              if (_webViewController != null) {
                _webViewController!.reload();
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildAddressBar(),
          if (_progress < 1.0)
            LinearProgressIndicator(value: _progress),
          Expanded(
            child: _buildWebView(),
          ),
        ],
      ),
    );
  }

  Widget _buildAddressBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: _urlController,
        decoration: InputDecoration(
          hintText: 'Enter URL',
          suffixIcon: IconButton(
            icon: const Icon(Icons.arrow_forward),
            onPressed: () => _loadUrl(_urlController.text),
          ),
        ),
        onSubmitted: (url) => _loadUrl(url),
      ),
    );
  }

  Widget _buildWebView() {
    return InAppWebView(
      initialUrlRequest: widget.initialUrl != null
          ? URLRequest(
              url: WebUri(widget.initialUrl!),
              headers: widget.headers,
            )
          : null,
      initialSettings: InAppWebViewSettings(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
        javaScriptEnabled: true,
        allowFileAccessFromFileURLs: true,
        allowUniversalAccessFromFileURLs: true,
      ),
      pullToRefreshController: _pullToRefreshController,
      onWebViewCreated: (controller) {
        _webViewController = controller;
      },
      onLoadStart: (controller, url) {
        setState(() {
          _currentUrl = url.toString();
          _urlController.text = _currentUrl;
        });
      },
      onLoadStop: (controller, url) async {
        _pullToRefreshController?.endRefreshing();
        setState(() {
          _currentUrl = url.toString();
          _urlController.text = _currentUrl;
        });
      },
      onProgressChanged: (controller, progress) {
        setState(() {
          _progress = progress / 100;
        });
      },
      onReceivedHttpError: (controller, request, errorResponse) {
        _pullToRefreshController?.endRefreshing();
      },
      onLoadError: (controller, url, code, message) {
        _pullToRefreshController?.endRefreshing();
      },
      shouldOverrideUrlLoading: (controller, navigationAction) async {
        // Always allow navigation
        return NavigationActionPolicy.ALLOW;
      },
    );
  }
}