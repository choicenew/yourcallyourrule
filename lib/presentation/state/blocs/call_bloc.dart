import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../application/usecases/call/filter_call.dart';
import '../../../application/usecases/call/log_call.dart';
import '../../../domain/entities/call/call_log.dart';
import '../base/base_bloc.dart';

// 通话事件
abstract class CallEvent extends BaseEvent {}

// 加载通话记录事件
class LoadCallLogsEvent extends CallEvent {}

// 过滤来电事件
class FilterCallEvent extends CallEvent {
  final String phoneNumber;
  
  FilterCallEvent(this.phoneNumber);
}

// 记录通话事件
class LogCallEvent extends CallEvent {
  final CallLog call;
  
  LogCallEvent(this.call);
}

// 清除通话记录事件
class ClearCallLogsEvent extends CallEvent {}

// 通话状态
abstract class CallState extends BaseState {}

// 通话记录加载成功状态
class CallLogsLoadedState extends LoadedState<List<CallLog>> {
  CallLogsLoadedState(List<CallLog> calls) : super(calls);
}

// 通话过滤结果状态
class CallFilteredState extends LoadedState<bool> {
  CallFilteredState(bool shouldFilter) : super(shouldFilter);
}

// 通话记录成功状态
class CallLoggedState extends LoadedState<CallLog> {
  CallLoggedState(CallLog call) : super(call);
}

// 通话操作成功状态
class CallOperationSuccessState extends BaseState {
  final String message;
  
  CallOperationSuccessState(this.message);
}

/// 通话Bloc
/// 负责处理通话相关的事件和状态
class CallBloc extends Bloc<CallEvent, CallState> {
  final FilterCall _filterCall;
  final LogCall _logCall;
  
  List<CallLog> _callLogs = [];
  
  CallBloc({
    required FilterCall filterCall,
    required LogCall logCall,
  }) : _filterCall = filterCall,
       _logCall = logCall,
       super(InitialState()) {
    on<LoadCallLogsEvent>(_onLoadCallLogs);
    on<FilterCallEvent>(_onFilterCall);
    on<LogCallEvent>(_onLogCall);
    on<ClearCallLogsEvent>(_onClearCallLogs);
  }
  
  // 处理加载通话记录事件
  Future<void> _onLoadCallLogs(LoadCallLogsEvent event, Emitter<CallState> emit) async {
    emit(LoadingState());
    
    try {
      // 这里应该调用获取通话记录的用例
      // 由于架构中没有明确定义，这里暂时使用本地缓存的数据
      emit(CallLogsLoadedState(_callLogs));
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }
  
  // 处理过滤来电事件
  Future<void> _onFilterCall(FilterCallEvent event, Emitter<CallState> emit) async {
    emit(LoadingState());
    
    try {
      final result = await _filterCall.execute(event.phoneNumber);
      result.fold(
        (failure) => emit(ErrorState(failure.message)),
        (shouldFilter) => emit(CallFilteredState(shouldFilter)),
      );
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }
  
  // 处理记录通话事件
  Future<void> _onLogCall(LogCallEvent event, Emitter<CallState> emit) async {
    emit(LoadingState());
    
    try {
      final result = await _logCall.execute(event.call);
      result.fold(
        (failure) => emit(ErrorState(failure.message)),
        (_) {
          // 添加到本地列表
          _callLogs.insert(0, event.call); // 添加到列表开头
          emit(CallLoggedState(event.call));
          emit(CallOperationSuccessState('通话记录已保存'));
        },
      );
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }
  
  // 处理清除通话记录事件
  void _onClearCallLogs(ClearCallLogsEvent event, Emitter<CallState> emit) {
    emit(LoadingState());
    
    try {
      _callLogs.clear();
      emit(CallLogsLoadedState(_callLogs));
      emit(CallOperationSuccessState('通话记录已清除'));
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }
  
  // 按日期筛选通话记录
  List<CallLog> filterCallLogsByDate(DateTime date) {
    return _callLogs.where((call) {
      final callDate = call.timestamp;
      return callDate.year == date.year &&
             callDate.month == date.month &&
             callDate.day == date.day;
    }).toList();
  }
  
  // 按电话号码筛选通话记录
  List<CallLog> filterCallLogsByNumber(String phoneNumber) {
    return _callLogs.where((call) {
      return call.phoneNumber.value == phoneNumber;
    }).toList();
  }
}