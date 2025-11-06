import 'package:flutter/material.dart';
import 'package:live_updates/live_updates.dart';
import 'package:live_updates/models/live_update_progress_data.dart';
import 'package:live_updates_example/customization_screen.dart';
import 'package:live_updates_example/notification_style.dart';
import 'caller_id_page.dart';
import 'download_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
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
    // 监听通知点击事件 (可选)
    LiveUpdates.notificationPayloadStream.listen((payload) {
      if (mounted && payload != null && payload.isNotEmpty) {
        final snackBar = SnackBar(content: Text('Received payload: $payload'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Live Updates Demo')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          // --- 演示 showNotification (可提升为 Live Update) ---
          const ListTile(
            title: Text('Standard Notifications', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            subtitle: Text('These can be promoted to Live Updates by the system.'),
          ),
          ElevatedButton(
            onPressed: () => LiveUpdates.showNotification(
              notificationId: 1,
              title: 'Big Text Style',
              text: 'This is a standard notification that can be promoted to a Live Update.',
              style: 'bigText',
              payload: 'big_text_payload',
            ),
            child: const Text("Show Big Text"),
          ),
          ElevatedButton(
            onPressed: () => LiveUpdates.showNotification(
              notificationId: 2,
              title: 'Incoming Call',
              text: 'John Doe',
              style: 'call',
              payload: 'call_style_payload',
            ),
            child: const Text("Show Call Style"),
          ),
          ElevatedButton(
            onPressed: () => LiveUpdates.showNotification(
              notificationId: 3,
              title: 'Simple Progress',
              text: 'Downloading...',
              style: 'progress',
              progress: 50,
              payload: 'simple_progress_payload',
            ),
            child: const Text("Show Simple Progress"),
          ),
          ElevatedButton(
            onPressed: () => LiveUpdates.showNotification(
              notificationId: 4,
              title: 'Android 15+ Live Update',
              text: 'Your ride is approaching',
              style: 'progress',
              progress: 60,
              payload: 'android_15_payload',
              progressSegments: [
                LiveUpdateSegment(progress: 30, color: Colors.green),
                LiveUpdateSegment(progress: 40, color: Colors.orange),
                LiveUpdateSegment(progress: 30, color: Colors.blue),
              ],
            ),
            child: const Text("Show Android 15+ Progress"),
          ),
          const Divider(height: 32),

          // --- 演示 showLayoutNotification (高优先级悬浮通知) ---
          const ListTile(
            title: Text('Custom Layout Notifications', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            subtitle: Text('These are high-priority Heads-Up notifications, NOT Live Updates.'),
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
                final newStyle = await Navigator.of(context).push<NotificationStyle>(
                  MaterialPageRoute(builder: (_) => CustomizationScreen(initialStyle: _customStyle)),
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
    );
  }
}