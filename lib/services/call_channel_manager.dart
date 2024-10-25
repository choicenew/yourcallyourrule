// channel_manager.dart
import 'package:flutter/services.dart';

class CallChannelManager {
  static const callerIdChannel = MethodChannel('com.yours.yourcallyourrule/caller_id');
 static const endCallChannel = MethodChannel('com.yours.yourcallyourrule/end_call');
  static const shouldAcceptCallChannel = MethodChannel('com.yours.yourcallyourrule/should_accept_call');
  static const stirChannel = MethodChannel('com.yours.yourcallyourrule/stir_check');
  static const simChannel = MethodChannel('com.yours.yourcallyourrule/sim_check');

  Function(MethodCall)? onCallerIdCall;
 // Function(MethodCall)? onShouldAcceptCallCall;
 // Function(MethodCall)? onEndCallCall;
  Function(MethodCall)? onStirCall;
  Function(MethodCall)? onSimCall;
  Future<bool> Function(MethodCall)? onShouldAcceptCallCall;
  Future<String?> Function(MethodCall)? onEndCallCall;


  void initialize() {
   
    _setupCallerIdChannel();
   _setupShouldAcceptCallChannel();
  _setupEndCallChannel();
    _setupStirChannel();
    _setupSimChannel();
     
  }

  void _setupCallerIdChannel() {
    callerIdChannel.setMethodCallHandler((call) async {
        
      onCallerIdCall?.call(call);
      return null;
    });
  }


  void _setupShouldAcceptCallChannel() {
    shouldAcceptCallChannel.setMethodCallHandler((call) async {
     
      if (onShouldAcceptCallCall != null) {
        return await onShouldAcceptCallCall!(call);
      }
      return true; // 默认返回
    });
  }

  void _setupEndCallChannel() {
    endCallChannel.setMethodCallHandler((call) async {
      
      if (onEndCallCall != null) {
        return await onEndCallCall!(call);
      }
      return null; // 默认返回
    });
  }


  void _setupStirChannel() {
    stirChannel.setMethodCallHandler((call) async {
      onStirCall?.call(call);
      return null;
    });
  }

  void _setupSimChannel() {
    simChannel.setMethodCallHandler((call) async {
      onSimCall?.call(call);
      return null;
    });
  }

  Future<void> initializeCallerId() async {
    try {
      await callerIdChannel.invokeMethod('initialize');
    } on PlatformException catch (e) {
     // print('Failed to initialize CallerIdService: ${e.message}');
    }
  }


}