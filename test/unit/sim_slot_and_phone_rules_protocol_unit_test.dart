import 'package:flutter_test/flutter_test.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:pyro_phone_sim_slot_rules_protocol/pyro_phone_sim_slot_rules_protocol.dart';
import 'package:pyro_phone_rules_protocol/pyro_phone_rules_protocol.dart';
import 'package:yourcallyourrule/data/database/local/local_database.dart';
import 'package:yourcallyourrule/features/phone_rules/data/datasources/local_sim_slot_rule_datasource.dart';

void main() {
  group('🛡️ SimSlotRuleEntity & PhoneRuleEntities 强类型协议与 Mapper 单元测试', () {
    test('1. SimSlotRuleEntity 数据模型与序列化 (fromMap/toMap/copyWith) 校验', () {
      const entity = SimSlotRuleEntity(
        id: 'sim_rule_001',
        name: 'VIP SIM1 Intercept',
        phoneNumber: '+8613800138000',
        simSlotIndex: 0,
        labelId: 'label_spam',
        actionType: 'block',
        priority: 10,
        isEnabled: true,
      );

      expect(entity.id, equals('sim_rule_001'));
      expect(entity.phoneNumber, equals('+8613800138000'));
      expect(entity.simSlotIndex, equals(0));
      expect(entity.actionType, equals('block'));

      // 验证 toMap / fromMap 双向转换
      final map = entity.toMap();
      expect(map['id'], equals('sim_rule_001'));
      expect(map['simSlotIndex'], equals(0));

      final restored = SimSlotRuleEntity.fromMap(map);
      expect(restored.id, equals(entity.id));
      expect(restored.phoneNumber, equals(entity.phoneNumber));
      expect(restored.simSlotIndex, equals(entity.simSlotIndex));
      expect(restored.isEnabled, equals(entity.isEnabled));

      // 验证 copyWith 字段变更隔离
      final disabled = entity.copyWith(isEnabled: false, simSlotIndex: 1);
      expect(disabled.isEnabled, isFalse);
      expect(disabled.simSlotIndex, equals(1));
      expect(disabled.id, equals(entity.id));
      expect(entity.isEnabled, isTrue); // 原对象保持 Immutable
    });

    test('2. SimSlotRuleModelMapper 数据驱动 (SimSlotRule Data <-> Companion) 双向转化', () {
      final dbData = SimSlotRule(
        id: 'rule_100',
        name: 'Sim2 Block Rule',
        priority: 20,
        action: 'allow',
        isEnabled: 1,
        phoneNumber: '+8613911112222',
        simSlotIndex: 1,
        labelId: 'white_label',
        avatar: 'avatar_url',
        ruleType: 'simSlot',
      );

      // Mapper: fromData -> SimSlotRuleEntity
      final entity = SimSlotRuleModelMapper.fromData(dbData);
      expect(entity.id, equals('rule_100'));
      expect(entity.name, equals('Sim2 Block Rule'));
      expect(entity.phoneNumber, equals('+8613911112222'));
      expect(entity.simSlotIndex, equals(1));
      expect(entity.actionType, equals('allow'));
      expect(entity.isEnabled, isTrue);

      // Mapper: toCompanion -> SimSlotRulesCompanion
      final companion = SimSlotRuleModelMapper.toCompanion(entity);
      expect(companion.id.value, equals('rule_100'));
      expect(companion.name.value, equals('Sim2 Block Rule'));
      expect(companion.phoneNumber.value, equals('+8613911112222'));
      expect(companion.simSlotIndex.value, equals(1));
      expect(companion.action.value, equals('allow'));
      expect(companion.isEnabled.value, equals(1));
    });

    test('3. PhoneRuleEntity & RegexRuleEntity 匹配逻辑与订阅状态校验', () {
      const phoneRule = PhoneRuleEntity(
        id: 'p_01',
        name: 'Blacklist Contact',
        phoneNumber: '+8610086',
        actionType: 'block',
        subscriptionId: 'sub_cloud_01',
      );

      expect(phoneRule.isSubscribed, isTrue);
      expect(phoneRule.actionType, equals('block'));

      const regexRule = RegexRuleEntity(
        id: 'r_01',
        name: 'Spam Prefix Regex',
        pattern: r'^\+86138\d{8}$',
        actionType: 'block',
        isEnabled: true,
      );

      expect(regexRule.isSubscribed, isFalse);

      // 正则表达逻辑匹配测试
      expect(regexRule.matches('+8613800138000'), isTrue);
      expect(regexRule.matches('+8613900138000'), isFalse);
      expect(regexRule.matches('invalid_number'), isFalse);

      // 规则禁能测试
      final disabledRegex = regexRule.copyWith(isEnabled: false);
      expect(disabledRegex.matches('+8613800138000'), isFalse);

      // 异常表达式容错测试（非法正则表达式不导致 Crash）
      const invalidRegex = RegexRuleEntity(
        id: 'r_invalid',
        name: 'Bad Regex',
        pattern: r'[a-z', // 语法缺失右括号
      );
      expect(invalidRegex.matches('abc'), isFalse);
    });
  });
}
