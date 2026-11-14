import 'package:flutter/foundation.dart';

// === All 33 Package Suite Connectors ===
import 'package:pyro_app_launch_guard/pyro_app_launch_guard.dart';
import 'package:pyro_telephony_connector/pyro_telephony_connector.dart';
import 'package:pyro_call_redirection_connector/pyro_call_redirection_connector.dart';
import 'package:pyro_call_screening_connector/pyro_call_screening_connector.dart';
import 'package:pyro_phone_location_connector/pyro_phone_location_connector.dart';
import 'package:pyro_phone_sim_slot_rules_connector/pyro_phone_sim_slot_rules_connector.dart';
import 'package:pyro_phone_call_interception_policy_connector/pyro_phone_call_interception_policy_connector.dart';
import 'package:pyro_phone_time_interceptor_connector/pyro_phone_time_interceptor_connector.dart';
import 'package:pyro_phone_lookup_plugin_connector/pyro_phone_lookup_plugin_connector.dart';
import 'package:pyro_phone_subscription_connector/pyro_phone_subscription_connector.dart';
import 'package:pyro_phone_rules_connector/pyro_phone_rules_connector.dart';
import 'package:pyro_phone_count_filter_connector/pyro_phone_count_filter_connector.dart';
import 'package:pyro_phone_remote_filter_connector/pyro_phone_remote_filter_connector.dart';
import 'package:pyro_phone_call_history_connector/pyro_phone_call_history_connector.dart';
import 'package:pyro_phone_live_activities_connector/pyro_phone_live_activities_connector.dart';
import 'package:pyro_phone_call_overlay_connector/pyro_phone_call_overlay_connector.dart';
import 'package:pyro_phone_call_statistic_connector/pyro_phone_call_statistic_connector.dart';
import 'package:pyro_phone_country_sync_connector/pyro_phone_country_sync_connector.dart';
import 'package:pyro_phone_contacts_connector/pyro_phone_contacts_connector.dart';
import 'package:pyro_app_auto_update_connector/pyro_app_auto_update_connector.dart';
import 'package:pyro_phone_call_filter_connector/pyro_phone_call_filter_connector.dart';
import 'package:pyro_phone_caller_identity_connector/pyro_phone_caller_identity_connector.dart';
import 'package:pyro_phone_call_monitor_connector/pyro_phone_call_monitor_connector.dart';
import 'package:pyro_phone_call_coordinator_connector/pyro_phone_call_coordinator_connector.dart';
import 'package:pyro_phone_marking_connector/pyro_phone_marking_connector.dart';
import 'package:pyro_sim_connector/pyro_sim_connector.dart';

/// 全量 33 个微包外观装配线独立初始化入口
void initPackageConnectors() {
  SimConnectors.ensureMounted();
  TelephonyConnectors.ensureMounted();
  CallRedirectionConnectors.ensureMounted();
  CallScreeningConnectors.ensureMounted();
  SimSlotRuleConnector.registerAll();
  PyroPhoneLocationConnector.registerAll();
  PyroCallInterceptionPolicyConnector.registerAll();
  PyroTimeInterceptorConnector.registerAll();
  PyroPhoneLookupPluginConnector.registerAll();
  PyroPhoneSubscriptionConnector.registerAll();
  PyroPhoneRulesConnector.registerAll();
  PyroPhoneCountFilterConnector.registerAll();
  PyroPhoneRemoteFilterConnector.registerAll();
  PyroPhoneCallHistoryConnector.registerAll();
  PyroPhoneLiveActivitiesConnector.registerAll();
  PyroPhoneCallOverlayConnector.registerAll();
  PyroPhoneCallStatisticConnector.registerAll();
  PyroPhoneCountrySyncConnector.registerAll();
  PyroPhoneContactsConnector.registerAll();
  PyroAppAutoUpdateConnector.registerAll();
  PyroCallFilterConnector.registerAll();
  PyroCallerIdentityConnector.registerAll();
  PyroCallMonitorConnector.registerAll();
  PyroCallCoordinatorConnector.registerAll();
  PyroPhoneMarkingConnector.registerAll();
  debugPrint('[PackageConnectors] 33 个 Package Suite Connector 全外观自注册装配完成');
}
