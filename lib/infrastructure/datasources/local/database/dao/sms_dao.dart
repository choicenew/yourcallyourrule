import '../../../../../domain/entities/sms/sms_message.dart';
import '../../../../../domain/value_objects/phone_number.dart';
import 'base_dao.dart';

/// 短信数据访问对象
/// 负责短信数据的数据库操作
class SmsDao extends BaseDao<SmsMessage> {
  @override
  String get tableName => 'sms_messages';
  
  @override
  SmsMessage fromMap(Map<String, dynamic> map) {
    return SmsMessage(
      id: map['id'] as String,
      phoneNumber: PhoneNumber(map['phone_number'] as String),
      name: map['name'] as String?,
      content: map['content'] as String,
      timestamp: DateTime.fromMillisecondsSinceEpoch(map['timestamp'] as int),
      smsType: map['sms_type'] as String,
      actionTaken: map['action_taken'] as String?,
      ruleId: map['rule_id'] as String?,
      isRead: (map['is_read'] as int) == 1,
    );
  }
  
  @override
  Map<String, dynamic> toMap(SmsMessage smsMessage) {
    return {
      'id': smsMessage.id,
      'phone_number': smsMessage.phoneNumber.value,
      'name': smsMessage.name,
      'content': smsMessage.content,
      'timestamp': smsMessage.timestamp.millisecondsSinceEpoch,
      'sms_type': smsMessage.smsType,
      'action_taken': smsMessage.actionTaken,
      'rule_id': smsMessage.ruleId,
      'is_read': smsMessage.isRead ? 1 : 0,
    };
  }
  
  /// 获取最近的短信
  Future<List<SmsMessage>> getRecent(int limit) async {
    return await query(
      orderBy: 'timestamp DESC',
      limit: limit,
    );
  }
  
  /// 根据电话号码获取短信
  Future<List<SmsMessage>> getByPhoneNumber(String phoneNumber) async {
    return await query(
      where: 'phone_number = ?',
      whereArgs: [phoneNumber],
      orderBy: 'timestamp DESC',
    );
  }
  
  /// 根据短信类型获取短信
  Future<List<SmsMessage>> getBySmsType(String smsType) async {
    return await query(
      where: 'sms_type = ?',
      whereArgs: [smsType],
      orderBy: 'timestamp DESC',
    );
  }
  
  /// 根据规则ID获取短信
  Future<List<SmsMessage>> getByRuleId(String ruleId) async {
    return await query(
      where: 'rule_id = ?',
      whereArgs: [ruleId],
      orderBy: 'timestamp DESC',
    );
  }
  
  /// 获取未读短信
  Future<List<SmsMessage>> getUnread() async {
    return await query(
      where: 'is_read = ?',
      whereArgs: [0],
      orderBy: 'timestamp DESC',
    );
  }
  
  /// 标记短信为已读
  Future<void> markAsRead(String id) async {
    final db = await database;
    await db.update(
      tableName,
      {'is_read': 1},
      where: 'id = ?',
      whereArgs: [id],
    );
  }
  
  /// 获取指定日期范围内的短信
  Future<List<SmsMessage>> getByDateRange(DateTime start, DateTime end) async {
    return await query(
      where: 'timestamp BETWEEN ? AND ?',
      whereArgs: [start.millisecondsSinceEpoch, end.millisecondsSinceEpoch],
      orderBy: 'timestamp DESC',
    );
  }
}