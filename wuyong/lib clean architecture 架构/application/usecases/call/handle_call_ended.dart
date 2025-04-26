import '../../../domain/services/caller_id_monitor_service.dart';
import '../base_usecase.dart';

/// 处理通话结束用例
class HandleCallEndedUseCase implements UseCase<void, void> {
  final CallerIdMonitorService _callerIdMonitorService;
  
  HandleCallEndedUseCase(this._callerIdMonitorService);
  
  @override
  Future<void> call([void params]) async {
    await _callerIdMonitorService.handleCallEnded();
  }
}