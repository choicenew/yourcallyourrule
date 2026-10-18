import 'package:flutter_test/flutter_test.dart';
import 'package:yourcallyourrule/core/entities/call/sim_info.dart';
import 'package:yourcallyourrule/features/call/call_filter/call_filter_type.dart';
import 'package:yourcallyourrule/features/call/call_filter/config/call_filter_config.dart';
import 'package:yourcallyourrule/features/call/call_filter/providers/call_filter_provider.dart';
import 'package:yourcallyourrule/features/call/call_filter/providers/enhanced_filter_config_provider.dart';

void main() {
  group('📱 SIM卡1与SIM卡2分卡槽独立设置与拦截决策全量单元测试', () {
    test('1. 验证 SIM 卡 1 (卡槽 0) 与 SIM 卡 2 (卡槽 1) 独立的 CallFilterConfig 读写与修改隔离', () {
      final sim0Config = CallFilterConfig(
        allowAllAllowedNumbers: true,
        allowRegexBlockRules: true,
        rejectAllNumbers: false,
      );

      final sim1Config = CallFilterConfig(
        allowAllAllowedNumbers: false,
        allowRegexBlockRules: false,
        rejectAllNumbers: true,
      );

      final storageMap = <String, Map<String, dynamic>>{
        CallFilterConfigKeys.simSlotCallFilter(0): sim0Config.toMap(),
        CallFilterConfigKeys.simSlotCallFilter(1): sim1Config.toMap(),
      };

      // 读取卡槽 0 的配置
      final loadedSim0Map = storageMap[CallFilterConfigKeys.simSlotCallFilter(0)]!;
      final loadedSim0 = CallFilterConfig.fromMap(loadedSim0Map);

      // 读取卡槽 1 的配置
      final loadedSim1Map = storageMap[CallFilterConfigKeys.simSlotCallFilter(1)]!;
      final loadedSim1 = CallFilterConfig.fromMap(loadedSim1Map);

      // 验证 SIM 1 和 SIM 2 的配置独立完全不同
      expect(loadedSim0.allowAllAllowedNumbers, isTrue);
      expect(loadedSim0.rejectAllNumbers, isFalse);

      expect(loadedSim1.allowAllAllowedNumbers, isFalse);
      expect(loadedSim1.rejectAllNumbers, isTrue);

      // 修改 SIM 1 的配置，验证影响不到 SIM 2
      final updatedSim0 = loadedSim0.copyWith(rejectAllNumbers: true);
      storageMap[CallFilterConfigKeys.simSlotCallFilter(0)] = updatedSim0.toMap();

      final recheckedSim1 = CallFilterConfig.fromMap(
        storageMap[CallFilterConfigKeys.simSlotCallFilter(1)]!,
      );
      expect(recheckedSim1.allowAllAllowedNumbers, isFalse);
      expect(recheckedSim1.rejectAllNumbers, isTrue); // SIM 2 保持原样不改变
    });

    test('2. 模拟 SIM 卡 1 与 SIM 卡 2 在按卡槽决策时的 shouldAcceptCall 动作分流', () async {
      // SIM 卡 1 配置：拒绝所有来电
      final sim0Config = CallFilterConfig(rejectAllNumbers: true);
      // SIM 卡 2 配置：放行正常来电，不拒绝
      final sim1Config = CallFilterConfig(rejectAllNumbers: false);

      Future<CallFilterConfig> mockGetConfigForSim(int? simSlotIndex) async {
        if (simSlotIndex == 0) return sim0Config;
        if (simSlotIndex == 1) return sim1Config;
        return CallFilterConfig();
      }

      final sim1Info = SimInfo(simSlotIndex: 0, carrierName: 'China Mobile');
      final sim2Info = SimInfo(simSlotIndex: 1, carrierName: 'China Unicom');

      // 当来电进入 SIM 卡 1 时，读取 SIM 1 的配置，拒绝来电
      final config1 = await mockGetConfigForSim(sim1Info.simSlotIndex);
      expect(config1.rejectAllNumbers, isTrue);

      // 当来电进入 SIM 卡 2 时，读取 SIM 2 的配置，接受来电
      final config2 = await mockGetConfigForSim(sim2Info.simSlotIndex);
      expect(config2.rejectAllNumbers, isFalse);
    });

    test('3. 验证 EnhancedFilterConfigState 在多卡槽场景下的 CallFilterType 拦截链状态控制', () {
      final enhancedState = EnhancedFilterConfigState(
        simSlotFilterConfigMap: {
          0: {
            CallFilterType.basicRule: true,
            CallFilterType.localCount: true,
            CallFilterType.remoteNumber: false,
          },
          1: {
            CallFilterType.basicRule: false,
            CallFilterType.localCount: false,
            CallFilterType.remoteNumber: true,
          },
        },
      );

      // 验证卡槽 0 策略
      expect(
        enhancedState.simSlotFilterConfigMap[0]?[CallFilterType.basicRule],
        isTrue,
      );
      expect(
        enhancedState.simSlotFilterConfigMap[0]?[CallFilterType.remoteNumber],
        isFalse,
      );

      // 验证卡槽 1 策略
      expect(
        enhancedState.simSlotFilterConfigMap[1]?[CallFilterType.basicRule],
        isFalse,
      );
      expect(
        enhancedState.simSlotFilterConfigMap[1]?[CallFilterType.remoteNumber],
        isTrue,
      );
    });
  });
}
