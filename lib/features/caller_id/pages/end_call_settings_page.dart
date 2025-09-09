import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/ads/ad_manager.dart';
import 'package:yourcallyourrule/ads/adwidgets/inline_adaptive_ad.dart';
import 'package:yourcallyourrule/features/caller_id/config/intercept_action_config_provider.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

class EndCallSettingsPage extends ConsumerWidget {
  const EndCallSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedInterceptAction = ref.watch(interceptActionConfigProvider);
    final interceptActionNotifier = ref.read(interceptActionConfigProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.interceptionActionSettingsTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Text(
                    AppLocalizations.of(context)!.incomingCallInterceptAction,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(AppLocalizations.of(context)!.chooseDefaultInterceptAction),
                  const SizedBox(height: 8),
                  DropdownButton<String>(
                    value: selectedInterceptAction,
                    isExpanded: true,
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        interceptActionNotifier.setInterceptAction(newValue);
                      }
                    },
                    items: <DropdownMenuItem<String>>[
                      DropdownMenuItem<String>(
                        value: 'endCall',
                        child: Text(AppLocalizations.of(context)!.endCallImmediately),
                      ),
                      DropdownMenuItem<String>(
                        value: 'answerThenHangup',
                        child: Text(AppLocalizations.of(context)!.answerThenHangup),
                      ),
                      DropdownMenuItem<String>(
                        value: 'silenceNoAnswer',
                        child: Text(AppLocalizations.of(context)!.silenceAndNoAnswer),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            InlineAdaptiveBannerAdWidget(adInfo: AdManager.bannerAd, width: 400),
          ],
        ),
      ),
    );
  }
}