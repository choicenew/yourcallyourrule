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
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.interceptionActionSettingsTitle,
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20, color: theme.colorScheme.onSurface),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        foregroundColor: theme.colorScheme.onSurface,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, size: 20, color: theme.colorScheme.onSurface),
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
                      color: theme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: theme.colorScheme.outlineVariant,
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
                                color: theme.colorScheme.error.withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(Icons.call_end_rounded, color: theme.colorScheme.error, size: 20),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              AppLocalizations.of(context)!.incomingCallInterceptAction,
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: theme.colorScheme.onSurface),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          AppLocalizations.of(context)!.chooseDefaultInterceptAction,
                          style: TextStyle(fontSize: 13, color: theme.colorScheme.onSurfaceVariant),
                        ),
                        const SizedBox(height: 14),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.surfaceContainerHighest,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: theme.colorScheme.outlineVariant, width: 1.1),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<InterceptAction>(
                              value: selectedInterceptAction,
                              isExpanded: true,
                              icon: Icon(Icons.keyboard_arrow_down_rounded, color: theme.colorScheme.primary),
                              onChanged: (InterceptAction? newValue) {
                                if (newValue != null) {
                                  interceptActionNotifier.setInterceptAction(newValue);
                                }
                              },
                              items: <DropdownMenuItem<InterceptAction>>[
                                DropdownMenuItem<InterceptAction>(
                                  value: InterceptAction.endCall,
                                  child: Text(AppLocalizations.of(context)!.endCallImmediately, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: theme.colorScheme.onSurface)),
                                ),
                                DropdownMenuItem<InterceptAction>(
                                  value: InterceptAction.answerThenHangup,
                                  child: Text(AppLocalizations.of(context)!.answerThenHangup, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: theme.colorScheme.onSurface)),
                                ),
                                DropdownMenuItem<InterceptAction>(
                                  value: InterceptAction.silenceNoAnswer,
                                  child: Text(AppLocalizations.of(context)!.silenceAndNoAnswer, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: theme.colorScheme.onSurface)),
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
