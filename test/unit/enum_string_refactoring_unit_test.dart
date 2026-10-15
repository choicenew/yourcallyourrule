import 'package:flutter_test/flutter_test.dart';
import 'package:yourcallyourrule/core/constants/app_prefs_keys.dart';
import 'package:yourcallyourrule/core/constants/background_task_keys.dart';
import 'package:yourcallyourrule/features/call_statistic/domain/statistic_period.dart';
import 'package:yourcallyourrule/features/notifications/domain/notification_category.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('全局配置与后台任务 Key 架构规范测试', () {
    test('1. AppPrefsKeys 必须 100% 以 config_ 前缀开头 (保证云端备份过滤器能识别)', () {
      expect(AppPrefsKeys.hasCompletedInitialSetup.startsWith('config_'), isTrue);
      expect(AppPrefsKeys.firstLaunch.startsWith('config_'), isTrue);

      expect(AppPrefsKeys.hasCompletedInitialSetup, equals('config_has_completed_initial_setup'));
      expect(AppPrefsKeys.firstLaunch, equals('config_first_launch'));
    });

    test('2. BackgroundTaskKeys 任务标识一字不差对等核对', () {
      expect(BackgroundTaskKeys.syncCallLogTask, equals('syncCallLogTask'));
      expect(BackgroundTaskKeys.autoUpdateTask, equals('autoUpdateTask'));
      expect(BackgroundTaskKeys.dataSyncTask, equals('dataSyncTask'));
      expect(BackgroundTaskKeys.syncTaskTag, equals('com.yourcallyourrule.sync'));
      expect(BackgroundTaskKeys.callLogTaskId, equals('1'));
      expect(BackgroundTaskKeys.autoUpdateTaskId, equals('2'));
    });
  });

  group('StatisticPeriod 统计周期枚举测试', () {
    test('1. 字符串解析与转大小写健壮性', () {
      expect(StatisticPeriod.fromString('week'), equals(StatisticPeriod.week));
      expect(StatisticPeriod.fromString('Week'), equals(StatisticPeriod.week));

      expect(StatisticPeriod.fromString('month'), equals(StatisticPeriod.month));
      expect(StatisticPeriod.fromString('MONTH'), equals(StatisticPeriod.month));

      expect(StatisticPeriod.fromString('year'), equals(StatisticPeriod.year));
      expect(StatisticPeriod.fromString('Year'), equals(StatisticPeriod.year));
    });

    test('2. 脏数据容错 (默认降级为 week)', () {
      expect(StatisticPeriod.fromString('invalid_period'), equals(StatisticPeriod.week));
      expect(StatisticPeriod.fromString(''), equals(StatisticPeriod.week));
    });
  });

  group('NotificationCategory 通知分类枚举测试', () {
    test('1. 通知 Payload 类型解析', () {
      expect(NotificationCategory.fromString('call_history'), equals(NotificationCategory.callHistory));
      expect(NotificationCategory.fromString('fraud_alert'), equals(NotificationCategory.fraudAlert));
      expect(NotificationCategory.fromString('blocked_call'), equals(NotificationCategory.blockedCall));
      expect(NotificationCategory.fromString('stir_result'), equals(NotificationCategory.stirResult));
      expect(NotificationCategory.fromString('deletion_proposal'), equals(NotificationCategory.deletionProposal));
    });

    test('2. 脏数据容错 (默认降级为 unknown)', () {
      expect(NotificationCategory.fromString('unknown_type'), equals(NotificationCategory.unknown));
      expect(NotificationCategory.fromString(''), equals(NotificationCategory.unknown));
    });

    test('3. 双向导向 toRawString 对比', () {
      expect(NotificationCategory.callHistory.toRawString(), equals('call_history'));
      expect(NotificationCategory.fraudAlert.toRawString(), equals('fraud_alert'));
      expect(NotificationCategory.blockedCall.toRawString(), equals('blocked_call'));
      expect(NotificationCategory.stirResult.toRawString(), equals('stir_result'));
      expect(NotificationCategory.deletionProposal.toRawString(), equals('deletion_proposal'));
    });
  });
}
