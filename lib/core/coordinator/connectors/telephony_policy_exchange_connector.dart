import 'package:dlibphonenumber/dlibphonenumber.dart' as dlib;
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_call_redirection_driver/pyro_call_redirection_driver.dart';
import 'package:pyro_call_redirection_protocol/pyro_call_redirection_protocol.dart';
import 'package:pyro_phone_marking_hub/pyro_phone_marking_hub.dart';
import 'package:yourcallyourrule/features/contacts/services/contact_service.dart';
import 'package:yourcallyourrule/features/labels/services/label_service.dart';
import 'package:yourcallyourrule/features/labels/services/predefined_label_service.dart';
import 'package:yourcallyourrule/features/labels/utils/predefined_labels.dart';
import 'package:yourcallyourrule/features/phone_caller_identity/services/caller_identity_service.dart';
import 'package:yourcallyourrule/features/phone_evaluators/config/intercept_action_config_provider.dart';
import 'package:yourcallyourrule/features/phone_evaluators/evaluators/call_policy_evaluator.dart';
import 'package:yourcallyourrule/features/phone_rules/services/rule_management_service.dart';
import 'package:yourcallyourrule/features/remote_filter/services/remote_number_service.dart';

class TelephonyPolicyExchangeConnector {
  final Ref ref;

  const TelephonyPolicyExchangeConnector({required this.ref});

  void initialize() {
    _setupCallerIdentityResolvers();
    _injectPredefinedLabelsToMarkingHub();
    _setupCallRedirectionOutboundEvaluator();
  }

  void _setupCallerIdentityResolvers() {
    try {
      final callerIdService = ref.read(callerIdentityServiceProvider);
      callerIdService.bindResolvers(
        contactResolver: (phone) => ref.read(contactServiceProvider).findContactByPhoneNumber(phone),
        rulesResolver: (phone) => ref.read(ruleManagementServiceProvider).getRulesByPhoneNumber(phone),
        labelResolver: (phone) => ref.read(labelServiceProvider).getLabelByPhoneNumber(phone),
        predefinedLabelResolver: (id) => ref.read(predefinedLabelServiceProvider).getLabelById(id),
        remoteNumberResolver: (phone) => ref.read(remoteNumberServiceProvider).getRemoteNumberByPhoneNumber(phone),
      );
      debugPrint('[TelephonyPolicyConnector] Bound all CallerIdentity Resolvers.');
    } catch (e) {
      debugPrint('[TelephonyPolicyConnector] Error binding CallerIdentity Resolvers: $e');
    }
  }

  void _injectPredefinedLabelsToMarkingHub() {
    try {
      MarkPhoneControlCenter.instance.registerPredefinedLabels(predefinedLabelEntities);
      debugPrint('[TelephonyPolicyConnector] Injected ${predefinedLabelEntities.length} predefined labels into MarkPhoneControlCenter.');
    } catch (e) {
      debugPrint('[TelephonyPolicyConnector] Error injecting predefined labels: $e');
    }
  }

  void _setupCallRedirectionOutboundEvaluator() {
    try {
      CallRedirectionDriver.outboundEvaluator = (outgoingCall) async {
        final phone = outgoingCall.normalizedPhoneNumber.isNotEmpty
            ? outgoingCall.normalizedPhoneNumber
            : outgoingCall.rawPhoneNumber;

        final callerId = await ref.read(callerIdentityServiceProvider).getCallerId(phone, dlib.Locale.english);
        final defaultAction = ref.read(interceptActionConfigProvider);

        final evaluator = ref.read(callPolicyEvaluatorProvider);
        final context = CallPolicyContext(
          phoneNumber: phone,
          labels: callerId.labels,
          defaultInterceptAction: defaultAction,
        );

        final verdict = evaluator.evaluate(context);
        if (verdict.shouldBlock) {
          debugPrint('[CallRedirection] Outbound call blocked by CallPolicyEvaluator: $phone (${verdict.reason})');
          return RedirectionDecision(
            action: RedirectionAction.block,
            reason: RedirectionHoldReason.databaseMatch,
            description: verdict.reason,
          );
        }
        return RedirectionDecision.proceed;
      };
      debugPrint('[TelephonyPolicyConnector] Mounted CallPolicyEvaluator to CallRedirectionDriver.');
    } catch (e) {
      debugPrint('[TelephonyPolicyConnector] Error mounting CallRedirection outbound evaluator: $e');
    }
  }
}

