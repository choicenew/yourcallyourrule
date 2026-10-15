import 'package:flutter_test/flutter_test.dart';
import 'package:yourcallyourrule/core/entities/rule/allowed_blocked_rule.dart';
import 'package:yourcallyourrule/core/value_objects/phone_number.dart';
import 'package:yourcallyourrule/core/value_objects/rule_action.dart';
import 'package:yourcallyourrule/core/value_objects/rule_priority.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('PhoneNumberConverter 序列化与反序列化测试', () {
    const converter = PhoneNumberConverter();

    test('1. 正常字符串转换为 PhoneNumber 对象', () {
      final phone = converter.fromJson('+8613800138000');
      expect(phone, equals(const PhoneNumber('+8613800138000')));
      expect(converter.toJson(phone), equals('+8613800138000'));
    });

    test('2. 包含清洗字符的输入格式化转换', () {
      final phone = converter.fromJson('+86 138-0013-8000');
      expect(phone.value, equals('+8613800138000'));
    });

    test('3. null 与空文本防风控降级处理', () {
      final phoneNull = converter.fromJson(null);
      expect(phoneNull.value, equals(''));

      final phoneEmpty = converter.fromJson('');
      expect(phoneEmpty.value, equals(''));
    });
  });

  group('RuleActionConverter 序列化与反序列化测试', () {
    const converter = RuleActionConverter();

    test('1. 标准 action 字符串解析', () {
      final allowAction = converter.fromJson('allow');
      expect(allowAction.type, equals(RuleActionType.allow));

      final blockAction = converter.fromJson('block');
      expect(blockAction.type, equals(RuleActionType.block));

      final silenceAction = converter.fromJson('silence');
      expect(silenceAction.type, equals(RuleActionType.silence));
    });

    test('2. null 与非预定 action 防风控降级为 none', () {
      final nullAction = converter.fromJson(null);
      expect(nullAction.type, equals(RuleActionType.none));

      final invalidAction = converter.fromJson('invalid_action_xyz');
      expect(invalidAction.type, equals(RuleActionType.none));
    });

    test('3. RuleAction.toJson 序列化输出', () {
      expect(converter.toJson(RuleAction.allow), equals('allow'));
      expect(converter.toJson(RuleAction.block), equals('block'));
    });
  });

  group('RulePriorityConverter 序列化与反序列化测试', () {
    const converter = RulePriorityConverter();

    test('1. 整数与数值字符串解析', () {
      expect(converter.fromJson(10), equals(RulePriority.high));
      expect(converter.fromJson(100), equals(RulePriority.highest));
      expect(converter.fromJson('50'), equals(RulePriority.veryHigh));
    });

    test('2. null 与非法格式防护降级为 medium (5)', () {
      expect(converter.fromJson(null), equals(RulePriority.medium));
      expect(converter.fromJson('dirty_priority'), equals(RulePriority.medium));
    });

    test('3. RulePriority.toJson 序列化输出', () {
      expect(converter.toJson(RulePriority.high), equals(10));
      expect(converter.toJson(RulePriority.highest), equals(100));
    });
  });

  group('AllowedBlockedRule 动效优先级比对规则测试 (ALLOW = 100 > BLOCK = 50)', () {
    test('1. ALLOW (白名单) 必须拥有更高的默认优先级 (highest = 100)', () {
      final allowRule = AllowedBlockedRule.fromMap({
        'id': '1',
        'name': 'Allow Rule',
        'action': 'allow',
        'phoneNumber': '+8613800138000',
        'labelId': 'vip',
      });

      final blockRule = AllowedBlockedRule.fromMap({
        'id': '2',
        'name': 'Block Rule',
        'action': 'block',
        'phoneNumber': '+8613800138000',
        'labelId': 'spam',
      });

      // 验证允许规则优先级大于阻止规则：Allow (100) > Block (50)
      expect(allowRule.priority > blockRule.priority, isTrue);
      expect(allowRule.priority, equals(RulePriority.highest));
      expect(blockRule.priority, equals(RulePriority.veryHigh));
    });
  });
}
