import '../../../../../domain/entities/call/call_log.dart';
import '../../../../../domain/value_objects/phone_number.dart';
import 'base_dao.dart';

/// 通话记录数据访问对象
/// 负责通话记录数据的数据库操作
class CallDao extends BaseDao<CallLog> {
  @override
  String get tableName => 'call_logs';
  
  @override
  CallLog fromMap(Map<String, dynamic> map) {
    return CallLog(
      id: map['id'] as String,
      phoneNumber: PhoneNumber(map['phone_number'] as String),
      name: map['name'] as String?,
      duration: Duration(seconds: map['duration'] as int),
      timestamp: DateTime.fromMillisecondsSinceEpoch(map['timestamp'] as int),
      callType: CallType.values.firstWhere(
        (type) => type.toString() == map['call_type'],
        orElse: () => CallType.unknown,
      ),
      source: map['source'] as String,
      ruleId: map['rule_id'] as String?,
      note: map['note'] as String?,
      isRead: (map['is_read'] as int?) == 1,
    );
  }
  
  @override
  Map<String, dynamic> toMap(CallLog callLog) {
    return {
      'id': callLog.id,
      'phone_number': callLog.phoneNumber.value,
      'name': callLog.name,
      'duration': callLog.duration?.inSeconds,
      'timestamp': callLog.timestamp.millisecondsSinceEpoch,
      'call_type': callLog.callType.toString(),
      'source': callLog.source,
      'rule_id': callLog.ruleId,
      'note': callLog.note,
      'is_read': callLog.isRead ? 1 : 0,
    };
  }
  
  /// 获取最近的通话记录
  Future<List<CallLog>> getRecent(int limit) async {
    return await query(
      orderBy: 'timestamp DESC',
      limit: limit,
    );
  }
  
  /// 根据电话号码获取通话记录
  Future<List<CallLog>> getByPhoneNumber(String phoneNumber) async {
    return await query(
      where: 'phone_number = ?',
      whereArgs: [phoneNumber],
      orderBy: 'timestamp DESC',
    );
  }
  
  /// 根据通话类型获取通话记录
  Future<List<CallLog>> getByCallType(String callType) async {
    return await query(
      where: 'call_type = ?',
      whereArgs: [callType],
      orderBy: 'timestamp DESC',
    );
  }
  
  /// 根据规则ID获取通话记录
  Future<List<CallLog>> getByRuleId(String ruleId) async {
    return await query(
      where: 'rule_id = ?',
      whereArgs: [ruleId],
      orderBy: 'timestamp DESC',
    );
  }
  
  /// 获取指定日期范围内的通话记录
  Future<List<CallLog>> getByDateRange(DateTime start, DateTime end) async {
    return await query(
      where: 'timestamp BETWEEN ? AND ?',
      whereArgs: [start.millisecondsSinceEpoch, end.millisecondsSinceEpoch],
      orderBy: 'timestamp DESC',
    );
  }
}