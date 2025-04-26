import 'package:yourcallyourrule/core/entities/rule/rule_base.dart';
import 'package:yourcallyourrule/features/phone/services/phone_subscription_service.dart';
import 'package:yourcallyourrule/features/sms/services/sms_subscription_service.dart';

class AutoUpdateService {
  final PhoneSubscriptionService _phoneService;
  final SmsSubscriptionService _smsService;

  const AutoUpdateService({
    required PhoneSubscriptionService phoneService,
    required SmsSubscriptionService smsService,
  }) : _phoneService = phoneService,
       _smsService = smsService;

  Future<List<RuleBase>> updateAll() async {
    final results = <RuleBase>[];
    
    // 更新电话订阅
    final phoneSubs = await _phoneService.getEnabledSubscriptions();
    for (final sub in phoneSubs) {
      results.addAll(await _phoneService.updateRulesFromSubscription(sub));
    }

    // 更新短信订阅
    final smsSubs = await _smsService.getEnabledSubscriptions();
    for (final sub in smsSubs) {
      results.addAll(await _smsService.updateRulesFromSubscription(sub));
    }

    return results;
  }
}