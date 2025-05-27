import 'package:yourcallyourrule/core/entities/rule/rule_base.dart';
import 'package:yourcallyourrule/features/phone/services/phone_subscription_service.dart';
import 'package:yourcallyourrule/features/sms/services/sms_subscription_service.dart';
import 'package:yourcallyourrule/features/contacts/services/contact_subscription_service.dart';
import 'package:yourcallyourrule/features/plugin/services/plugin_manager_service.dart';
import 'package:yourcallyourrule/core/services/auto_update_config.dart';
import 'package:yourcallyourrule/data/repositories/config/config_repository.dart';

/// 自动更新服务
/// 负责整合多种订阅服务的自动更新功能
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
  }) : _phoneService = phoneService,
       _smsService = smsService,
       _contactService = contactService,
       _pluginService = pluginService,
       _config = AutoUpdateConfig(configRepository: configRepository);

  /// 更新所有启用的订阅规则
  /// 返回更新的规则列表
  Future<List<RuleBase>> updateAll() async {
    final results = <RuleBase>[];
    
    // 更新电话订阅
    try {
      final phoneSubs = await _phoneService.getEnabledSubscriptions();
      for (final sub in phoneSubs) {
        results.addAll(await _phoneService.updateRulesFromSubscription(sub));
      }
    } catch (e) {
      print('更新电话订阅失败: $e');
    }

    // 更新短信订阅
    try {
      final smsSubs = await _smsService.getEnabledSubscriptions();
      for (final sub in smsSubs) {
        results.addAll(await _smsService.updateRulesFromSubscription(sub));
      }
    } catch (e) {
      print('更新短信订阅失败: $e');
    }

    // 更新联系人订阅
    try {
      final contactSubs = await _contactService.getEnabledSubscriptions();
      for (final sub in contactSubs) {
        results.addAll(await _contactService.updateRulesFromSubscription(sub));
      }
    } catch (e) {
      print('更新联系人订阅失败: $e');
    }

    // 更新插件
    try {
      await _pluginService.updatePlugins();
    } catch (e) {
      print('更新插件失败: $e');
    }

    // 更新最后更新时间
    await _updateLastUpdateTime();

    return results;
  }

  /// 根据服务类型更新特定类型的订阅
  /// [serviceType] 服务类型: 'phone', 'sms', 'contact', 'plugin'
  Future<List<RuleBase>> updateByType(String serviceType) async {
    final results = <RuleBase>[];
    
    switch (serviceType) {
      case 'phone':
        try {
          final subs = await _phoneService.getEnabledSubscriptions();
          for (final sub in subs) {
            results.addAll(await _phoneService.updateRulesFromSubscription(sub));
          }
        } catch (e) {
          print('更新电话订阅失败: $e');
        }
        break;
      
      case 'sms':
        try {
          final subs = await _smsService.getEnabledSubscriptions();
          for (final sub in subs) {
            results.addAll(await _smsService.updateRulesFromSubscription(sub));
          }
        } catch (e) {
          print('更新短信订阅失败: $e');
        }
        break;
      
      case 'contact':
        try {
          final subs = await _contactService.getEnabledSubscriptions();
          for (final sub in subs) {
            results.addAll(await _contactService.updateRulesFromSubscription(sub));
          }
        } catch (e) {
          print('更新联系人订阅失败: $e');
        }
        break;
      
      case 'plugin':
        try {
          await _pluginService.updatePlugins();
        } catch (e) {
          print('更新插件失败: $e');
        }
        break;
      
      default:
        throw ArgumentError('不支持的服务类型: $serviceType');
    }

    // 更新最后更新时间
    await _updateLastUpdateTime(serviceType: serviceType);

    return results;
  }

  /// 检查是否需要更新
  /// [serviceType] 可选的服务类型，如果不提供则检查所有类型
  /// [updateInterval] 可选的更新间隔，如果不提供则使用默认值
  Future<bool> shouldUpdate({String? serviceType, Duration? updateInterval}) async {
    // 获取默认更新间隔（以天为单位）
    final defaultIntervals = {
      'phone': const Duration(days: 1),
      'sms': const Duration(days: 1),
      'contact': const Duration(days: 1),
      'plugin': const Duration(days: 7),
    };
    
    if (serviceType != null) {
      // 检查特定服务类型
      final lastUpdated = await _config.getLastUpdateTime(serviceType);
      
      // 获取用户自定义的更新间隔
      final userIntervalDays = await _config.getUserUpdateIntervalDays(serviceType);
      final interval = userIntervalDays != null
          ? Duration(days: userIntervalDays)
          : (updateInterval ?? defaultIntervals[serviceType] ?? const Duration(days: 1));
      
      if (lastUpdated == null) return true;
      
      final durationSinceLastUpdate = DateTime.now().difference(lastUpdated);
      return durationSinceLastUpdate >= interval;
    } else {
      // 检查所有服务类型
      for (final type in defaultIntervals.keys) {
        final shouldUpdateThis = await shouldUpdate(serviceType: type, updateInterval: updateInterval);
        if (shouldUpdateThis) return true;
      }
      return false;
    }
  }

  /// 设置用户自定义更新间隔（以天为单位）
  Future<void> setUserUpdateInterval(String serviceType, int days) async {
    await _config.setUserUpdateIntervalDays(serviceType, days);
  }

  /// 获取用户自定义更新间隔
  Future<Duration> getUserUpdateInterval(String serviceType) async {
    final defaultIntervals = {
      'phone': const Duration(days: 1),
      'sms': const Duration(days: 1),
      'contact': const Duration(days: 1),
      'plugin': const Duration(days: 7),
    };
    
    final userIntervalDays = await _config.getUserUpdateIntervalDays(serviceType);
    return userIntervalDays != null
        ? Duration(days: userIntervalDays)
        : (defaultIntervals[serviceType] ?? const Duration(days: 1));
  }

  /// 更新最后更新时间
  Future<void> _updateLastUpdateTime({String? serviceType}) async {
    final now = DateTime.now();
    
    if (serviceType != null) {
      // 更新特定服务类型的时间
      await _config.saveLastUpdateTime(serviceType, now);
    } else {
      // 更新所有服务类型的时间
      await _config.saveLastUpdateTime('phone', now);
      await _config.saveLastUpdateTime('sms', now);
      await _config.saveLastUpdateTime('contact', now);
      await _config.saveLastUpdateTime('plugin', now);
    }
  }
}