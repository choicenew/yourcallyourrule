import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/features/call/call_overlay/mock_data/call_overlay_mock.dart';
import 'package:yourcallyourrule/features/call_coordinator/handlers/kit_live_activity_handler.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

class KitLiveActivitiesTestPage extends ConsumerStatefulWidget {
  const KitLiveActivitiesTestPage({super.key});

  @override
  ConsumerState<KitLiveActivitiesTestPage> createState() =>
      _KitLiveActivitiesTestPageState();
}

class _KitLiveActivitiesTestPageState
    extends ConsumerState<KitLiveActivitiesTestPage> {
  String _status = "Live Activity is inactive";
  bool _isActive = false;

  Future<void> _startLiveActivity() async {
    try {
      final handler = await ref.read(kitLiveActivityHandlerProvider.future);
      final mockData = CallOverlayMockData.mockCallerIdData();
      final mockSimInfo = CallOverlayMockData.mockSimInfoData();
      final mockStirInfo = CallOverlayMockData.mockStirInfoData();

      await handler.showCallerIdActivity(
        callerIdData: mockData,
        simCardData: mockSimInfo,
        stirData: mockStirInfo,
      );

      setState(() {
        _isActive = true;
        _status =
            "Live Activity Active: [${mockData.name ?? 'Unknown'}]\n${mockData.phoneNumber}";
      });
    } catch (e) {
      setState(() {
        _status = "Failed: $e";
      });
    }
  }

  Future<void> _endLiveActivity() async {
    try {
      final handler = await ref.read(kitLiveActivityHandlerProvider.future);
      await handler.endActivity();
      setState(() {
        _isActive = false;
        _status = "Live Activity has ended";
      });
    } catch (e) {
      setState(() {
        _status = "Failed to end: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).liveActivitiesTestTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Icon(
                      _isActive
                          ? Icons.notifications_active
                          : Icons.notifications_off,
                      size: 48,
                      color: _isActive ? Colors.green : Colors.grey,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      _status,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: _isActive ? null : _startLiveActivity,
              icon: const Icon(Icons.play_arrow),
              label: const Text('Start Live Activity'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _isActive ? _endLiveActivity : null,
              icon: const Icon(Icons.stop),
              label: const Text('Stop Live Activity'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
