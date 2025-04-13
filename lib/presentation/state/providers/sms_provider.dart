import 'package:flutter/foundation.dart';
import '../../../application/usecases/sms/filter_sms.dart';
import '../../../application/usecases/sms/log_sms.dart';
import '../../../domain/entities/sms/sms_message.dart';
import '../base/base_provider.dart';

/// 短信Provider
/// 负责管理短信相关的状态
class SmsProvider extends BaseProvider {
  final FilterSms _filterSms;
  final LogSms _logSms;

  List<SmsMessage> _smsMessages = [];
  SmsMessage? _selectedMessage;

  /// 构造函数
  SmsProvider({
    required FilterSms filterSms,
    required LogSms logSms,
  }) : _filterSms = filterSms,
       _logSms = logSms;

  /// 获取所有短信消息
  List<SmsMessage> get smsMessages => _smsMessages;

  /// 获取选中的短信消息
  SmsMessage? get selectedMessage => _selectedMessage;

  /// 设置选中的短信消息
  void selectMessage(SmsMessage? message) {
    _selectedMessage = message;
    notifyListeners();
  }

  /// 加载短信消息
  Future<void> loadSmsMessages() async {
    setLoading(true);
    clearError();

    try {
      // 这里应该调用获取短信消息的用例
      // 由于架构中没有明确定义，这里暂时留空
      // 实际实现时应该添加相应的用例
      setLoading(false);
    } catch (e) {
      setError(e.toString());
      setLoading(false);
    }
  }

  /// 过滤短信
  Future<bool> filterIncomingSms(String phoneNumber, String content) async {
    clearError();

    try {
      final result = await _filterSms.execute(phoneNumber, content);
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

  /// 记录短信
  Future<void> logSmsEvent(SmsMessage message) async {
    clearError();

    try {
      final result = await _logSms.execute(message);
      result.fold(
        (failure) => setError(failure.message),
        (_) {
          // 添加到本地列表
          _smsMessages.insert(0, message); // 添加到列表开头
          notifyListeners();
        },
      );
    } catch (e) {
      setError(e.toString());
    }
  }

  /// 清除短信记录
  void clearSmsMessages() {
    _smsMessages.clear();
    notifyListeners();
  }

  /// 按日期筛选短信记录
  List<SmsMessage> filterSmsMessagesByDate(DateTime date) {
    return _smsMessages.where((message) {
      final messageDate = message.timestamp;
      return messageDate.year == date.year &&
             messageDate.month == date.month &&
             messageDate.day == date.day;
    }).toList();
  }

  /// 按电话号码筛选短信记录
  List<SmsMessage> filterSmsMessagesByNumber(String phoneNumber) {
    return _smsMessages.where((message) {
      return message.phoneNumber.value == phoneNumber;
    }).toList();
  }

  /// 按内容关键词筛选短信记录
  List<SmsMessage> filterSmsMessagesByContent(String keyword) {
    return _smsMessages.where((message) {
      return message.content.toLowerCase().contains(keyword.toLowerCase());
    }).toList();
  }
}