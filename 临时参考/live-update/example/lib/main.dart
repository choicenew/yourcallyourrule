import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:live_updates/live_updates.dart';
import 'package:live_updates/models/live_update_progress_data.dart';
import 'package:live_updates_example/customization_screen.dart';
import 'package:live_updates_example/notification_style.dart';
import 'package:provider/provider.dart';
import 'caller_id_page.dart';
import 'download_page.dart';
import 'test_page.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

// Provider to manage notification state
class NotificationStateProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _notificationEvents = [];
  String? _lastPayload;

  List<Map<String, dynamic>> get notificationEvents => _notificationEvents;
  String? get lastPayload => _lastPayload;

  void addNotificationEvent(String source, String? payload) {
    final event = {
      'timestamp': DateTime.now().toIso8601String(),
      'source': source,
      'payload': payload,
    };
    _notificationEvents.insert(0, event);
    _lastPayload = payload;

    // Keep only last 20 events
    if (_notificationEvents.length > 20) {
      _notificationEvents = _notificationEvents.take(20).toList();
    }

    notifyListeners();

    // Log as JSON
    debugPrint('Notification Event JSON: ${jsonEncode(event)}');
  }

  void clear() {
    _notificationEvents.clear();
    _lastPayload = null;
    notifyListeners();
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Create provider instance
  final notificationProvider = NotificationStateProvider();

  LiveUpdates.initialize(
    onNotificationTapped: (payload) {
      // Convert callback to JSON format
      final callbackData = {
        'type': 'onNotificationTapped',
        'payload': payload,
        'timestamp': DateTime.now().toIso8601String(),
      };

      debugPrint('Callback JSON: ${jsonEncode(callbackData)}');
      notificationProvider.addNotificationEvent('Callback', payload);

      if (payload != null && payload.isNotEmpty) {
        scaffoldMessengerKey.currentState?.showSnackBar(
          SnackBar(content: Text('Callback: ${jsonEncode(callbackData)}')),
        );
        // Navigate to TestPage
        Navigator.of(scaffoldMessengerKey.currentContext!).push(
          MaterialPageRoute(builder: (_) => TestPage(payload: payload)),
        );
      }
    },
  );

  runApp(
    ChangeNotifierProvider.value(
      value: notificationProvider,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: scaffoldMessengerKey,
      navigatorKey: navigatorKey,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // 保存用户自定义的样式，作为全局状态
  NotificationStyle _customStyle = NotificationStyle();

  @override
  void initState() {
    super.initState();
    // 监听通知点击事件 (Stream 方式 - 依然可用)
    LiveUpdates.notificationPayloadStream.listen((payload) {
      if (mounted && payload != null && payload.isNotEmpty) {
        // Convert stream event to JSON format
        final streamData = {
          'type': 'notificationPayloadStream',
          'payload': payload,
          'timestamp': DateTime.now().toIso8601String(),
        };

        debugPrint('Stream JSON: ${jsonEncode(streamData)}');
        context
            .read<NotificationStateProvider>()
            .addNotificationEvent('Stream', payload);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Stream: ${jsonEncode(streamData)}')),
        );
        // Navigate to TestPage
        navigatorKey.currentState?.push(
          MaterialPageRoute(builder: (_) => TestPage(payload: payload)),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Live Updates Demo'),
        actions: [
          IconButton(
            icon: const Icon(Icons.list),
            tooltip: 'View Notification Events',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (_) => const NotificationEventsPage()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Display last payload using Provider
              Consumer<NotificationStateProvider>(
                builder: (context, provider, child) {
                  return Card(
                    margin: const EdgeInsets.all(16),
                    color: Colors.blue.shade50,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Last Notification Event:',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            provider.lastPayload ?? 'No events yet',
                            style: const TextStyle(fontFamily: 'monospace'),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Total Events: ${provider.notificationEvents.length}',
                            style: const TextStyle(
                                fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              // --- 演示 showNotification (可提升为 Live Update) ---
              const ListTile(
                title: Text('Standard Notifications',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                subtitle: Text(
                    'These can be promoted to Live Updates by the system.'),
              ),
              ElevatedButton(
                onPressed: () {
                  final payloadData = {
                    'type': 'big_text',
                    'notificationId': 1,
                    'timestamp': DateTime.now().toIso8601String(),
                  };
                  final payload = jsonEncode(payloadData);

                  LiveUpdates.showNotification(
                    notificationId: 1,
                    title: 'Big Text Style',
                    text:
                        'This is a standard notification that can be promoted to a Live Update.',
                    style: 'bigText',
                    payload: payload,
                  );
                },
                child: const Text("Show Big Text"),
              ),
              ElevatedButton(
                onPressed: () {
                  final payloadData = {
                    'type': 'call_style',
                    'notificationId': 2,
                    'caller': 'John Doe',
                    'timestamp': DateTime.now().toIso8601String(),
                  };
                  final payload = jsonEncode(payloadData);

                  LiveUpdates.showNotification(
                    notificationId: 2,
                    title: 'Incoming Call',
                    text: 'John Doe',
                    style: 'call',
                    payload: payload,
                  );
                },
                child: const Text("Show Call Style"),
              ),
              ElevatedButton(
                onPressed: () {
                  final payloadData = {
                    'type': 'simple_progress',
                    'notificationId': 3,
                    'progress': 50,
                    'timestamp': DateTime.now().toIso8601String(),
                  };
                  final payload = jsonEncode(payloadData);

                  LiveUpdates.showNotification(
                    notificationId: 3,
                    title: 'Simple Progress',
                    text: 'Downloading...',
                    style: 'progress',
                    progress: 50,
                    payload: payload,
                  );
                },
                child: const Text("Show Simple Progress"),
              ),
              ElevatedButton(
                onPressed: () {
                  final payloadData = {
                    'type': 'android_15_live_update',
                    'notificationId': 4,
                    'progress': 60,
                    'segments': [
                      {'progress': 30, 'color': 'green'},
                      {'progress': 40, 'color': 'orange'},
                      {'progress': 30, 'color': 'blue'},
                    ],
                    'timestamp': DateTime.now().toIso8601String(),
                  };
                  final payload = jsonEncode(payloadData);

                  LiveUpdates.showNotification(
                    notificationId: 4,
                    title: 'Android 15+ Live Update',
                    text: 'Your ride is approaching',
                    style: 'progress',
                    progress: 60,
                    payload: payload,
                    progressSegments: [
                      LiveUpdateSegment(progress: 30, color: Colors.green),
                      LiveUpdateSegment(progress: 40, color: Colors.orange),
                      LiveUpdateSegment(progress: 30, color: Colors.blue),
                    ],
                  );
                },
                child: const Text("Show Android 15+ Progress"),
              ),
              const Divider(height: 32),

              // --- 演示 showLayoutNotification (高优先级悬浮通知) ---
              const ListTile(
                title: Text('Custom Layout Notifications',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                subtitle: Text(
                    'These are high-priority Heads-Up notifications, NOT Live Updates.'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => CallerIdPage(style: _customStyle), // 传入样式
                  ));
                },
                child: const Text('Go to Caller ID Demo'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => const DownloadPage(),
                  ));
                },
                child: const Text('Go to Download Demo'),
              ),
              ElevatedButton(
                onPressed: () async {
                  // 跳转到唯一的自定义页面
                  final newStyle =
                      await Navigator.of(context).push<NotificationStyle>(
                    MaterialPageRoute(
                        builder: (_) =>
                            CustomizationScreen(initialStyle: _customStyle)),
                  );
                  // 如果用户保存了新样式，就更新它
                  if (newStyle != null && mounted) {
                    setState(() {
                      _customStyle = newStyle;
                    });
                  }
                },
                child: const Text('Go to Caller ID Customizer'),
              ),
              const SizedBox(height: 20),
              OutlinedButton(
                style: OutlinedButton.styleFrom(foregroundColor: Colors.red),
                onPressed: () {
                  for (int i = 1; i <= 4; i++) {
                    LiveUpdates.cancelNotification(i);
                  }
                  LiveUpdates.cancelNotification(101); // for caller id
                  LiveUpdates.cancelNotification(102); // for download
                },
                child: const Text('Cancel Custom Notification'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// New page to display notification events
class NotificationEventsPage extends StatelessWidget {
  const NotificationEventsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Events'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            tooltip: 'Clear Events',
            onPressed: () {
              context.read<NotificationStateProvider>().clear();
            },
          ),
        ],
      ),
      body: Consumer<NotificationStateProvider>(
        builder: (context, provider, child) {
          if (provider.notificationEvents.isEmpty) {
            return const Center(
              child: Text('No notification events yet'),
            );
          }

          return ListView.builder(
            itemCount: provider.notificationEvents.length,
            itemBuilder: (context, index) {
              final event = provider.notificationEvents[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  title: Text('Source: ${event['source']}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),
                      Text('Payload: ${event['payload']}'),
                      const SizedBox(height: 4),
                      Text(
                        'Time: ${event['timestamp']}',
                        style:
                            const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'JSON: ${jsonEncode(event)}',
                        style: const TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 11,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                  isThreeLine: true,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
