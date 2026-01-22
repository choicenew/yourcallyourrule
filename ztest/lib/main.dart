import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter/material.dart';
import 'core/js_execution_service.dart';
import 'core/native_request_channel.dart';
import 'package:dio/dio.dart';

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

  final List<String> _logs = [];
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _urlController = TextEditingController(
    text:
        "https://github.com/haygcao/test/raw/refs/heads/main/slicklyHK%20TW%20MO%20html.js",
  );

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

    String userAgent = await InAppWebViewController.getDefaultUserAgent();
    _log("System User Agent: $userAgent");

    _requestChannel = NativeRequestChannel(
      _jsService,
      defaultUserAgent: userAgent,
      onLog: _log, // Pass log callback
    );
    _requestChannel?.register();

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

  Future<void> _loadRealPluginFromUrl() async {
    final url = _urlController.text.trim();
    if (url.isEmpty) {
      _log("Error: Plugin URL is empty.");
      return;
    }

    try {
      _log("Downloading plugin from: $url");
      // Use the existing dio instance from NativeRequestChannel or create a new one.
      // Since NativeRequestChannel owns Dio, we can create a simple temporary one or access it if we made it public.
      // Let's create a temporary one for simplicity.
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
        final result = await _jsService.evaluate(scriptContent);
        _log("Evaluated. Result: $result");
        // Note: flutter_js evaluate returns string result of last expression
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

    const pluginId = 'slicklyTwHkPhoneNumberPlugin';

    // 2. Inject Configuration (System UA)
    // We assume the plugin is now registered in 'window.plugin'
    try {
      await _jsService.injectConfig(pluginId, {
        // 'userAgent': _requestChannel!.defaultUserAgent, // REMOVED: Respect Plugin's internal default (Windows)
      });
      _log("Injected Config for $pluginId");

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
    _urlController.dispose(); // Dispose the controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('ZTest Architecture POC')),
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
                        onPressed: () =>
                            _runTest("0970569095"), // Dummy Phone Number
                        child: const Text('Test Phone (0970569095)'),
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
                    "Note: 'Test Phone' downloads the JS from the URL above and runs it against '66666666'.",
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
