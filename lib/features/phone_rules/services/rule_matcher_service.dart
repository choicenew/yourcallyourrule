import 'package:pyro_phone_rules_protocol/pyro_phone_rules_protocol.dart';
import 'package:yourcallyourrule/features/common/value_objects/phone_number.dart';
import 'package:yourcallyourrule/features/common/value_objects/rule_action.dart';

abstract class RuleMatcherService {
  Future<List<PhoneRuleEntity>> getAllRules();
  Future<List<PhoneRuleEntity>> getRulesByAction(RuleAction action);
  Future<PhoneRuleEntity?> matchPhoneNumber(PhoneNumber phoneNumber);
  Future<PhoneRuleEntity?> matchSmsMessage(PhoneNumber phoneNumber, String messageContent);
  Future<RuleAction> getActionForPhoneNumber(PhoneNumber phoneNumber) async {
    final matchedRule = await matchPhoneNumber(phoneNumber);
    return matchedRule != null ? RuleAction.fromString(matchedRule.actionType) : RuleAction.allow;
  }
}
