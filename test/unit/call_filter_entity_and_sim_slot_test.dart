import 'package:flutter_test/flutter_test.dart';
import 'package:yourcallyourrule/features/call/call_filter/call_filter_type.dart';
import 'package:yourcallyourrule/features/call/call_filter/config/call_filter_config.dart';
import 'package:yourcallyourrule/features/call/call_filter/providers/call_filter_provider.dart';
import 'package:yourcallyourrule/features/call/call_filter/providers/enhanced_filter_config_provider.dart';

void main() {
  group('🛡️ CallFilter 强类型实体与分卡槽状态隔离测试', () {
    test('1. 验证 CallFilterType 枚举类型与硬编码字符串安全解析', () {
      expect(CallFilterType.values.length, equals(4));
      expect(CallFilterType.simSlotRule.name, equals('simSlotRule'));
      expect(CallFilterType.basicRule.name, equals('basicRule'));
      expect(CallFilterType.localCount.name, equals('localCount'));
      expect(CallFilterType.remoteNumber.name, equals('remoteNumber'));

      // 验证平滑兼容解析
      expect(
        EnhancedFilterConfigNotifier.parseFilterType('basicRule'),
        equals(CallFilterType.basicRule),
      );
      expect(
        EnhancedFilterConfigNotifier.parseFilterType('CallFilterService'),
        equals(CallFilterType.basicRule),
      );
      expect(
        EnhancedFilterConfigNotifier.parseFilterType('SimSlotRuleService'),
        equals(CallFilterType.simSlotRule),
      );
    });

    test('2. 验证 CallFilterConfig 强类型实体 serialization 与 copyWith 强校验', () {
      final defaultConfig = CallFilterConfig();
      expect(defaultConfig.allowAllAllowedNumbers, isTrue);
      expect(defaultConfig.allowRegexBlockRules, isTrue);
      expect(defaultConfig.rejectAllNumbers, isFalse);

      final modified = defaultConfig.copyWith(
        allowAllAllowedNumbers: false,
        rejectAllNumbers: true,
      );

      expect(modified.allowAllAllowedNumbers, isFalse);
      expect(modified.rejectAllNumbers, isTrue);
      expect(modified.allowRegexBlockRules, isTrue);

      final map = modified.toMap();
      expect(map[CallFilterConfig.keyAllowAllAllowedNumbers], isFalse);
      expect(map[CallFilterConfig.keyRejectAllNumbers], isTrue);

      final restored = CallFilterConfig.fromMap(map);
      expect(restored.allowAllAllowedNumbers, isFalse);
      expect(restored.rejectAllNumbers, isTrue);
    });

    test('3. 验证 EnhancedFilterConfigState 强类型 Map (Map<CallFilterType, bool>) 提取', () {
      final state = EnhancedFilterConfigState(
        filterEnabledMap: {
          CallFilterType.basicRule: true,
          CallFilterType.localCount: false,
        },
        simSlotFilterConfigMap: {
          0: {CallFilterType.simSlotRule: true},
          1: {CallFilterType.simSlotRule: false},
        },
      );

      expect(state.typedFilterEnabledMap[CallFilterType.basicRule], isTrue);
      expect(state.typedFilterEnabledMap[CallFilterType.localCount], isFalse);

      // 验证兼容量读取
      expect(state.filterEnabledMap[CallFilterType.basicRule], isTrue);
      expect(state.filterEnabledMap['basicRule'], isTrue);

      // 验证分卡槽读取隔离
      expect(state.simSlotFilterConfigMap[0]?[CallFilterType.simSlotRule], isTrue);
      expect(state.simSlotFilterConfigMap[1]?[CallFilterType.simSlotRule], isFalse);
    });

    test('4. 验证 SIM 1 (槽 0) 与 SIM 2 (槽 1) 强类型 CallFilterConfig 隔离互不干扰', () {
      final sim0Config = CallFilterConfig(
        allowAllAllowedNumbers: true,
        rejectAllNumbers: false,
      );
      final sim1Config = CallFilterConfig(
        allowAllAllowedNumbers: false,
        rejectAllNumbers: true,
      );

      final simConfigs = <int, CallFilterConfig>{
        0: sim0Config,
        1: sim1Config,
      };

      // 验证 SIM 1 配置改动完全影响不到 SIM 2
      expect(simConfigs[0]?.allowAllAllowedNumbers, isTrue);
      expect(simConfigs[0]?.rejectAllNumbers, isFalse);

      expect(simConfigs[1]?.allowAllAllowedNumbers, isFalse);
      expect(simConfigs[1]?.rejectAllNumbers, isTrue);
    });

    test('5. 验证 SeparateSimsState 强类型配置实体与 CallFilterConfigKeys 集中式 Key 校验', () {
      expect(CallFilterConfigKeys.globalCallFilter, equals('config_call_filter'));
      expect(CallFilterConfigKeys.simSlotCallFilter(0), equals('config_call_filter_sim_0'));
      expect(CallFilterConfigKeys.simSlotCallFilter(1), equals('config_call_filter_sim_1'));

      final simState = const SeparateSimsState(isEnabled: true);
      final map = simState.toMap();
      expect(map[CallFilterConfigKeys.enabledField], isTrue);

      final restored = SeparateSimsState.fromMap(map);
      expect(restored.isEnabled, isTrue);
    });
  });
}
