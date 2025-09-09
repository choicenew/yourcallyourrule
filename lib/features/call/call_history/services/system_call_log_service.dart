import 'package:call_log/call_log.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';
import 'package:yourcallyourrule/core/entities/call/call_log.dart' as app_call_log;
import 'package:yourcallyourrule/features/call/call_history/services/call_log_service.dart';

/// 系统通话记录服务
/// 使用call_log插件读取系统通话记录（注意：这是新添加的功能）
/// 当应用有系统权限时，可以使用此服务读取系统通话记录
/// 并将其转换为应用内通话记录格式
/// 
/// 此服务与call_log_recorder.dart不同：
/// - call_log_recorder.dart：记录应用内产生的通话记录
/// - system_call_log_service.dart：读取系统通话记录并同步到应用内
class SystemCallLogService {
  final CallLogService _callLogService;

  /// 构造函数
  SystemCallLogService(this._callLogService);

  /// 检查是否有读取通话记录的权限
  Future<bool> hasCallLogPermission() async {
    final status = await Permission.phone.status;
    return status.isGranted;
  }

  /// 请求读取通话记录的权限
  Future<bool> requestCallLogPermission() async {
    final status = await Permission.phone.request();
    return status.isGranted;
  }

  /// 从系统读取通话记录并同步到应用内
  /// 返回同步的记录数量
  Future<int> syncSystemCallLogs() async {
    // 检查权限
    if (!await hasCallLogPermission()) {
      return 0; // 没有权限，返回0
    }

    try {
      // 获取最后一条记录的时间戳，用于增量同步
      final lastLog = await _callLogService.getLastLog();
      final lastTimestamp = lastLog?.timestamp ?? DateTime(2000); // 如果没有记录，使用较早的日期

      // 从系统获取通话记录
      final systemLogs = await CallLog.query();
      int syncCount = 0;

      // 转换并保存记录
      for (var entry in systemLogs) {
        // 跳过已同步的记录
        final callTimestamp = DateTime.fromMillisecondsSinceEpoch(entry.timestamp ?? 0);
        if (callTimestamp.isBefore(lastTimestamp)) {
          continue;
        }

        // 转换通话类型
        String callType = _mapCallType(entry.callType);

        // 创建应用内通话记录对象
        final appLog = app_call_log.CallLog(
          id: entry.id?.toString() ?? const Uuid().v4(),
          phoneNumber: entry.number ?? '',
          name: entry.name ?? '',
          timestamp: callTimestamp,
          simDisplayName: entry.simDisplayName ?? '',
          callType: callType,
          simSlotIndex: _getSimSlotIndexFromAccountId(entry.phoneAccountId),
          // 以下字段可能在系统记录中不存在，使用默认值
          carrierName: '',
          countryIso: '',
          subscriptionId: 0,
          labelIds: [],
        );

        // 保存到应用内数据库
        await _callLogService.addLog(appLog);
        syncCount++;
      }

      return syncCount;
    } catch (e) {
      print('同步系统通话记录错误: $e');
      return 0;
    }
  }

  /// 根据通话记录中的 phoneAccountId 推断 SIM 卡槽索引。
  ///
  /// 此实现基于对 Android `call_log` 插件行为的观察和您提供的原生代码逻辑：
  /// 1. `phoneAccountId` 在很多设备上直接对应 SIM 卡的索引值（例如 "0", "1"）。
  /// 2. 这是一个合理的备用方案，因为在纯 Dart 环境中无法直接访问 Android 的 TelecomManager 来获取通话账户列表并查找索引。
  ///
  /// @param accountId 从 `CallLogEntry` 获取的 `phoneAccountId`。
  /// @return 解析出的整数索引，如果解析失败或为空，则默认为 0。
  int _getSimSlotIndexFromAccountId(String? accountId) {
    if (accountId == null || accountId.isEmpty) {
      return 0; // 如果 accountId 为空，默认为卡槽 0
    }
    // 尝试将 accountId 直接解析为整数。这在许多 Android 版本和设备上是有效的。
    final int? parsedIndex = int.tryParse(accountId);
    // 如果解析成功且为非负数，则使用该值。否则，默认为 0。
    return (parsedIndex != null && parsedIndex >= 0) ? parsedIndex : 0;
  }

  /// 将系统通话类型映射到应用内通话类型
  String _mapCallType(CallType? callType) {
    switch (callType) {
      case CallType.incoming:
        return 'incoming';
      case CallType.outgoing:
        return 'outgoing';
      case CallType.missed:
        return 'missed';
      case CallType.rejected:
        return 'rejected';
      case CallType.blocked:
        return 'blocked';
      case CallType.voiceMail:
        return 'voicemail';
      default:
        return 'unknown';
    }
  }
}