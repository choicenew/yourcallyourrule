// lib/features/call/live_activities/ui/live_activities_test_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:live_activities/live_activities.dart';
import 'package:yourcallyourrule/features/call/caller_id/mock_data/caller_id_mock.dart';
import 'package:yourcallyourrule/features/call/live_activities/providers/live_notification_config_provider.dart';
import 'package:yourcallyourrule/features/call/live_activities/services/notification_payload_builder.dart';

import 'package:uuid/uuid.dart'; // 导入 uuid 库来生成唯一的活动ID



class LiveActivitiesTestPage extends ConsumerStatefulWidget {
  const LiveActivitiesTestPage({super.key});

  @override
  ConsumerState<LiveActivitiesTestPage> createState() => _LiveActivitiesTestPageState();
}

class _LiveActivitiesTestPageState extends ConsumerState<LiveActivitiesTestPage> {
  final _liveActivitiesPlugin = LiveActivities();
  String? _activityId; // 这个ID现在由我们自己生成和管理
  String _status = "Ready to send.";
  final _uuid = const Uuid(); // Uuid 生成器实例

  @override
  void initState() {
    super.initState();
    // 确保插件已初始化
    _liveActivitiesPlugin.init(appGroupId: "group.com.yours.yourcallyourrule"); // <-- 请看下面的解释
  }

  /// 发送一个真实的 Live Activity 通知
  Future<void> _sendLiveActivity() async {
    setState(() {
      _status = "Generating payload and sending...";
    });

    final asyncConfig = ref.read(liveNotificationConfigProvider);
    if (!asyncConfig.hasValue) {
      setState(() { _status = "Error: Config is not loaded."; });
      return;
    }
    final config = asyncConfig.value!;
    final mockData = CallerIdMockData.mockCallerIdData();
    final mockSimInfo = CallerIdMockData.mockSimInfoData();
    final mockStirInfo = CallerIdMockData.mockStirInfoData();

    try {
      final payload = await LiveNotificationPayloadBuilder.build(config, mockData, mockSimInfo, mockStirInfo);

      if (_activityId != null) {
        // --- API 修正：updateActivity 需要 activityId 和 data ---
        await _liveActivitiesPlugin.updateActivity(_activityId!, payload);
        setState(() {
          _status = "Successfully updated activity with ID:\n$_activityId";
        });
      } else {
        // --- API 修正：createActivity 需要一个我们自己生成的唯一 ID ---
        final newActivityId = _uuid.v4(); // 生成一个唯一的ID
        await _liveActivitiesPlugin.createActivity(newActivityId, payload);
        setState(() {
          _activityId = newActivityId;
          _status = "Successfully created activity with ID:\n$newActivityId";
        });
      }

    } catch (e) {
      setState(() {
        _status = "Failed to send/update activity: $e";
      });
    }
  }

  /// 结束当前的 Live Activity
  Future<void> _endLiveActivity() async {
    if (_activityId == null) {
      setState(() { _status = "No active activity to end."; });
      return;
    }
    try {
      // --- API 用法本身是正确的，保持不变 ---
      await _liveActivitiesPlugin.endActivity(_activityId!);
      setState(() {
        _status = "Successfully ended activity with ID:\n$_activityId";
        _activityId = null; // 清除ID
      });
    } catch (e) {
      setState(() {
        _status = "Failed to end activity: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // ... UI部分的代码保持不变 ...
    return Scaffold(
      appBar: AppBar(
        title: const Text('Live Activities Test Sender'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(Icons.notifications_active, size: 80, color: Colors.blue),
              const SizedBox(height: 24),
              Text(
                'Live Activity Control',
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: SelectableText( // 使用 SelectableText 方便复制ID
                  _status,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontFamily: 'monospace'),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                icon: const Icon(Icons.send),
                label: Text(_activityId == null ? 'SEND NEW ACTIVITY' : 'UPDATE ACTIVITY'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
                onPressed: _sendLiveActivity,
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                icon: const Icon(Icons.cancel),
                label: const Text('END ACTIVITY'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: _activityId == null ? null : _endLiveActivity,
              ),
              const SizedBox(height: 40),
              const Text(
                'Instructions:\n1. Tap "SEND" to create or update a notification.\n2. Go to your home screen or pull down the notification tray to see the result.\n3. Tap "END" to dismiss the notification.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Color.fromARGB(255, 117, 117, 117)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}