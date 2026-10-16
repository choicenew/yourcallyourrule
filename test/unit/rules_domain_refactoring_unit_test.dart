import 'package:flutter_test/flutter_test.dart';
import 'package:yourcallyourrule/core/entities/rule/allowed_blocked_rule.dart';
import 'package:yourcallyourrule/core/entities/rule/phone_rule.dart';
import 'package:yourcallyourrule/core/entities/rule/regex_rule.dart';
import 'package:yourcallyourrule/core/entities/rule/rule_type.dart';
import 'package:yourcallyourrule/core/entities/rule/sim_slot_rule.dart';
import 'package:yourcallyourrule/core/entities/sms/sms_regex_rule.dart';
import 'package:yourcallyourrule/core/value_objects/phone_number.dart';
import 'package:yourcallyourrule/core/value_objects/rule_action.dart';
import 'package:yourcallyourrule/core/value_objects/rule_priority.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('RuleType & RuleTypeKeys 规则类型全局解析与兼容测试', () {
    test('1. RuleType.fromString 解析标准与历史遗留字面量', () {
      expect(RuleType.fromString('phone_rule'), equals(RuleType.phone));
      expect(RuleType.fromString('PHONE_RULE'), equals(RuleType.phone));
      expect(RuleType.fromString('allow_block'), equals(RuleType.allowBlock));
      expect(RuleType.fromString('white_black'), equals(RuleType.allowBlock)); // 兼容解析
      expect(RuleType.fromString('alloworblock'), equals(RuleType.allowBlock)); // 兼容解析
      expect(RuleType.fromString('regex'), equals(RuleType.regex));
      expect(RuleType.fromString('sim_slot'), equals(RuleType.simSlot));
      expect(RuleType.fromString('sms_regex'), equals(RuleType.smsRegex));
      expect(RuleType.fromString(null), equals(RuleType.phone)); // 默认降级
    });

    test('2. RuleType.toRawString 转换标准存储字符串', () {
      expect(RuleType.phone.toRawString(), equals(RuleTypeKeys.phone));
      expect(RuleType.allowBlock.toRawString(), equals(RuleTypeKeys.allowBlock));
      expect(RuleType.regex.toRawString(), equals(RuleTypeKeys.regex));
      expect(RuleType.simSlot.toRawString(), equals(RuleTypeKeys.simSlot));
      expect(RuleType.smsRegex.toRawString(), equals(RuleTypeKeys.smsRegex));
    });
  });

  group('Rule 实体类 (Freezed) 自动化生成与默认优先级测试', () {
    test('1. AllowedBlockedRule 白名单默认绑定高优先级 (high = 10)', () {
      final rule = AllowedBlockedRule(
        id: '1',
        name: 'Allowed Test',
        action: RuleAction.allow,
        phoneNumber: PhoneNumber('+8613800138000'),
        labelId: 'vip',
      );

      expect(rule.ruleType, equals(RuleTypeKeys.allowBlock));
      expect(rule.priority, equals(RulePriority.high)); // 白名单优先放行保障！
      expect(rule.matches('+8613800138000'), isTrue);
      expect(rule.matches('+8613900000000'), isFalse);
    });

    test('2. PhoneRule 普通黑名单默认绑定中优先级 (medium = 5)', () {
      final rule = PhoneRule(
        id: '2',
        name: 'Phone Block',
        action: RuleAction.block,
        phoneNumber: PhoneNumber('+8613800138000'),
        labelId: 'spam',
      );

      expect(rule.ruleType, equals(RuleTypeKeys.phone));
      expect(rule.priority, equals(RulePriority.medium));
      expect(rule.toMap()['ruleType'], equals('phone_rule'));
    });

    test('3. SimSlotRule 卡槽规则默认绑定中优先级', () {
      final rule = SimSlotRule(
        id: '3',
        name: 'Sim 1 Rule',
        phoneNumber: PhoneNumber('+8613800138000'),
        simSlotIndex: 0,
      );

      expect(rule.simSlotIndex, equals(0));
      expect(rule.ruleType, equals(RuleTypeKeys.simSlot));
      expect(rule.priority, equals(RulePriority.medium));
    });

    test('4. SmsRegexRule 短信正则规则算法匹配', () {
      final rule = SmsRegexRule(
        id: '4',
        name: 'SMS Verification Intercept',
        action: RuleAction.block,
        contentRegex: '验证码|退订',
        senderRegex: '^106.*',
      );

      expect(rule.ruleType, equals(RuleTypeKeys.smsRegex));
      expect(rule.matches('您的验证码是 1234'), isTrue);
      expect(rule.matches('普通的短信内容'), isFalse);
      expect(rule.matches('测试', '106900000'), isTrue);
    });

    test('5. RegexRule 正则表达式规则匹配、序列化与动态优先级推导', () {
      final rule = RegexRule(
        id: '5',
        name: 'Regex Intercept Test',
        pattern: r'^\+86138.*',
        action: RuleAction.block,
      );

      // 属性与类型常量校验
      expect(rule.ruleType, equals(RuleTypeKeys.regex));
      expect(rule.priority, equals(RulePriority.medium));
      expect(rule.isSubscribed, isFalse);

      // 正则匹配校验
      expect(rule.matches('+8613800138000'), isTrue);
      expect(rule.matches('+8613900000000'), isFalse);

      // 禁用时匹配测试
      final disabledRule = rule.copyWith(isEnabled: false);
      expect(disabledRule.matches('+8613800138000'), isFalse);

      // 订阅状态校验
      final subscribedRule = rule.copyWith(subscriptionId: 'sub_123');
      expect(subscribedRule.isSubscribed, isTrue);

      // 序列化与反序列化（toMap / fromMap / json）
      final map = rule.toMap();
      expect(map['pattern'], equals(r'^\+86138.*'));
      expect(map['ruleType'], equals(RuleTypeKeys.regex));

      final restoredFromMap = RegexRule.fromMap(map);
      expect(restoredFromMap.id, equals(rule.id));
      expect(restoredFromMap.pattern, equals(rule.pattern));
      expect(restoredFromMap.action, equals(rule.action));

      // 动态优先级注入测试：fromMap 缺失 priority 时依据 action 自动推导
      final allowMap = {
        'id': '6',
        'name': 'Allow Regex',
        'pattern': r'^\+8610086$',
        'action': 'allow',
        'isEnabled': 1,
      };
      final allowRule = RegexRule.fromMap(allowMap);
      expect(allowRule.priority, equals(RulePriority.high)); // Allow 动作 => high (10)

      final silenceMap = {
        'id': '7',
        'name': 'Silence Regex',
        'pattern': r'^\+8610010$',
        'action': 'silence',
        'isEnabled': 'true',
      };
      final silenceRule = RegexRule.fromMap(silenceMap);
      expect(silenceRule.priority, equals(RulePriority.silenceAction)); // Silence 动作 => silenceAction (1)

      final noneMap = {
        'id': '8',
        'name': 'None Regex',
        'pattern': r'^\+8610000$',
        'action': 'none',
        'isEnabled': true,
      };
      final noneRule = RegexRule.fromMap(noneMap);
      expect(noneRule.priority, equals(RulePriority.noneAction)); // None 动作 => noneAction (0)
    });
  });
}
