import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'core/cloudflare_legacy_service.dart';
import 'core/cloudflare_scripts.dart';
import 'core/js_execution_service.dart';
import 'core/native_request_channel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ZTest Consistency',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: false),
      home: const SplitTestPage(),
    );
  }
}

class SplitTestPage extends StatefulWidget {
  const SplitTestPage({super.key});

  @override
  State<SplitTestPage> createState() => _SplitTestPageState();
}

class _SplitTestPageState extends State<SplitTestPage> {
  late JsExecutionService _jsService;
  NativeRequestChannel? _requestChannel;
  InAppWebViewController? _manualController;

  String? _currentPluginId;
  bool _isRunning = false;
  final List<String> _logs = [];
  final ScrollController _scrollController = ScrollController();

  // ⭐ 这里的初始值只是方便调试，你可以随意修改，运行时绝对使用输入框的值
  final TextEditingController _pluginUrlController = TextEditingController(
    text:
        "https://github.com/haygcao/test/raw/refs/heads/main/listaspam_html.js",
  );
  final TextEditingController _phoneController = TextEditingController(
    text: "98888216",
  );
  final TextEditingController _uaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _jsService = JsExecutionService(onLog: _log);
    _initServices();
  }

  @override
  void dispose() {
    _jsService.dispose();
    _pluginUrlController.dispose();
    _phoneController.dispose();
    _uaController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _log(String msg) {
    if (kDebugMode) print(msg);
    if (mounted) {
      setState(() {
        _logs.add(msg);
        if (_logs.length > 200) _logs.removeAt(0);
      });
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scrollController.hasClients) {
          _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
        }
      });
    }
  }

  Future<void> _initServices() async {
    await _jsService.init();
    String ua = await InAppWebViewController.getDefaultUserAgent();
    if (mounted) {
      setState(() => _uaController.text = ua);
    }

    // 初始化 RequestChannel，但我们会在运行时动态拦截它
    _requestChannel = NativeRequestChannel(
      _jsService,
      defaultUserAgent: ua,
      onLog: (s) {},
    );
    _requestChannel?.register();

    _jsService.registerHandler('PluginResultChannel', (args) {
      _log("🤖 [AUTO RESULT] $args");
    });
  }

  Future<void> _stopTest() async {
    _log("⛔ STOPPING...");
    setState(() => _isRunning = false);

    // 强制打断两个 WebView
    _manualController?.loadUrl(
      urlRequest: URLRequest(url: WebUri('about:blank')),
    );
    await CloudflareLegacyService().executeBypass("about:blank");

    _log("🛑 Stopped & Reset.");
  }

  Future<void> _clearCookies() async {
    await CookieManager.instance().deleteAllCookies();
    _log("🧹 Cookies Cleared.");
  }

  // --- ⭐ 核心逻辑：获取插件生成的真实 URL ---
  Future<String?> _resolveTargetUrl(
    String pluginUrl,
    String phone,
    String ua,
  ) async {
    _log("🕵️ Resolving Target URL via Plugin logic...");

    // 1. 下载插件
    try {
      final dio = Dio();
      final response = await dio.get(
        pluginUrl,
        options: Options(responseType: ResponseType.plain),
      );
      final script = response.data.toString();
      final idMatch =
          RegExp(r"id:\s*[']([^']+)[']").firstMatch(script) ??
          RegExp(r'id:\s*["]([^"]+)["]').firstMatch(script);
      _currentPluginId = idMatch?.group(1) ?? 'slicklyTwHkPhoneNumberPlugin';

      await _jsService.evaluate(script);
      await _jsService.injectConfig(_currentPluginId!, {'userAgent': ua});
    } catch (e) {
      _log("❌ Plugin Load Error: $e");
      return null;
    }

    // 2. 劫持 RequestChannel
    // 我们不让它真的发请求，而是把它生成的 URL 偷出来
    final completer = Completer<String?>();

    _jsService.onRequestChannel = (dynamic message) async {
      try {
        Map<String, dynamic> data = (message is String)
            ? jsonDecode(message)
            : Map<String, dynamic>.from(message);
        String url = data['url'];
        _log("🎯 Captured URL from Plugin: $url");
        if (!completer.isCompleted) completer.complete(url);
      } catch (e) {
        _log("❌ Failed to parse capture: $e");
        if (!completer.isCompleted) completer.complete(null);
      }
      return null; // 不执行实际网络请求
    };

    // 3. 触发插件
    final jsCall =
        "window.plugin['$_currentPluginId'].generateOutput('$phone', null, null, 'req_CAPTURE');";
    await _jsService.evaluate(jsCall);

    // 4. 等待捕获
    try {
      final url = await completer.future.timeout(const Duration(seconds: 5));

      // 5. 恢复 RequestChannel 的正常功能 (给 Auto 模式用)
      _requestChannel?.register();

      return url;
    } catch (e) {
      _log("❌ Timeout waiting for URL generation");
      _requestChannel?.register(); // 恢复
      return null;
    }
  }

  Future<void> _runSplitTest() async {
    if (_isRunning) await _stopTest();

    // ⭐ 使用 UI 输入的值，而不是硬编码
    final phone = _phoneController.text.trim();
    final pluginUrl = _pluginUrlController.text.trim();
    final ua = _uaController.text.trim();

    if (phone.isEmpty || pluginUrl.isEmpty) {
      _log("❌ Error: Phone or Plugin URL is empty!");
      return;
    }

    setState(() => _isRunning = true);
    _log("🔥 STARTING STRICT A/B TEST...");

    // 1. 先通过插件逻辑，解析出真实的 URL
    final targetUrl = await _resolveTargetUrl(pluginUrl, phone, ua);

    if (targetUrl == null) {
      _log("❌ Failed to resolve Target URL. Stopping.");
      setState(() => _isRunning = false);
      return;
    }

    // ⭐ 2. 将解析出的同一个 URL 喂给两个环境

    // --- A. 启动顶部 (手动) ---
    if (_manualController != null) {
      _log("🖐️ [MANUAL] Loading: $targetUrl");
      await _manualController?.setSettings(
        settings: InAppWebViewSettings(userAgent: ua),
      );
      await _manualController?.loadUrl(
        urlRequest: URLRequest(url: WebUri(targetUrl)),
      );
    }

    // --- B. 启动底部 (自动) ---
    _log("🤖 [AUTO] Loading: $targetUrl");
    await CloudflareLegacyService().disableManualMode();
    // 直接让 LegacyService 加载这个 URL，跳过 NativeRequestChannel 的再次请求
    // 这样保证了 URL 的绝对一致性
    CloudflareLegacyService().executeBypass(targetUrl, userAgent: ua);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('ZTest Scientific A/B'),
        backgroundColor: Colors.black87,
        actions: [
          IconButton(
            icon: const Icon(Icons.cookie),
            onPressed: _clearCookies,
            tooltip: 'Clear Cookies',
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => setState(() => _logs.clear()),
            tooltip: 'Clear Log',
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.blueGrey[50],
            child: Column(
              children: [
                TextField(
                  controller: _pluginUrlController,
                  style: const TextStyle(fontSize: 12),
                  decoration: const InputDecoration(
                    labelText: 'Plugin URL',
                    isDense: true,
                    border: OutlineInputBorder(),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: TextField(
                        controller: _phoneController,
                        decoration: const InputDecoration(
                          labelText: 'Phone',
                          border: OutlineInputBorder(),
                          isDense: true,
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      flex: 2,
                      child: TextField(
                        controller: _uaController,
                        style: const TextStyle(fontSize: 10),
                        decoration: const InputDecoration(
                          labelText: 'UA',
                          border: OutlineInputBorder(),
                          isDense: true,
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _runSplitTest,
                        icon: const Icon(Icons.play_arrow),
                        label: const Text("RUN SCIENTIFIC TEST"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _stopTest,
                        icon: const Icon(Icons.stop),
                        label: const Text("STOP"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // 顶部手动
          Expanded(
            flex: 4,
            child: Stack(
              children: [
                InAppWebView(
                  gestureRecognizers: {
                    Factory<OneSequenceGestureRecognizer>(
                      () => EagerGestureRecognizer(),
                    ),
                  },
                  initialSettings: InAppWebViewSettings(
                    javaScriptEnabled: true,
                    domStorageEnabled: true,
                    useHybridComposition: true,
                  ),
                  initialUserScripts: UnmodifiableListView([
                    UserScript(
                      source:
                          "window._cf_manual_mode = true; console.log('[System] Manual Mode Injected!'); " +
                          CloudflareScripts.bypassUniversal,
                      injectionTime: UserScriptInjectionTime.AT_DOCUMENT_START,
                    ),
                  ]),
                  onWebViewCreated: (c) => _manualController = c,
                  onConsoleMessage: (c, msg) {
                    if (msg.message.contains("Manual"))
                      print("🖐️ ${msg.message}");
                  },
                ),
                IgnorePointer(
                  ignoring: true,
                  child: Stack(
                    children: [
                      Positioned(
                        top: 0,
                        right: 0,
                        left: 0,
                        child: Container(
                          color: Colors.blue.withOpacity(0.8),
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: const Center(
                            child: Text(
                              "🖐️ MANUAL (Human Click)",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue, width: 3),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // 日志
          Container(
            height: 80,
            color: Colors.black,
            width: double.infinity,
            padding: const EdgeInsets.all(4),
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _logs.length,
              itemBuilder: (c, i) => Text(
                _logs[i],
                style: const TextStyle(
                  color: Colors.greenAccent,
                  fontSize: 10,
                  fontFamily: 'monospace',
                ),
              ),
            ),
          ),

          // 底部自动
          Expanded(
            flex: 4,
            child: Stack(
              children: [
                CloudflareLegacyService().getWebViewWidget(),
                IgnorePointer(
                  ignoring: true,
                  child: Stack(
                    children: [
                      Positioned(
                        top: 0,
                        right: 0,
                        left: 0,
                        child: Container(
                          color: Colors.red.withOpacity(0.8),
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: const Center(
                            child: Text(
                              "🤖 AUTO (Script v2.0)",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.red, width: 3),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
