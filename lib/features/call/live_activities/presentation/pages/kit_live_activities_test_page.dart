library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_ads_hub/pyro_ads_hub.dart';
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
  bool _isActive = false;
  String _status = "Ready to test Live Activity & Dynamic Island.";

  Future<void> _sendLiveActivity() async {
    setState(() {
      _status = "Sending Live Activity...";
    });

    try {
      final handler = await ref.read(kitLiveActivityHandlerProvider.future);
      final mockData = CallOverlayMockData.mockCallerIdData();
      final mockSimInfo = CallOverlayMockData.mockSimInfoData();
      final mockStirInfo = CallOverlayMockData.mockStirInfoData();

      await handler.showCallerIdActivity(
        callerIdData: mockData,
        simInfo: mockSimInfo,
        stirInfo: mockStirInfo,
      );

      setState(() {
        _isActive = true;
        _status =
            "Live Activity Active: [${mockData.name ?? 'Unknown'}]\n${mockData.phoneNumber.value}";
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
        _status = "Live Activity ended.";
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
        title: Text(AppLocalizations.of(context)!.liveActivitiesTestTitle),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(Icons.notifications_active,
                  size: 50, color: Colors.blue),
              const SizedBox(height: 15),
              Text(
                AppLocalizations.of(context)!.liveActivityControlsTitle,
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
                child: SelectableText(
                  _status,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontFamily: 'monospace'),
                ),
              ),
              const SizedBox(height: 15),
              ElevatedButton.icon(
                icon: const Icon(Icons.send),
                label: Text(
                  !_isActive
                      ? AppLocalizations.of(context)!
                          .liveActivitiesTestSendNewActivity
                      : AppLocalizations.of(context)!
                          .liveActivitiesTestUpdateActivity,
                ),
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
                label: Text(
                  AppLocalizations.of(context)!.liveActivitiesTestEndActivity,
                ),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: !_isActive ? null : _endLiveActivity,
              ),
              const SizedBox(height: 15),
              Text(
                AppLocalizations.of(context)!.notification_instructions,
                textAlign: TextAlign.center,
                style:
                    const TextStyle(color: Color.fromARGB(255, 117, 117, 117)),
              ),
              const SizedBox(height: 12),
              const AdsInlineBanner(),
            ],
          ),
        ),
      ),
    );
  }
}
