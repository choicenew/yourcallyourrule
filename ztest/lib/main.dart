import 'dart:async';
import 'dart:collection';

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
      title: 'ZTest Touch Fix',
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
    setState(() => _uaController.text = ua);

    _requestChannel = NativeRequestChannel(
      _jsService,
      defaultUserAgent: ua,
      onLog: (s) {},
    );
    _requestChannel?.register();

    _jsService.registerHandler('PluginResultChannel', (args) {
      _log("🤖 [AUTO RESULT] $args");
      // 不自动停止，防止界面闪白
    });
  }

  Future<void> _stopTest() async {
    _log("⛔ STOPPING...");
    setState(() => _isRunning = false);
    _manualController?.loadUrl(
      urlRequest: URLRequest(url: WebUri('about:blank')),
    );
    CloudflareLegacyService().getWebViewWidget();
    await CloudflareLegacyService().executeBypass("about:blank");
    _log("🛑 Stopped.");
  }

  Future<void> _runSplitTest() async {
    if (_isRunning) await _stopTest();
    setState(() => _isRunning = true);

    final phone = _phoneController.text.trim();
    final pluginUrl = _pluginUrlController.text.trim();
    final ua = _uaController.text.trim();

    if (phone.isEmpty) {
      _log("❌ Error: Phone is empty!");
      return;
    }

    final targetUrl =
        "https://www.listaspam.com/busca.php?Telefono=$phone&successMarker=number_data_box";
    _log("🔥 STARTING A/B TEST...");

    // A. 顶部手动
    if (_manualController != null) {
      _log("🖐️ [MANUAL] Loading...");
      await _manualController?.setSettings(
        settings: InAppWebViewSettings(userAgent: ua),
      );
      await _manualController?.loadUrl(
        urlRequest: URLRequest(url: WebUri(targetUrl)),
      );
    }

    // B. 底部自动
    _log("🤖 [AUTO] Loading Script...");
    _loadPluginAndRunAuto(pluginUrl, phone, ua);
  }

  Future<void> _loadPluginAndRunAuto(
    String scriptUrl,
    String phone,
    String ua,
  ) async {
    if (_currentPluginId == null) {
      try {
        final dio = Dio();
        final response = await dio.get(
          scriptUrl,
          options: Options(responseType: ResponseType.plain),
        );
        final script = response.data.toString();
        final idMatch =
            RegExp(r"id:\s*[']([^']+)[']").firstMatch(script) ??
            RegExp(r'id:\s*["]([^"]+)["]').firstMatch(script);
        _currentPluginId = idMatch?.group(1) ?? 'slicklyTwHkPhoneNumberPlugin';
        await _jsService.evaluate(script);
        _log("✅ Plugin loaded: $_currentPluginId");
      } catch (e) {
        _log("❌ Plugin Load Error: $e");
        return;
      }
    }

    await CloudflareLegacyService().disableManualMode();
    _requestChannel?.defaultUserAgent = ua;

    try {
      await _jsService.injectConfig(_currentPluginId!, {'userAgent': ua});
      final jsCall =
          "window.plugin['$_currentPluginId'].generateOutput('$phone', null, null, 'req_${DateTime.now().millisecondsSinceEpoch}');";
      await _jsService.evaluate(jsCall);
    } catch (e) {
      _log("❌ Auto Execution Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('ZTest Touch Fixed'),
        backgroundColor: Colors.black87,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => setState(() => _logs.clear()),
          ),
        ],
      ),
      body: Column(
        children: [
          // 1. 设置区域
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
                        label: const Text("RUN A/B TEST"),
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

          // 2. 顶部 WebView (手动)
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

                // ⭐⭐ 关键修复：把装饰层包裹在 IgnorePointer 里 ⭐⭐
                IgnorePointer(
                  ignoring: true, // 让点击穿透这些装饰
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
                              "🖐️ MANUAL CHECK (You click)",
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

          // 3. 日志
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

          // 4. 底部 WebView (自动)
          Expanded(
            flex: 4,
            child: Stack(
              children: [
                CloudflareLegacyService().getWebViewWidget(),

                // ⭐⭐ 关键修复：底部也加上 IgnorePointer ⭐⭐
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
                              "🤖 AUTO CHECK (Script clicks)",
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
