
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/entities/plugin/plugin_entry.dart';
import 'package:yourcallyourrule/features/plugin/providers/plugin_url_webview_service_provider.dart';
import 'package:yourcallyourrule/features/plugin/services/plugin_url_webview_service.dart';

enum PageState { initial, loading, showPhoneNumberInput, showWebView, error, manualInput }

class PluginUrlWebViewPage extends ConsumerStatefulWidget {
  final PluginEntry? plugin;

  const PluginUrlWebViewPage({super.key, this.plugin});

  @override
  ConsumerState<PluginUrlWebViewPage> createState() => _PluginUrlWebViewPageState();
}

class _PluginUrlWebViewPageState extends ConsumerState<PluginUrlWebViewPage> {
  PageState _pageState = PageState.initial;
  String? _urlToLoad;
  Map<String, String> _headers = {};
  String? _errorMessage;

  // For switching between static and dynamic modes
  String? _staticUrl;
  Map<String, String> _staticHeaders = {};

  final _phoneNumberController = TextEditingController();
  final _urlController = TextEditingController();
  InAppWebViewController? _webViewController;
  PullToRefreshController? _pullToRefreshController;
  double _progress = 0;
  bool _canGoBack = false;
  bool _canGoForward = false;

  @override
  void initState() {
    super.initState();
    _initialize();

    _pullToRefreshController = PullToRefreshController(
      onRefresh: () async {
        _webViewController?.reload();
      },
    );
  }

  @override
  void dispose() {
    _phoneNumberController.dispose();
    _urlController.dispose();
    super.dispose();
  }

  Future<void> _initialize() async {
    if (widget.plugin == null) {
      if (!mounted) return;
      setState(() {
        _pageState = PageState.manualInput;
        _urlToLoad = 'about:blank';
        _urlController.text = '';
      });
      return;
    }

    if (!mounted) return;
    setState(() {
      _pageState = PageState.loading;
      _errorMessage = null;
    });

    final service = ref.read(pluginUrlWebViewServiceProvider);
    try {
      final staticResult = await service.extractUrlFromScript(widget.plugin!);
      if (!mounted) return;

      if (staticResult != null && staticResult['targetSearchUrl'] != null) {
        setState(() {
          _staticUrl = staticResult['targetSearchUrl'];
          _urlToLoad = _staticUrl;
          final headersMap = staticResult['headers'];
          if (headersMap is Map) {
            _staticHeaders = headersMap.map((key, value) => MapEntry(key.toString(), value.toString()));
          } else {
            _staticHeaders = {};
          }
          _headers = _staticHeaders;
          _pageState = PageState.showWebView;
          _urlController.text = _urlToLoad!;
        });
      } else {
        setState(() {
          _pageState = PageState.showPhoneNumberInput;
        });
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _pageState = PageState.showPhoneNumberInput;
        _errorMessage = "Static extraction failed: $e";
      });
    }
  }

  Future<void> _generateDynamicUrl() async {
    if (_phoneNumberController.text.isEmpty) {
      if (!mounted) return;
      setState(() {
        _errorMessage = "Phone number cannot be empty.";
        _pageState = PageState.showPhoneNumberInput;
      });
      return;
    }

    if (!mounted) return;
    setState(() {
      _pageState = PageState.loading;
      _errorMessage = null;
    });

    final service = ref.read(pluginUrlWebViewServiceProvider);
    try {
      final generatedUrl = await service.generateUrlFromPhoneNumber(
        widget.plugin!,
        _phoneNumberController.text,
      );
      if (!mounted) return;

      setState(() {
        _urlToLoad = generatedUrl;
        _headers = {}; // Dynamic URL has no special headers
        _pageState = PageState.showWebView;
        _urlController.text = "Loading dynamic content...";
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _errorMessage = "Failed to generate URL dynamically: $e";
        _pageState = PageState.showPhoneNumberInput;
      });
    }
  }

  void _loadUrlFromManualInput() {
    final urlText = _urlController.text.trim();
    if (urlText.isNotEmpty) {
      final uri = Uri.tryParse(urlText);
      if (uri != null) {
        final finalUrl = (uri.scheme.isEmpty) ? 'https://$urlText' : urlText;
        _webViewController?.loadUrl(urlRequest: URLRequest(url: WebUri(finalUrl)));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.plugin?.name ?? "Web View"),
        actions: [
          if (widget.plugin != null && _pageState != PageState.manualInput)
            IconButton(
              icon: const Icon(Icons.drive_file_rename_outline),
              tooltip: 'Switch to dynamic mode',
              onPressed: () {
                setState(() {
                  _pageState = PageState.showPhoneNumberInput;
                  _errorMessage = null;
                });
              },
            ),
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: _canGoBack ? () => _webViewController?.goBack() : null,
          ),
          IconButton(
            icon: const Icon(Icons.arrow_forward),
            onPressed: _canGoForward ? () => _webViewController?.goForward() : null,
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              _webViewController?.reload();
            },
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            if (_pageState == PageState.loading || (_pageState == PageState.showWebView && _progress < 1.0 && _progress > 0))
              LinearProgressIndicator(value: _pageState == PageState.loading ? null : _progress),
            if (_pageState == PageState.manualInput || _pageState == PageState.showWebView) _buildUrlBar(),
            Expanded(child: _buildBody()),
          ],
        ),
      ),
    );
  }

  Widget _buildUrlBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: _urlController,
        decoration: InputDecoration(
          hintText: 'Enter URL and press enter',
          border: const OutlineInputBorder(),
          suffixIcon: IconButton(
            icon: const Icon(Icons.arrow_forward),
            onPressed: _loadUrlFromManualInput,
          ),
        ),
        onSubmitted: (_) => _loadUrlFromManualInput(),
        keyboardType: TextInputType.url,
      ),
    );
  }

  Widget _buildBody() {
    switch (_pageState) {
      case PageState.initial:
      case PageState.loading:
        return const Center(child: CircularProgressIndicator());
      case PageState.showPhoneNumberInput:
        return _buildPhoneNumberInput();
      case PageState.error:
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('Error: $_errorMessage', style: const TextStyle(color: Colors.red)),
          ),
        );
      case PageState.manualInput:
      case PageState.showWebView:
        if (_urlToLoad == null) {
          return const Center(child: Text("No URL to load."));
        }
        return _buildWebView();
      default:
        return const Center(child: Text("Something went wrong."));
    }
  }

  Widget _buildPhoneNumberInput() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            "Static URL extraction failed or is not available. Please enter a phone number to generate the URL dynamically.",
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          if (_errorMessage != null) ...[
            Text(_errorMessage!, style: const TextStyle(color: Colors.red), textAlign: TextAlign.center),
            const SizedBox(height: 16),
          ],
          TextField(
            controller: _phoneNumberController,
            decoration: const InputDecoration(
              labelText: "Phone Number",
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _generateDynamicUrl,
            child: const Text("Generate URL"),
          ),
          const SizedBox(height: 8),
          if (_staticUrl != null)
            TextButton(
              onPressed: () {
                setState(() {
                  _pageState = PageState.showWebView;
                  _urlToLoad = _staticUrl; // Restore static URL
                  _headers = _staticHeaders; // Restore static headers
                  _urlController.text = _urlToLoad!;
                  _errorMessage = null;
                });
              },
              child: const Text("Back to static view"),
            ),
        ],
      ),
    );
  }

  Widget _buildWebView() {
    return InAppWebView(
      initialUrlRequest: URLRequest(url: WebUri(_urlToLoad!), headers: _headers),
      initialSettings: InAppWebViewSettings(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
        javaScriptEnabled: true,
        useShouldInterceptRequest: true,
        domStorageEnabled: true,
        transparentBackground: true,
      ),
      pullToRefreshController: _pullToRefreshController,
      onWebViewCreated: (controller) {
        _webViewController = controller;
      },
      onLoadStart: (controller, url) {
        if (mounted && url != null) {
          setState(() {
            _urlController.text = url.toString();
            _progress = 0;
          });
        }
      },
      onLoadStop: (controller, url) async {
        if (mounted) {
          _pullToRefreshController?.endRefreshing();
          if (url != null) {
            setState(() {
              _urlController.text = url.toString();
            });
          }
          final canGoBack = await _webViewController?.canGoBack() ?? false;
          final canGoForward = await _webViewController?.canGoForward() ?? false;
          setState(() {
            _canGoBack = canGoBack;
            _canGoForward = canGoForward;
          });
        }
      },
      onReceivedError: (controller, request, error) {
        if (mounted) {
          _pullToRefreshController?.endRefreshing();
        }
      },
      onProgressChanged: (controller, progress) {
        if (progress == 100) {
          _pullToRefreshController?.endRefreshing();
        }
        if (mounted) {
          setState(() {
            _progress = progress / 100;
          });
        }
      },
      onUpdateVisitedHistory: (controller, url, androidIsReload) async {
        if (mounted) {
          final canGoBack = await _webViewController?.canGoBack() ?? false;
          final canGoForward = await _webViewController?.canGoForward() ?? false;
          setState(() {
            _canGoBack = canGoBack;
            _canGoForward = canGoForward;
            if (url != null) {
              _urlController.text = url.toString();
            }
          });
        }
      },
      
      
      
      
      shouldOverrideUrlLoading: (controller, navigationAction) async {
        // Allow all navigation requests.
        return NavigationActionPolicy.ALLOW;
      },
      shouldInterceptRequest: (controller, request) async {
        final uri = request.url;
        if (uri.scheme == PluginUrlWebViewService.PROXY_SCHEME && uri.host == PluginUrlWebViewService.PROXY_HOST) {
          final targetUrl = uri.queryParameters['targetUrl'];
          final headersStr = uri.queryParameters['headers'];

          if (targetUrl != null) {
            final decodedUrl = Uri.decodeComponent(targetUrl);
            Map<String, String> headers = {};
            if (headersStr != null) {
              try {
                final decodedHeadersStr = Uri.decodeComponent(headersStr);
                final decodedHeaders = jsonDecode(decodedHeadersStr) as Map<String, dynamic>;
                headers = decodedHeaders.map((key, value) => MapEntry(key, value.toString()));
              } catch (e) {
                if (kDebugMode) {
                  print("Error decoding headers from proxy URL: $e");
                }
              }
            }

            _webViewController?.loadUrl(urlRequest: URLRequest(url: WebUri(decodedUrl), headers: headers));

            return WebResourceResponse(
                contentType: 'text/plain', data: Uint8List(0), statusCode: 200, reasonPhrase: 'Request Handled');
          }
        }
        return null;
      },
    );
  }
}
