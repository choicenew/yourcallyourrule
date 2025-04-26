import 'package:flutter/foundation.dart';
import '../../../application/usecases/call/filter_call.dart';
import '../../../../lib/application/usecases/call/log_call.dart';
import '../../../domain/entities/call/call_log.dart';
import '../base/base_provider.dart';

/// 通话Provider
/// 负责管理通话相关的状态
class CallProvider extends BaseProvider {
  final FilterCall _filterCall;
  final LogCall _logCall;

  List<CallLog> _callLogs = [];
  CallLog? _selectedCall;

  /// 构造函数
  CallProvider({
    required FilterCall filterCall,
    required LogCall logCall,
  }) : _filterCall = filterCall,
       _logCall = logCall;

  /// 获取所有通话记录
  List<CallLog> get callLogs => _callLogs;

  /// 获取选中的通话记录
  CallLog? get selectedCall => _selectedCall;

  /// 设置选中的通话记录
  void selectCall(CallLog? call) {
    _selectedCall = call;
    notifyListeners();
  }

  /// 加载通话记录
  Future<void> loadCallLogs() async {
    setLoading(true);
    clearError();

    try {
      // 这里应该调用获取通话记录的用例
      // 由于架构中没有明确定义，这里暂时留空
      // 实际实现时应该添加相应的用例
      setLoading(false);
    } catch (e) {
      setError(e.toString());
      setLoading(false);
    }
  }

  /// 过滤来电
  Future<bool> filterIncomingCall(String phoneNumber) async {
    clearError();

    try {
      final result = await _filterCall.execute(phoneNumber);
      return result.fold(
        (failure) {
          setError(failure.message);
          return false; // 默认不过滤
        },
        (shouldFilter) => shouldFilter,
      );
    } catch (e) {
      setError(e.toString());
      return false; // 出错时默认不过滤
    }
  }

  /// 记录通话
  Future<void> logCallEvent(CallLog call) async {
    clearError();

    try {
      final result = await _logCall.execute(call);
      result.fold(
        (failure) => setError(failure.message),
        (_) {
          // 添加到本地列表
          _callLogs.insert(0, call); // 添加到列表开头
          notifyListeners();
        },
      );
    } catch (e) {
      setError(e.toString());
    }
  }

  /// 清除通话记录
  void clearCallLogs() {
    _callLogs.clear();
    notifyListeners();
  }

  /// 按日期筛选通话记录
  List<CallLog> filterCallLogsByDate(DateTime date) {
    return _callLogs.where((call) {
      final callDate = call.timestamp;
      return callDate.year == date.year &&
             callDate.month == date.month &&
             callDate.day == date.day;
    }).toList();
  }

  /// 按电话号码筛选通话记录
  List<CallLog> filterCallLogsByNumber(String phoneNumber) {
    return _callLogs.where((call) {
      return call.phoneNumber.value == phoneNumber;
    }).toList();
  }
}