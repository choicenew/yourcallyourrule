// lib/features/call/live_activities/handlers/live_activity_handler.dart

import 'package:live_activities/live_activities.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yourcallyourrule/features/call/live_activities/services/notification_payload_builder.dart';

import 'package:uuid/uuid.dart';
import 'package:yourcallyourrule/core/entities/caller_id_data.dart';
import 'package:yourcallyourrule/core/entities/call/sim_info.dart';
import 'package:yourcallyourrule/core/entities/call/stir_info.dart';

import 'package:yourcallyourrule/features/call/live_activities/services/live_notification_config_service.dart';

import 'package:yourcallyourrule/core/provider/providers/config_repository_provider.dart'; // 确保这个 import 存在

part 'live_activity_handler.g.dart';

// --- 100% 模仿你的 notificationHandler Provider 模式 ---
@Riverpod(keepAlive: true)
Future<LiveActivityHandler> liveActivityHandler(Ref ref) async {
  final configRepository = ref.watch(configRepositoryProvider);
  final configService = LiveNotificationConfigService(configRepository);
  
  final handler = LiveActivityHandler(configService: configService);
  await handler.initialize();
  return handler;
}


/// Live Activity 处理器
/// 专门负责处理 Live Activity 相关的创建、更新和结束逻辑
class LiveActivityHandler {
  final LiveNotificationConfigService _configService;
  final LiveActivities _liveActivitiesPlugin;
  final Uuid _uuid;

  String? _currentActivityId;

  /// 构造函数
  LiveActivityHandler({
    required LiveNotificationConfigService configService,
  })  : _configService = configService,
        _liveActivitiesPlugin = LiveActivities(),
        _uuid = const Uuid();

  /// 初始化
  Future<void> initialize() async {
    // 这里的 appGroupId 需要是你在 Android 项目中配置的
    await _liveActivitiesPlugin.init(appGroupId: "group.com.yours.yourcallyourrule");
  }

  /// 显示或更新来电信息 Live Activity
  Future<void> showCallerIdActivity({
    required CallerIdData callerIdData,
    required SimInfo? simInfo,
    required StirInfo? stirInfo,
  }) async {
    try {
      final config = await _configService.loadConfigOrDefault();
      final payload = await LiveNotificationPayloadBuilder.build(
        config,
        callerIdData,
        simInfo,
        stirInfo,
      );

      if (_currentActivityId != null) {
        await _liveActivitiesPlugin.updateActivity(_currentActivityId!, payload);
      } else {
        final newActivityId = _uuid.v4();
        await _liveActivitiesPlugin.createActivity(newActivityId, payload);
        _currentActivityId = newActivityId;
      }
    } catch (e) {
      print('Failed to show/update Live Activity: $e');
    }
  }

  /// 结束当前的 Live Activity
  Future<void> endActivity() async {
    if (_currentActivityId != null) {
      try {
        await _liveActivitiesPlugin.endActivity(_currentActivityId!);
        _currentActivityId = null;
      } catch (e) {
        print('Failed to end Live Activity: $e');
        _currentActivityId = null;
      }
    }
  }
}