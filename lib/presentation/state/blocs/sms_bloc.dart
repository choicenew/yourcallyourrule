import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../application/usecases/sms/filter_sms.dart';
import '../../../application/usecases/sms/log_sms.dart';
import '../../../domain/entities/sms/sms_message.dart';
import '../base/base_bloc.dart';

// 短信事件
abstract class SmsEvent extends BaseEvent {}

// 加载短信记录事件
class LoadSmsMessagesEvent extends SmsEvent {}

// 过滤短信事件
class FilterSmsEvent extends SmsEvent {
  final String phoneNumber;
  final String content;
  
  FilterSmsEvent(this.phoneNumber, this.content);
}

// 记录短信事件
class LogSmsEvent extends SmsEvent {
  final SmsMessage message;
  
  LogSmsEvent(this.message);
}

// 清除短信记录事件
class ClearSmsMessagesEvent extends SmsEvent {}

// 短信状态
abstract class SmsState extends BaseState {}

// 短信记录加载成功状态
class SmsMessagesLoadedState extends LoadedState<List<SmsMessage>> {
  SmsMessagesLoadedState(List<SmsMessage> messages) : super(messages);
}

// 短信过滤结果状态
class SmsFilteredState extends LoadedState<bool> {
  SmsFilteredState(bool shouldFilter) : super(shouldFilter);
}

// 短信记录成功状态
class SmsLoggedState extends LoadedState<SmsMessage> {
  SmsLoggedState(SmsMessage message) : super(message);
}

// 短信操作成功状态
class SmsOperationSuccessState extends BaseState {
  final String message;
  
  SmsOperationSuccessState(this.message);
}

/// 短信Bloc
/// 负责处理短信相关的事件和状态
class SmsBloc extends Bloc<SmsEvent, SmsState> {
  final FilterSms _filterSms;
  final LogSms _logSms;
  
  List<SmsMessage> _smsMessages = [];
  
  SmsBloc({
    required FilterSms filterSms,
    required LogSms logSms,
  }) : _filterSms = filterSms,
       _logSms = logSms,
       super(InitialState()) {
    on<LoadSmsMessagesEvent>(_onLoadSmsMessages);
    on<FilterSmsEvent>(_onFilterSms);
    on<LogSmsEvent>(_onLogSms);
    on<ClearSmsMessagesEvent>(_onClearSmsMessages);
  }
  
  // 处理加载短信记录事件
  Future<void> _onLoadSmsMessages(LoadSmsMessagesEvent event, Emitter<SmsState> emit) async {
    emit(LoadingState());
    
    try {
      // 这里应该调用获取短信记录的用例
      // 由于架构中没有明确定义，这里暂时使用本地缓存的数据
      emit(SmsMessagesLoadedState(_smsMessages));
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }
  
  // 处理过滤短信事件
  Future<void> _onFilterSms(FilterSmsEvent event, Emitter<SmsState> emit) async {
    emit(LoadingState());
    
    try {
      final result = await _filterSms.execute(event.phoneNumber, event.content);
      result.fold(
        (failure) => emit(ErrorState(failure.message)),
        (shouldFilter) => emit(SmsFilteredState(shouldFilter)),
      );
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }
  
  // 处理记录短信事件
  Future<void> _onLogSms(LogSmsEvent event, Emitter<SmsState> emit) async {
    emit(LoadingState());
    
    try {
      final result = await _logSms.execute(event.message);
      result.fold(
        (failure) => emit(ErrorState(failure.message)),
        (_) {
          // 添加到本地列表
          _smsMessages.insert(0, event.message); // 添加到列表开头
          emit(SmsLoggedState(event.message));
          emit(SmsOperationSuccessState('短信记录已保存'));
        },
      );
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }
  
  // 处理清除短信记录事件
  void _onClearSmsMessages(ClearSmsMessagesEvent event, Emitter<SmsState> emit) {
    emit(LoadingState());
    
    try {
      _smsMessages.clear();
      emit(SmsMessagesLoadedState(_smsMessages));
      emit(SmsOperationSuccessState('短信记录已清除'));
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }
  
  // 按日期筛选短信记录
  List<SmsMessage> filterSmsMessagesByDate(DateTime date) {
    return _smsMessages.where((message) {
      final messageDate = message.timestamp;
      return messageDate.year == date.year &&
             messageDate.month == date.month &&
             messageDate.day == date.day;
    }).toList();
  }
  
  // 按电话号码筛选短信记录
  List<SmsMessage> filterSmsMessagesByNumber(String phoneNumber) {
    return _smsMessages.where((message) {
      return message.phoneNumber.value == phoneNumber;
    }).toList();
  }
  
  // 按内容关键词筛选短信记录
  List<SmsMessage> filterSmsMessagesByContent(String keyword) {
    return _smsMessages.where((message) {
      return message.content.toLowerCase().contains(keyword.toLowerCase());
    }).toList();
  }
}