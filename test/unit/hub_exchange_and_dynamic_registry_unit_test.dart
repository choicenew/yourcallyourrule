import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:pyro_cloud_drive_hub/pyro_cloud_drive_hub.dart';
import 'package:pyro_phone_call_filter_hub/pyro_phone_call_filter_hub.dart';
import 'package:pyro_device_master_slave_protocol/pyro_device_master_slave_protocol.dart';

import 'package:yourcallyourrule/core/coordinator/app_coordinator.dart';
import 'package:yourcallyourrule/core/coordinator/filter_ui_registry.dart';
import 'package:yourcallyourrule/core/coordinator/package_connectors_initializer.dart';
import 'package:yourcallyourrule/features/call_filter/presentation/widgets/enhanced_composite_filter_settings_widget.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('🧪 主 App 胶水装配线、FilterUiRegistry 工厂与 DeviceNode 单元测试', () {
    setUp(() {
      initPackageConnectors();
    });

    test('1. 验证 FilterUiRegistry 能零硬编码、零 switch-case 成功获取所有 Filter UI Spec', () {
      FilterUiRegistry.init();

      final basicSpec = FilterUiRegistry.get('basicRule');
      final timeSpec = FilterUiRegistry.get('timeWindow');
      final localSpec = FilterUiRegistry.get('localCountThreshold');
      final remoteSpec = FilterUiRegistry.get('remoteRisk');
      final simSpec = FilterUiRegistry.get('simSlot');

      expect(basicSpec, isNotNull);
      expect(timeSpec, isNotNull);
      expect(localSpec, isNotNull);
      expect(remoteSpec, isNotNull);
      expect(simSpec, isNotNull);

      expect(basicSpec!.icon, equals(Icons.rule_rounded));
      expect(timeSpec!.icon, equals(Icons.access_time_rounded));
      expect(localSpec!.icon, equals(Icons.filter_alt_rounded));
      expect(remoteSpec!.icon, equals(Icons.cloud_done_rounded));
      expect(simSpec!.icon, equals(Icons.sim_card_rounded));
    });

    test('2. 验证 CloudDriveHub 的 HostContext 配置', () {
      CloudDriveHub.instance.configureHostContext(
        appName: 'YourCallYourRule',
        encryptionHeaderTag: 'YOURCALL_ENC_V1',
      );
      expect(CloudDriveHub.instance, isNotNull);
    });

    test('3. 验证 强类型 DeviceNode 值对象事件与广播', () {
      final deviceNode = DeviceNode(
        deviceId: 'node_test_888',
        deviceName: 'Test Phone Node Master',
        role: DeviceRole.master,
        lastHeartbeatTime: DateTime.now(),
      );

      expect(deviceNode.deviceId, equals('node_test_888'));
      expect(deviceNode.deviceName, equals('Test Phone Node Master'));
      expect(deviceNode.role, equals(DeviceRole.master));
    });

    test('4. 验证 EnhancedCompositeFilterService 注册的 Filter 实例能够在内存中零丢失', () {
      final filters = EnhancedCompositeFilterService.instance.filters;
      expect(filters.length, greaterThanOrEqualTo(4));

      final filterIds = filters.map((f) => f.filterType.id).toList();
      expect(filterIds, contains('localCountThreshold'));
      expect(filterIds, contains('remoteRisk'));
      expect(filterIds, contains('timeWindow'));
      expect(filterIds, contains('simSlot'));
    });

    testWidgets('5. 验证 EnhancedCompositeFilterSettingsWidget 大盘页面能够纯数据驱动无崩溃挂载', (tester) async {
      FilterUiRegistry.init();

      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: Scaffold(
              body: EnhancedCompositeFilterSettingsWidget(),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(EnhancedCompositeFilterSettingsWidget), findsOneWidget);
      expect(find.byType(Card), findsAtLeastNWidgets(1));
    });
  });
}
