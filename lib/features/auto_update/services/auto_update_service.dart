import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_phone_rules_protocol/pyro_phone_rules_protocol.dart';
import 'package:yourcallyourrule/features/phone/services/phone_subscription_service.dart';
import 'package:yourcallyourrule/features/sms/services/sms_subscription_service.dart';
import 'package:yourcallyourrule/features/contacts/services/contact_subscription_service.dart';
import 'package:yourcallyourrule/features/plugin/services/plugin_manager_service.dart';
import 'package:yourcallyourrule/features/auto_update/services/auto_update_config.dart';
import 'package:yourcallyourrule/features/config/data/repositories/config_repository.dart';

final autoUpdateServiceProvider = Provider<AutoUpdateService>((ref) {
  final phoneService = ref.watch(phoneSubscriptionServiceProvider);
  final smsService = ref.watch(smsSubscriptionServiceProvider);
  final contactService = ref.watch(contactSubscriptionServiceProvider);
  final pluginService = ref.watch(pluginManagerServiceProvider);
  final configRepository = ref.watch(configRepositoryProvider);

  return AutoUpdateService(
    phoneService: phoneService,
    smsService: smsService,
    contactService: contactService,
    pluginService: pluginService,
    configRepository: configRepository,
  );
});

class AutoUpdateService {
  final PhoneSubscriptionService _phoneService;
  final SmsSubscriptionService _smsService;
  final ContactSubscriptionService _contactService;
  final PluginManagerService _pluginService;
  final AutoUpdateConfig _config;

  AutoUpdateService({
    required PhoneSubscriptionService phoneService,
    required SmsSubscriptionService smsService,
    required ContactSubscriptionService contactService,
    required PluginManagerService pluginService,
    required ConfigRepository configRepository,
  })  : _phoneService = phoneService,
        _smsService = smsService,
        _contactService = contactService,
        _pluginService = pluginService,
        _config = AutoUpdateConfig(configRepository: configRepository);

  Future<bool> shouldUpdate() async {
    final lastUpdate = await _config.getLastUpdateTime();
    if (lastUpdate == null) return true;

    final interval = await _config.getGlobalUpdateInterval();
    final nextUpdate = lastUpdate.add(Duration(days: interval));
    return DateTime.now().isAfter(nextUpdate);
  }

  Future<List<PhoneRuleEntity>> updateAll() async {
    final results = <PhoneRuleEntity>[];

    try {
      final phoneSubs = await _phoneService.getEnabledSubscriptions();
      for (final sub in phoneSubs) {
        await _phoneService.importAndSaveRulesFromSubscription(sub);
      }
    } catch (e) {
      debugPrint('更新电话订阅失败: $e');
    }

    try {
      final smsSubs = await _smsService.getEnabledSubscriptions();
      for (final sub in smsSubs) {
        await _smsService.performManualUpdate(sub);
      }
    } catch (e) {
      debugPrint('更新短信订阅失败: $e');
    }

    try {
      final contactSubs = await _contactService.getEnabledSubscriptions();
      for (final sub in contactSubs) {
        await _contactService.performManualUpdate(sub);
      }
    } catch (e) {
      debugPrint('更新联系人订阅失败: $e');
    }

    await _updateLastUpdateTime();

    return results;
  }

  Future<List<PhoneRuleEntity>> updateByType(String type) async {
    return await updateAll();
  }

  Future<void> _updateLastUpdateTime() async {
    await _config.saveLastUpdateTime();
  }

  Future<int> getUserUpdateInterval(String type) async {
    return await _config.getUserUpdateInterval(type);
  }

  Future<void> setUserUpdateInterval(String type, int days) async {
    await _config.saveUserUpdateInterval(type, days);
  }
}
