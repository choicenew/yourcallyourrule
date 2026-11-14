import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:live_activity_kit/live_activity_kit.dart';
import 'package:pyro_ads_hub/pyro_ads_hub.dart';
import 'package:yourcallyourrule/features/call/live_activities/providers/live_notification_config_provider.dart';

import 'package:uuid/uuid.dart';

class LiveActivitiesTestPage extends ConsumerStatefulWidget {
  const LiveActivitiesTestPage({super.key});

  @override
  ConsumerState<LiveActivitiesTestPage> createState() => _LiveActivitiesTestPageState();
}

class _LiveActivitiesTestPageState extends ConsumerState<LiveActivitiesTestPage> {
  String? _activityId;
  String _status = "Ready to send.";
  final _uuid = const Uuid();

  @override
  void initState() {
    super.initState();
  }

  Future<void> _sendLiveActivity() async {
    setState(() {
      _status = "Generating payload and sending...";
    });

    final asyncConfig = ref.read(liveNotificationConfigProvider);
    if (!asyncConfig.hasValue) {
      setState(() { _status = "Error: Config is not loaded."; });
      return;
    }

    try {
      if (_activityId != null) {
        await LiveActivity.update(
          id: _activityId!,
          lockScreen: LA.text("Caller ID Notification - Incoming Call"),
        );
        setState(() {
          _status = "Successfully updated activity with ID:\n$_activityId";
        });
      } else {
        final newActivityId = _uuid.v4();
        await LiveActivity.show(
          id: newActivityId,
          lockScreen: LA.text("Caller ID Notification - Incoming Call"),
        );
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

  Future<void> _endLiveActivity() async {
    if (_activityId == null) {
      setState(() { _status = "No active activity to end."; });
      return;
    }

    try {
      await LiveActivity.end(id: _activityId!);
      setState(() {
        _status = "Successfully ended activity with ID:\n$_activityId";
        _activityId = null;
      });
    } catch (e) {
      setState(() {
        _status = "Failed to end activity: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Live Activities Test'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Status',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(_status),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _sendLiveActivity,
              child: Text(_activityId == null ? 'Send Test Live Activity' : 'Update Live Activity'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: _activityId == null ? null : _endLiveActivity,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
              child: const Text('End Live Activity'),
            ),
            const SizedBox(height: 24),
            const AdsInlineBanner(),
          ],
        ),
      ),
    );
  }
}
