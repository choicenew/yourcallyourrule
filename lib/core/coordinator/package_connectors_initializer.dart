import 'package:flutter/foundation.dart';
import 'package:pyro_cloud_drive_hub/pyro_cloud_drive_hub.dart';
import 'package:pyro_cloud_drive_googledrive/pyro_cloud_drive_googledrive.dart';
import 'package:pyro_cloud_drive_onedrive/pyro_cloud_drive_onedrive.dart';
import 'package:pyro_cloud_drive_webdav/pyro_cloud_drive_webdav.dart';

// === All 33 Package Suite Connectors ===
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
import 'package:pyro_stir_connector/pyro_stir_connector.dart';
import 'package:pyro_sms_connector/pyro_sms_connector.dart';
import 'package:pyro_sms_hub/pyro_sms_hub.dart';
import 'package:pyro_sms_driver_burst_protection/pyro_sms_driver_burst_protection.dart';
import 'package:pyro_sms_driver_google_safe_browsing/pyro_sms_driver_google_safe_browsing.dart';
import 'package:pyro_sms_driver_phishtank/pyro_sms_driver_phishtank.dart';
import 'package:pyro_sms_driver_virustotal/pyro_sms_driver_virustotal.dart';
import 'package:pyro_sms_driver_regex_rules/pyro_sms_driver_regex_rules.dart';
import 'package:yourcallyourrule/features/commercial/services/commercial_service.dart';

import 'filter_ui_registry.dart';

/// 全量 33 个微包外观装配线独立初始化入口
void initPackageConnectors() {
  SimConnectors.ensureMounted();
  StirConnectors.ensureMounted();
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
  CommercialService.instance.initialize();

  // 短信微包体系驱动统一装配
  SmsConnectors.ensureMounted();
  SmsHub.instance.registerBurstProtection(SmsBurstProtectionDriver());
  SmsHub.instance.registerLinkThreatAdapter(GoogleSafeBrowsingDriver());
  SmsHub.instance.registerLinkThreatAdapter(PhishTankDriver());
  SmsHub.instance.registerLinkThreatAdapter(VirusTotalDriver());
  SmsHub.instance.registerFilter(RegexRulesDriver());

  // 注册主 App 胶水层 Filter UI 动态注册工厂
  FilterUiRegistry.init();

  // 云盘 3 大 Driver 启动同步强行注册
  CloudDriveHub.instance.configureHostContext(
    appName: 'YourCallYourRule',
    encryptionHeaderTag: 'YOURCALL_ENC_V1',
  );
  try {
    CloudDriveHub.instance.register(GoogleDriveAdapter(), uiConfig: GoogleDriveAdapter.uiConfig);
    CloudDriveHub.instance.register(OneDriveDriveAdapter(), uiConfig: OneDriveDriveAdapter.uiConfig);
    CloudDriveHub.instance.register(WebDAVDriveAdapter(), uiConfig: WebDAVDriveAdapter.uiConfig);
  } catch (e) {
    debugPrint('[PackageConnectors] CloudDrive Drivers register error: $e');
  }

  debugPrint('[PackageConnectors] 33 个 Package Suite Connector 全外观自注册装配完成');
}
