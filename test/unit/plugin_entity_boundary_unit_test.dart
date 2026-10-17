import 'package:flutter_test/flutter_test.dart';

import 'package:yourcallyourrule/core/entities/plugin/plugin_source_data.dart';
import 'package:yourcallyourrule/core/value_objects/rule_action.dart';

/// 插件边界实体化转换单元测试 (Plugin Entity Output Boundary Unit Test)
/// 验证：
/// 1. 弱类型 JS 字典 (Map<String, dynamic>) 在 Plugin 边缘成功转化为强类型 PluginSourceData 实体
/// 2. 动作字段 (action) 正确映射为强类型 RuleAction 枚举 (allow, block, none, silence)
/// 3. 标签 (predefinedLabel)、名称 (name)、计数 (count) 等核心属性正确解包
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('🎯 插件数据边界实体化转换测试 (Plugin Entity Boundary Test)', () {
    
    test('1. 验证 JS 插件 Map 报文转强类型 PluginSourceData 实体', () {
      final rawJsMap = {
        'name': 'ShouldIAnswer Reporter',
        'predefinedLabel': '广告推销',
        'sourceLabel': 'Spam Call',
        'count': '42',
        'action': 'block', // 弱类型字符串 'block'
        'province': 'California',
        'city': 'San Francisco',
        'carrier': 'T-Mobile',
        'phoneNumber': '+12026308598',
        'customExtraField': '12345',
      };

      // 在 Plugin 输出出口调用实体转换
      final entity = PluginSourceData.fromMap(rawJsMap);

      expect(entity, isA<PluginSourceData>());
      expect(entity.name, equals('ShouldIAnswer Reporter'));
      expect(entity.predefinedLabel, equals('广告推销'));
      expect(entity.count, equals(42));
      expect(entity.action, equals(RuleAction.block)); // 强类型 RuleAction.block!
      expect(entity.carrier, equals('T-Mobile'));
      expect(entity.phoneNumber, equals('+12026308598'));
      expect(entity.extra['customExtraField'], equals('12345'));
    });

    test('2. 验证不同 action 字符串在 Plugin 边界的枚举映射对齐', () {
      final blockEntity = PluginSourceData.fromMap({'action': 'block'});
      expect(blockEntity.action, equals(RuleAction.block));

      final allowEntity = PluginSourceData.fromMap({'action': 'allow'});
      expect(allowEntity.action, equals(RuleAction.allow));

      final silenceEntity = PluginSourceData.fromMap({'action': 'silence'});
      expect(silenceEntity.action, equals(RuleAction.silence));

      final noneEntity = PluginSourceData.fromMap({'action': 'none'});
      expect(noneEntity.action, equals(RuleAction.none));

      // 异常或空字符串自动平滑降级为 RuleAction.none
      final invalidEntity = PluginSourceData.fromMap({'action': 'unknown_action_xyz'});
      expect(invalidEntity.action, equals(RuleAction.none));
    });

    test('3. 验证 PluginSourceData 双向转换与序列化对称性', () {
      final original = PluginSourceData(
        name: 'CleverDialer Plugin',
        predefinedLabel: '骚扰电话',
        count: 99,
        action: RuleAction.block,
        phoneNumber: '2026308598',
      );

      final map = original.toMap();
      expect(map['name'], equals('CleverDialer Plugin'));
      expect(map['predefinedLabel'], equals('骚扰电话'));
      expect(map['count'], equals('99'));

      final restored = PluginSourceData.fromMap(map);
      expect(restored.name, equals(original.name));
      expect(restored.predefinedLabel, equals(original.predefinedLabel));
      expect(restored.count, equals(original.count));
      expect(restored.action, equals(RuleAction.block));
    });
  });
}
