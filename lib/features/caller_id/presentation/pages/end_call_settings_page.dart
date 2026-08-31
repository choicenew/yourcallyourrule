import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/ads/ad_manager.dart';
import 'package:yourcallyourrule/ads/adwidgets/inline_adaptive_ad.dart';
import 'package:yourcallyourrule/features/caller_id/config/intercept_action.dart';
import 'package:yourcallyourrule/features/caller_id/config/intercept_action_config_provider.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

class EndCallSettingsPage extends ConsumerWidget {
  const EndCallSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedInterceptAction = ref.watch(interceptActionConfigProvider);
    final interceptActionNotifier = ref.read(interceptActionConfigProvider.notifier);

    return Scaffold(
      backgroundColor: const Color(0xFFFFFBF5),
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.interceptionActionSettingsTitle,
          style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 20, color: Colors.black87),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        foregroundColor: Colors.black87,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20, color: Colors.black87),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: const Color(0xFFEDE8DF),
                        width: 1.1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.03),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFF4B4B).withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(Icons.call_end_rounded, color: Color(0xFFFF4B4B), size: 20),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              AppLocalizations.of(context)!.incomingCallInterceptAction,
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Colors.black87),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          AppLocalizations.of(context)!.chooseDefaultInterceptAction,
                          style: const TextStyle(fontSize: 13, color: Colors.grey),
                        ),
                        const SizedBox(height: 14),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF7F5F0),
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: const Color(0xFFEDE8DF), width: 1.1),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<InterceptAction>(
                              value: selectedInterceptAction,
                              isExpanded: true,
                              icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Color(0xFFFF9500)),
                              onChanged: (InterceptAction? newValue) {
                                if (newValue != null) {
                                  interceptActionNotifier.setInterceptAction(newValue);
                                }
                              },
                              items: <DropdownMenuItem<InterceptAction>>[
                                DropdownMenuItem<InterceptAction>(
                                  value: InterceptAction.endCall,
                                  child: Text(AppLocalizations.of(context)!.endCallImmediately, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
                                ),
                                DropdownMenuItem<InterceptAction>(
                                  value: InterceptAction.answerThenHangup,
                                  child: Text(AppLocalizations.of(context)!.answerThenHangup, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
                                ),
                                DropdownMenuItem<InterceptAction>(
                                  value: InterceptAction.silenceNoAnswer,
                                  child: Text(AppLocalizations.of(context)!.silenceAndNoAnswer, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            InlineAdaptiveBannerAdWidget(adInfo: AdManager.bannerAd, width: 400),
          ],
        ),
      ),
    );
  }
}