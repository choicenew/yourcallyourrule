// 呼叫保护服务，用于检查呼叫保护是否激活

import 'package:yourcallyourrule/features/caller_id/services/call_screen_plugin.dart';

class CallProtectionService {
  // 单例模式
  static final CallProtectionService _instance = CallProtectionService._internal();
  factory CallProtectionService() => _instance;
  CallProtectionService._internal();
  
  // 缓存呼叫保护状态，避免频繁调用原生方法
  bool? _isProtectionActive;
  
  /// 检查呼叫保护是否激活
  /// 返回true表示已激活，false表示未激活
  Future<bool> isProtectionActive() async {
    // 如果已有缓存结果，直接返回
    if (_isProtectionActive != null) {
      return _isProtectionActive!;
    }
    
    // 调用CallScreeningPlugin检查是否有呼叫屏蔽权限
    _isProtectionActive = await CallScreeningPlugin.requestCallScreeningRole();
    return _isProtectionActive!;
  }
  
  /// 清除缓存的保护状态，强制下次重新检查
  void clearCachedStatus() {
    _isProtectionActive = null;
  }
}