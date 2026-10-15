import 'package:flutter_test/flutter_test.dart';
import 'package:yourcallyourrule/core/entities/rule/allowed_blocked_rule.dart';
import 'package:yourcallyourrule/core/entities/rule/phone_rule.dart';
import 'package:yourcallyourrule/core/entities/rule/sim_slot_rule.dart';
import 'package:yourcallyourrule/core/repositories/rule_repository_impl.dart';
import 'package:yourcallyourrule/data/datasources/local/local_label_datasource.dart';
import 'package:yourcallyourrule/data/datasources/local/local_phone_rule_datasource.dart';
import 'package:yourcallyourrule/data/datasources/local/local_regex_rule_datasource.dart';
import 'package:yourcallyourrule/data/datasources/local/local_sim_slot_rule_datasource.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('RuleRepositoryImpl 领域隔离断言与 Map 反序列化测试', () {
    test('1. createRuleFromMap 正确创建 4 种通话规则实体', () {
      final repo = RuleRepositoryImpl(_FakePhoneDS(), _FakeRegexDS(), _FakeLabelDS(), _FakeSimSlotDS());

      final phoneMap = {
        'id': 'p1',
        'name': 'Phone Rule',
        'ruleType': 'phone_rule',
        'action': 'block',
        'phoneNumber': '+8613800138000',
        'labelId': 'spam',
      };
      final phoneRule = repo.createRuleFromMap(phoneMap);
      expect(phoneRule, isA<PhoneRule>());

      final allowMap = {
        'id': 'a1',
        'name': 'Allow Rule',
        'ruleType': 'allow_block',
        'action': 'allow',
        'phoneNumber': '+8613800138000',
        'labelId': 'vip',
      };
      final allowRule = repo.createRuleFromMap(allowMap);
      expect(allowRule, isA<AllowedBlockedRule>());

      final simMap = {
        'id': 's1',
        'name': 'Sim Rule',
        'ruleType': 'sim_slot',
        'action': 'block',
        'phoneNumber': '+8613800138000',
        'simSlotIndex': 0,
      };
      final simRule = repo.createRuleFromMap(simMap);
      expect(simRule, isA<SimSlotRule>());
    });

    test('2. 领域隔离断言: 传入 sms_regex 必须抛出 UnsupportedError 断言错误', () {
      final repo = RuleRepositoryImpl(_FakePhoneDS(), _FakeRegexDS(), _FakeLabelDS(), _FakeSimSlotDS());

      final smsMap = {
        'id': 'sms1',
        'name': 'SMS Rule',
        'ruleType': 'sms_regex',
        'action': 'block',
        'contentRegex': '验证码',
      };

      expect(() => repo.createRuleFromMap(smsMap), throwsA(isA<UnsupportedError>()));
    });
  });
}

class _FakePhoneDS implements LocalPhoneRuleDataSource {
  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _FakeRegexDS implements LocalRegexRuleDataSource {
  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _FakeLabelDS implements LocalLabelDataSource {
  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _FakeSimSlotDS implements LocalSimSlotRuleDataSource {
  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
