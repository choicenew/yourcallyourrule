import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_ads_hub/pyro_ads_hub.dart';
import 'package:pyro_phone_call_interception_policy_protocol/pyro_phone_call_interception_policy_protocol.dart';
import 'package:pyro_phone_call_interception_policy_ui/pyro_phone_call_interception_policy_ui.dart' hide AppLocalizations;
import 'package:yourcallyourrule/features/phone_evaluators/config/intercept_action_config_provider.dart';
import 'package:yourcallyourrule/features/phone_evaluators/config/label_action_config_provider.dart';
import 'package:yourcallyourrule/features/phone_evaluators/config/emergency_policy_config_provider.dart';
import 'package:yourcallyourrule/features/phone_evaluators/evaluators/emergency_call_policy_service.dart';
import 'package:yourcallyourrule/features/labels/utils/predefined_labels.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

class EndCallSettingsPage extends ConsumerWidget {
  const EndCallSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedInterceptAction = ref.watch(interceptActionConfigProvider);
    final interceptActionNotifier = ref.read(interceptActionConfigProvider.notifier);
    final labelActionMap = ref.watch(labelActionConfigProvider);
    final labelActionNotifier = ref.read(labelActionConfigProvider.notifier);
    final emergencyConfig = ref.watch(emergencyPolicyConfigProvider);
    final emergencyPolicyService = ref.read(emergencyCallPolicyServiceProvider);
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    final cardTitle = l10n.interceptionActionSettingsTitle;
    final cardSubtitle = l10n.labelActionPolicySubtitle;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          l10n.interceptionActionSettingsTitle,
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
                  // 1. 全局默认拦截动作设置
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
                              l10n.incomingCallInterceptAction,
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: theme.colorScheme.onSurface),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          l10n.chooseDefaultInterceptAction,
                          style: TextStyle(fontSize: 13, color: theme.colorScheme.onSurfaceVariant),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primaryContainer.withValues(alpha: 0.35),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: theme.colorScheme.primary.withValues(alpha: 0.2)),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Icons.info_outline_rounded, size: 16, color: theme.colorScheme.primary),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  l10n.incomingCallScenarioDescription,
                                  style: TextStyle(fontSize: 12, color: theme.colorScheme.onPrimaryContainer, height: 1.35),
                                ),
                              ),
                            ],
                          ),
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
                                  child: Text(l10n.endCallImmediately, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: theme.colorScheme.onSurface)),
                                ),
                                DropdownMenuItem<InterceptAction>(
                                  value: InterceptAction.answerThenHangup,
                                  child: Text(l10n.answerThenHangup, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: theme.colorScheme.onSurface)),
                                ),
                                DropdownMenuItem<InterceptAction>(
                                  value: InterceptAction.silenceNoAnswer,
                                  child: Text(l10n.silenceAndNoAnswer, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: theme.colorScheme.onSurface)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // 2. 挂载微包自闭环的按标签自定义动作矩阵视图 (UI 100% 封装在微包内部)
                  LabelActionPolicyMatrixView(
                    title: cardTitle,
                    subtitle: cardSubtitle,
                    labelActionMap: labelActionMap,
                    availableLabels: predefinedLabelEntities.map((e) => e.text).toList(),
                    quickAddLabels: const [
                      'Auto Warranty Scam',
                      'Voice Clone Scam',
                      'AI Robocall',
                      'Telemarketing',
                      'Robocall',
                      'Debt Collection',
                    ],
                    labelTranslator: (label) => label.translate(context),
                    actionTranslator: (action) {
                      if (action == InterceptAction.allow) {
                        return l10n.actionAllow;
                      } else if (action == InterceptAction.answerThenHangup) {
                        return l10n.answerThenHangup;
                      } else if (action == InterceptAction.silenceNoAnswer) {
                        return l10n.silenceAndNoAnswer;
                      }
                      return l10n.endCallImmediately;
                    },
                    onActionChanged: (label, action) {
                      labelActionNotifier.setActionForLabel(label, action);
                    },
                    onActionRemoved: (label) {
                      labelActionNotifier.removeActionForLabel(label);
                    },
                  ),

                  const SizedBox(height: 16),

                  // 3. 挂载微包自闭环的紧急呼叫放行防护卡片 (支持添加自定义地区紧急号码)
                  EmergencyExemptionPolicyCard(
                    config: emergencyConfig,
                    onConfigChanged: (newConfig) {
                      ref.read(emergencyPolicyConfigProvider.notifier).updateConfig(newConfig);
                    },
                    presetNumbers: emergencyPolicyService.presetNumbers,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            const AdsInlineBanner(),
          ],
        ),
      ),
    );
  }
}
