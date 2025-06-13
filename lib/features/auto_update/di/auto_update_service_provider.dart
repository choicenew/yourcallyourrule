import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/cloud_sync/provider/backup_restore_provider.dart';

import 'package:yourcallyourrule/core/provider/providers/contact_subscription_service_provider.dart';
import 'package:yourcallyourrule/core/provider/providers/phone_subscription_service_provider.dart';
import 'package:yourcallyourrule/core/provider/providers/plugin_manager_service_provider.dart';
import 'package:yourcallyourrule/core/provider/providers/sms_subscription_service_provider.dart';
import 'package:yourcallyourrule/core/services/auto_update_service.dart';
import 'package:yourcallyourrule/data/repositories/config/config_repository.dart';






/// 自动更新服务提供者
final autoUpdateServiceProvider = Provider<AutoUpdateService>((ref) {
  final phoneService = ref.read(phoneSubscriptionServiceProvider);
  final smsService = ref.read(smsSubscriptionServiceProvider);
  final contactService = ref.read(contactSubscriptionServiceProvider);
  final pluginService = ref.read(pluginManagerServiceProvider);
  final configRepository = ref.read(configRepositoryProvider);
  
  return AutoUpdateService(
    phoneService: phoneService,
    smsService: smsService,
    contactService: contactService,
    pluginService: pluginService,
    configRepository: configRepository,
  );
});