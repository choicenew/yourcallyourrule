import 'package:flutter_test/flutter_test.dart';
import 'package:yourcallyourrule/features/caller_id/config/caller_id_config_provider.dart';
import 'package:yourcallyourrule/features/caller_id/config/caller_id_config_repository.dart';
import 'package:yourcallyourrule/features/caller_id/config/display_mode.dart';

void main() {
  group('Notification Configuration & Handler State Tests', () {
    test('1. 验证 CallerIdConfig 通知配置默认值与反序列化', () {
      final map = <String, dynamic>{
        CallerIdConfigRepository.useLocalNotificationKey: true,
        CallerIdConfigRepository.cancelLocalNotificationKey: true,
        CallerIdConfigRepository.useStirNotificationKey: false,
        CallerIdConfigRepository.displayModeKey: 'notification',
        CallerIdConfigRepository.notificationAutoCancelDelayKey: 10,
      };

      final config = CallerIdConfig.fromMap(map);

      expect(config.useLocalNotification, isTrue);
      expect(config.cancelLocalNotification, isTrue);
      expect(config.useStirNotification, isFalse);
      expect(config.displayMode, equals(DisplayMode.notification));
      expect(config.notificationAutoCancelDelay, equals(const Duration(seconds: 10)));
    });

    test('2. 验证 CallerIdConfig.toMap() 序列化输出对齐', () {
      const config = CallerIdConfig(
        useLocalNotification: true,
        cancelLocalNotification: true,
        useStirNotification: true,
        displayMode: DisplayMode.notification,
        notificationAutoCancelDelay: Duration(seconds: 15),
      );

      final map = config.toMap();

      expect(map[CallerIdConfigRepository.useLocalNotificationKey], isTrue);
      expect(map[CallerIdConfigRepository.cancelLocalNotificationKey], isTrue);
      expect(map[CallerIdConfigRepository.useStirNotificationKey], isTrue);
      expect(map[CallerIdConfigRepository.displayModeKey], equals('notification'));
      expect(map[CallerIdConfigRepository.notificationAutoCancelDelayKey], equals(15));
    });

    test('3. 验证 CallerIdConfig.copyWith 不可变修改与状态更新', () {
      const initialConfig = CallerIdConfig(
        useLocalNotification: false,
        cancelLocalNotification: false,
        useStirNotification: false,
        displayMode: DisplayMode.overlay,
        notificationAutoCancelDelay: Duration(seconds: 5),
      );

      final updatedConfig = initialConfig.copyWith(
        useLocalNotification: true,
        cancelLocalNotification: true,
        notificationAutoCancelDelay: const Duration(seconds: 8),
      );

      // 验证未修改的属性保持原样
      expect(updatedConfig.displayMode, equals(DisplayMode.overlay));
      expect(updatedConfig.useStirNotification, isFalse);

      // 验证修改的属性更新生效
      expect(updatedConfig.useLocalNotification, isTrue);
      expect(updatedConfig.cancelLocalNotification, isTrue);
      expect(updatedConfig.notificationAutoCancelDelay, equals(const Duration(seconds: 8)));
    });

    test('4. 验证缺少 Key 时 fromMap() 脏数据降级回退', () {
      final emptyMap = <String, dynamic>{};
      final fallbackConfig = CallerIdConfig.fromMap(emptyMap);

      expect(fallbackConfig.useLocalNotification, isFalse);
      expect(fallbackConfig.cancelLocalNotification, isFalse);
      expect(fallbackConfig.displayMode, equals(DisplayMode.liveActivity));
      expect(
        fallbackConfig.notificationAutoCancelDelay.inSeconds,
        equals(CallerIdConfigRepository.defaultNotificationAutoCancelDelayInSeconds),
      );
    });
  });
}
