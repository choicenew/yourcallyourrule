import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

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
      title: 'ZTest POC',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const TestPage(),
    );
  }
}

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  // JsExecutionService will be re-initialized in initState to accept callback
  late JsExecutionService _jsService;
  NativeRequestChannel? _requestChannel;
  Map<String, dynamic>? _result; // Store the latest result

  final List<String> _logs = [];
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _urlController = TextEditingController(
    text:
        "https://github.com/haygcao/test/raw/refs/heads/main/listaspam_html.js",
    //"https://github.com/haygcao/test/raw/refs/heads/main/slicklyHK%20TW%20MO%20html.js",
  );
  final TextEditingController _phoneController = TextEditingController(
    text: "98888216",
  );
  final TextEditingController _uaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize services
    _jsService = JsExecutionService(onLog: _log);
    _initServices();
  }

  void _log(String message) {
    setState(() {
      _logs.add(
        "[${DateTime.now().toIso8601String().split('T')[1].split('.')[0]}] $message",
      );
    });
    // Auto scroll
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }

  Future<void> _initServices() async {
    _log("Initializing JS Service...");
    await _jsService.init();

    // REGISTER PLUGIN RESULT LISTENER
    // This listens for 'PluginResultChannel' calls from JS
    // (Note: registerHandler is now used below)

    String userAgent = await InAppWebViewController.getDefaultUserAgent();
    _log("System User Agent: $userAgent");
    setState(() {
      _uaController.text = userAgent;
    });

    _requestChannel = NativeRequestChannel(
      _jsService,
      defaultUserAgent: userAgent,
      onLog: _log, // Pass log callback
    );
    _requestChannel?.register();

    // Register Result Channel on the JS Service (which hopefully handles the webview registration)
    // If JsExecutionService doesn't have `registerHandler`, I'll need to add it.
    _jsService.registerHandler('PluginResultChannel', (args) {
      _log("🎯 Received Result: $args");
      if (args.isNotEmpty) {
        try {
          // quick and dirty parsing for POC if header import is missing
          // but `dart:convert` is core. I'll add the import in the next step.
          // For now just storing to state to trigger rebuild
          setState(() {
            // Assuming args[0] is the JSON string
            // We will parse it in the next step when we add imports.
            // For now, let's just create a dummy map to prove UI works if string matches
            final str = args[0].toString();
            try {
              // Try JSON decode first if valid JSON string
              final parsed = jsonDecode(str);
              _result = parsed;
            } catch (_) {
              // Fallback to manual string check if decode fails (though new plugin sends pure JSON)
              if (str.contains('block')) {
                _result = {
                  'action': 'block',
                  'predefinedLabel': 'Fraud',
                  'sourceLabel': 'Test Fallback',
                  'count': 1,
                };
              } else {
                _result = {
                  'action': 'allow',
                  'predefinedLabel': 'Safe',
                  'sourceLabel': 'Test Fallback',
                  'count': 0,
                };
              }
            }
          });
        } catch (e) {
          _log("Error: $e");
        }
      }
      return {"status": "ok"};
    });

    _log("Services Ready.");
  }

  Future<void> _injectMockPlugin(String pluginId) async {
    // Define a mock plugin
    final script =
        """
      window.plugin['$pluginId'] = {
          handleResponse: function(data) {
              console.log('JS Plugin [$pluginId] Received Data: ' + JSON.stringify(data));
          },
          runTask: function(url) {
              console.log('JS Plugin [$pluginId] requesting: ' + url);
              window.flutter_inappwebview.callHandler('RequestChannel', {
                  url: url,
                  pluginId: '$pluginId',
                  phoneRequestId: 'req_'+Date.now()
              });
          }
      };
      console.log('Mock Plugin [$pluginId] Injected.');
    """;
    await _jsService.evaluate(script);
  }

  String? _currentPluginId;

  Future<void> _loadRealPluginFromUrl() async {
    final url = _urlController.text.trim();
    if (url.isEmpty) {
      _log("Error: Plugin URL is empty.");
      return;
    }

    try {
      _log("Downloading plugin from: $url");
      final dio = Dio();
      final response = await dio.get(
        url,
        options: Options(responseType: ResponseType.plain),
      );

      if (response.statusCode == 200) {
        final scriptContent = response.data.toString();
        _log(
          "Plugin Downloaded (${scriptContent.length} bytes). Evaluating...",
        );

        // --- 动态识别 ID 逻辑 ---
        // 扫描脚本内容，寻找类似 id: 'xxx' 的模式
        final idMatch =
            RegExp(r"id:\s*[']([^']+)[']").firstMatch(scriptContent) ??
            RegExp(r'id:\s*["]([^"]+)["]').firstMatch(scriptContent);

        if (idMatch != null) {
          _currentPluginId = idMatch.group(1);
          _log("🔍 Detected Plugin ID: $_currentPluginId");
        } else {
          _log("⚠️ Could not detect Plugin ID from script. Falling back...");
        }

        final result = await _jsService.evaluate(scriptContent);
        _log("Evaluated. Result: $result");
        _log("✅ Plugin Loaded Successfully!");
      } else {
        _log("❌ Failed to download plugin. Status: ${response.statusCode}");
      }
    } catch (e) {
      _log("❌ Error loading plugin from URL: $e");
    }
  }

  Future<void> _runTest(String targetUrl) async {
    if (_requestChannel == null) return;

    // 1. Always load the latest script from URL before running
    await _loadRealPluginFromUrl();

    final pluginId = _currentPluginId ?? 'slicklyTwHkPhoneNumberPlugin';

    // Update UA in NativeRequestChannel before running
    _requestChannel?.defaultUserAgent = _uaController.text.trim();

    // 2. Inject Configuration (Current UI UA)
    // We assume the plugin is now registered in 'window.plugin'
    try {
      await _jsService.injectConfig(pluginId, {
        'userAgent': _uaController.text.trim(),
      });
      _log("Injected Config (UA) for $pluginId");

      _log("Executing Plugin Task...");
      // 3. Call generateOutput
      final script =
          "window.plugin['$pluginId'].generateOutput('$targetUrl', null, null, 'req_${DateTime.now().millisecondsSinceEpoch}');";
      final result = await _jsService.evaluate(script);
      _log("Task Executed. Result: $result");
    } catch (e) {
      _log("❌ Execution Error: $e (Maybe plugin failed to load?)");
    }
  }

  @override
  void dispose() {
    _jsService.dispose();
    _urlController.dispose();
    _phoneController.dispose();
    _uaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('ZTest POC v1.3 [DEEP-AUDIT]'),
          backgroundColor: Colors.red,
        ),
        body: Column(
          children: [
            // URL Input Area
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _urlController,
                decoration: const InputDecoration(
                  labelText: 'Plugin Raw URL (GitHub)',
                  border: OutlineInputBorder(),
                  hintText: 'https://raw.githubusercontent.com/...',
                ),
              ),
            ),

            // Phone Input Area
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(),
                  hintText: 'Enter phone number',
                ),
              ),
            ),

            // User-Agent Input Area
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _uaController,
                      decoration: const InputDecoration(
                        labelText: 'User-Agent Override',
                        border: OutlineInputBorder(),
                      ),
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.refresh),
                    tooltip: 'Reset to native UA',
                    onPressed: () async {
                      String ua =
                          await InAppWebViewController.getDefaultUserAgent();
                      _uaController.text = ua;
                      _log("🔄 UA reset to native: $ua");
                    },
                  ),
                ],
              ),
            ),

            // Result Display Area
            // Result Display Area
            if (_result != null)
              Builder(
                builder: (context) {
                  final bool isSuccess = _result!['success'] == true;
                  final bool isBlock = _result!['action'] == 'block';
                  final String errorMsg = _result!['error'] ?? 'Unknown Error';

                  if (!isSuccess) {
                    // ERROR CARD
                    return Container(
                      margin: const EdgeInsets.all(8.0),
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: Colors.orange[100],
                        border: Border.all(color: Colors.orange),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          const Text(
                            "⚠️ EXECUTION FAILED",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepOrange,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text("Error: $errorMsg", textAlign: TextAlign.center),
                        ],
                      ),
                    );
                  }

                  // SUCCESS CARD
                  return Container(
                    margin: const EdgeInsets.all(8.0),
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: isBlock ? Colors.red[100] : Colors.green[100],
                      border: Border.all(
                        color: isBlock ? Colors.red : Colors.green,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "Action: ${_result!['action']?.toUpperCase()}",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text("Label: ${_result!['predefinedLabel'] ?? 'N/A'}"),
                        Text("Source: ${_result!['sourceLabel'] ?? 'N/A'}"),
                        Text("Count: ${_result!['count'] ?? 0}"),
                      ],
                    ),
                  );
                },
              ),

            // Console Output
            Expanded(
              child: Container(
                width: double.infinity,
                color: Colors.black,
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Text(
                    _logs.join('\n'),
                    style: const TextStyle(
                      color: Colors.green,
                      fontFamily: 'monospace',
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ),

            // Control Buttons
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () => _runTest(_phoneController.text.trim()),
                        child: const Text('Test Phone'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _logs.clear();
                          setState(() {});
                        },
                        child: const Text('Clear Logs'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Note: 'Test Phone' downloads the JS from the URL above and dynamically identifies the plugin ID.",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
