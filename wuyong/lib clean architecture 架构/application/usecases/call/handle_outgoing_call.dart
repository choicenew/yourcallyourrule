import 'dart:async';

import '../../../domain/entities/caller/caller_id_data.dart';
import '../../../domain/services/caller_id_monitor_service.dart';
import '../../../domain/value_objects/phone_number.dart';
import '../base_usecase.dart';

/// 处理去电用例
class HandleOutgoingCallUseCase implements UseCase<CallerIdData, PhoneNumber> {
  final CallerIdMonitorService _callerIdMonitorService;
  
  HandleOutgoingCallUseCase(this._callerIdMonitorService);
  
  @override
  Future<CallerIdData> call(PhoneNumber params) async {
    await _callerIdMonitorService.handleOutgoingCall(params);
    
    // 等待来电数据流中的最新数据
    final completer = Completer<CallerIdData>();
    final subscription = _callerIdMonitorService.callDataStream.listen((data) {
      if (data.phoneNumber.value == params.value) {
        completer.complete(data);
      }
    });
    
    final result = await completer.future;
    await subscription.cancel();
    return result;
  }
}