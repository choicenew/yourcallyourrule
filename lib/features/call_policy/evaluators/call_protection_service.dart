import 'package:yourcallyourrule/features/call_monitor/services/call_screen_plugin.dart';

/// 呼叫保护检查服务
class CallProtectionService {
  static final CallProtectionService _instance = CallProtectionService._internal();
  factory CallProtectionService() => _instance;
  CallProtectionService._internal();
  
  bool? _isProtectionActive;
  
  Future<bool> isProtectionActive() async {
    if (_isProtectionActive != null) {
      return _isProtectionActive!;
    }
    
    _isProtectionActive = await CallScreeningPlugin.requestCallScreeningRole();
    return _isProtectionActive!;
  }
  
  void clearCachedStatus() {
    _isProtectionActive = null;
  }
}
