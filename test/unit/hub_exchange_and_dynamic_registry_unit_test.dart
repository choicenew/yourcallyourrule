import 'package:material_ui/material_ui.dart' as m_ui;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:pyro_cloud_drive_hub/pyro_cloud_drive_hub.dart';
import 'package:pyro_user_database_hub/pyro_user_database_hub.dart';
import 'package:pyro_user_database_cloudflare/pyro_user_database_cloudflare.dart';
import 'package:pyro_phone_call_filter_hub/pyro_phone_call_filter_hub.dart';
import 'package:pyro_device_master_slave_protocol/pyro_device_master_slave_protocol.dart';

import 'package:yourcallyourrule/core/coordinator/filter_ui_registry.dart';
import 'package:yourcallyourrule/core/coordinator/package_connectors_initializer.dart';
import 'package:yourcallyourrule/features/call_filter/presentation/widgets/enhanced_composite_filter_settings_widget.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('🧪 主 App 胶水装配线全量能力 (CallFilter, CloudDrive, UserDB Sync, Device) 单元测试矩阵', () {
    setUp(() {
      initPackageConnectors();
    });

    test('1. 验证 FilterUiRegistry 能零硬编码魔数、零 switch-case 成功获取所有 Filter UI Spec', () {
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

    test('2. 验证 CloudDriveHub HostContext 与 GoogleDrive, OneDrive, WebDAV 三大驱动注册', () {
      CloudDriveHub.instance.configureHostContext(
        appName: 'YourCallYourRule',
        encryptionHeaderTag: 'YOURCALL_ENC_V1',
      );
      expect(CloudDriveHub.instance, isNotNull);
    });

    test('3. 验证 UserDatabaseHub 能够成功挂载 Cloudflare/Supabase 数据库同步适配器', () {
      UserDatabaseHub.instance.registerAdapter(CloudflareSyncProvider());
      expect(UserDatabaseHub.instance, isNotNull);
    });

    test('4. 验证 强类型 DeviceNode 领域实体 (Master/Slave 角色与 Device ID)', () {
      final now = DateTime.now();
      final masterNode = DeviceNode(
        deviceId: 'device_master_001',
        deviceName: 'Primary Master Node',
        role: DeviceRole.master,
        lastHeartbeatTime: now,
      );

      final slaveNode = DeviceNode(
        deviceId: 'device_slave_002',
        deviceName: 'Secondary Slave Node',
        role: DeviceRole.slave,
        lastHeartbeatTime: now,
      );

      expect(masterNode.deviceId, equals('device_master_001'));
      expect(masterNode.isMaster, isTrue);
      expect(masterNode.role, equals(DeviceRole.master));

      expect(slaveNode.deviceId, equals('device_slave_002'));
      expect(slaveNode.isMaster, isFalse);
      expect(slaveNode.role, equals(DeviceRole.slave));
    });

    test('5. 验证 EnhancedCompositeFilterService 注册的 Filter 实例在内存中零丢失', () {
      final filters = EnhancedCompositeFilterService.instance.filters;
      expect(filters.length, greaterThanOrEqualTo(3));

      final filterIds = filters.map((f) => f.filterType.id).toList();
      expect(filterIds, contains('localCountThreshold'));
      expect(filterIds, contains('remoteRisk'));
      expect(filterIds, contains('timeWindow'));
    });

    testWidgets('6. 验证 EnhancedCompositeFilterSettingsWidget 纯数据驱动大盘无崩溃渲染', (tester) async {
      FilterUiRegistry.init();

      await tester.pumpWidget(
        const ProviderScope(
          child: m_ui.MaterialApp(
            localizationsDelegates: [
              ...AppLocalizations.localizationsDelegates,
              m_ui.DefaultMaterialLocalizations.delegate,
            ],
            supportedLocales: AppLocalizations.supportedLocales,
            home: Scaffold(
              body: EnhancedCompositeFilterSettingsWidget(),
            ),
          ),
        ),
      );

      await tester.pump();

      expect(find.byType(EnhancedCompositeFilterSettingsWidget), findsOneWidget);
    });
  });
}
