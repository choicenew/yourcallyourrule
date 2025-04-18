import '../../domain/entities/call/call_log.dart';
import '../../domain/repositories/call_repository.dart';
import '../../domain/value_objects/phone_number.dart';
import '../datasources/local/database/app_database.dart';
import '../datasources/local/database/dao/call_dao.dart';
import 'base_repository_impl.dart';

/// 通话记录仓库实现
/// 实现通话记录仓库接口，提供通话记录相关的数据操作
class CallRepositoryImpl extends BaseRepositoryImpl<CallLog, CallDao> implements CallRepository {
  CallRepositoryImpl(AppDatabase database)
      : super(database, database.callDao);
  
  @override
  Future<List<CallLog>> getRecent(int limit) async {
    return await dao.getRecent(limit);
  }
  
  @override
  Future<List<CallLog>> getByPhoneNumber(String phoneNumberValue) async {
    try {
      final phoneNumber = PhoneNumber(phoneNumberValue);
      return await dao.getByPhoneNumber(phoneNumber.normalized);
    } catch (e) {
      return [];
    }
  }
  
  @override
  Future<List<CallLog>> getByType(CallType type) async {
    return await dao.getByCallType(type.toString());
  }
  
  Future<List<CallLog>> getByDateRange(DateTime start, DateTime end) async {
    return await dao.getByDateRange(start, end);
  }
  
  Future<List<CallLog>> getByRuleId(String ruleId) async {
    return await dao.getByRuleId(ruleId);
  }
  
  @override
  Future<void> markAsRead(String id) async {
    final call = await getById(id);
    if (call != null && !call.isRead) {
      final updatedCall = call.copyWith(isRead: true);
      await update(updatedCall);
    }
  }
  
  Future<void> addNote(String id, String note) async {
    final call = await getById(id);
    if (call != null) {
      final updatedCall = call.copyWith(note: note);
      await update(updatedCall);
    }
  }
  
  @override
  Future<List<CallLog>> getBlocked() async {
    return await dao.getByCallType(CallType.blocked.toString());
  }
  
  @override
  Future<List<CallLog>> getUnread() async {
    return await dao.query(
      where: 'is_read = ?',
      whereArgs: [0],
      orderBy: 'timestamp DESC',
    );
  }
  
  @override
  Future<int> getCount() async {
    final calls = await dao.getAll();
    return calls.length;
  }
  
  @override
  Future<void> clearAll() async {
    await dao.clear();
  }
}