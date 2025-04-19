import '../../../domain/services/caller_id_monitor_service.dart';
import '../../../domain/value_objects/phone_number.dart';
import '../base_usecase.dart';

/// 判断是否接听来电用例
class ShouldAcceptCallUseCase implements UseCase<bool, PhoneNumber> {
  final CallerIdMonitorService _callerIdMonitorService;
  
  ShouldAcceptCallUseCase(this._callerIdMonitorService);
  
  @override
  Future<bool> call(PhoneNumber params) async {
    return await _callerIdMonitorService.shouldAcceptCall(params);
  }
}