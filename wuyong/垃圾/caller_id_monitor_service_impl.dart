import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

import 'call_channel_adapter.dart';
import 'call_channel_manager.dart';
import '../../lib/domain/entities/call/call_log.dart';
import '../../lib/domain/entities/call/caller_id_data.dart';
import '../../lib/domain/entities/call/stir_info.dart';
import '../../lib/domain/entities/call/sim_info.dart';
import '../../lib/domain/value_objects/phone_number.dart';
import '../../lib/domain/value_objects/rule_action.dart';
import '../../lib/infrastructure/services/base_service_impl.dart';
import '../../lib/infrastructure/services/notification_service_impl.dart';
import 'call_overlay_service_impl.dart';
import 'caller_id_service_impl.dart';
import 'should_accept_service_impl.dart';

/// Caller ID Monitor Service Implementation
/// Responsible for monitoring incoming calls and processing them
class CallerIdMonitorServiceImpl extends BaseServiceImpl {
  final CallerIdServiceImpl _callerIdService;
  final CallChannel _callChannel;
  final ShouldAcceptServiceImpl _shouldAcceptService;
  final CallOverlayServiceImpl _callOverlayService;
  final NotificationServiceImpl _notificationService;
  
  StreamSubscription? _callSubscription;
  StreamSubscription? _stirInfoSubscription;
  StreamSubscription? _simInfoSubscription;
  bool _isMonitoring = false;
  
  // Store the latest STIR and SIM information
  StirInfo? _lastStirInfo;
  SimInfo? _lastSimInfo;
  
  // Notification settings
  bool _useLocalNotification = false;
  bool _cancelLocalNotification = false;
  bool _useStirNotification = false;
  
  static const String callLocalNotificationKey = 'call_local_notification';
  static const String callCancelLocalNotificationKey = 'call_cancel_local_notification';
  static const String stirLocalNotificationKey = 'stir_local_notification';
  
  CallerIdMonitorServiceImpl(
    this._callerIdService,
    this._callChannel,
    this._shouldAcceptService,
    this._callOverlayService,
    this._notificationService,
  );
  
  /// Start monitoring incoming calls
  Future<void> startMonitoring() async {
    if (_isMonitoring) return;
    
    try {
      await _callChannel.initialize();
      await _shouldAcceptService.initialize();
      await _callOverlayService.initialize();
      await _notificationService.initialize();
      await _loadSettings();
      
      _callSubscription = _callChannel.callStream.listen(_handleIncomingCall);
      _stirInfoSubscription = _callChannel.stirInfoStream.listen(_handleStirInfo);
      _simInfoSubscription = _callChannel.simInfoStream.listen(_handleSimInfo);
      _isMonitoring = true;
      
      logOperation('Started call monitoring');
    } catch (e) {
      logOperation('Failed to start call monitoring', details: e.toString());
      rethrow;
    }
  }
  
  /// Stop monitoring incoming calls
  Future<void> stopMonitoring() async {
    if (!_isMonitoring) return;
    
    await _callSubscription?.cancel();
    await _stirInfoSubscription?.cancel();
    await _simInfoSubscription?.cancel();
    _callSubscription = null;
    _stirInfoSubscription = null;
    _simInfoSubscription = null;
    _isMonitoring = false;
    
    logOperation('Stopped call monitoring');
  }
  
  /// Load settings from SharedPreferences
  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _useLocalNotification = prefs.getBool(callLocalNotificationKey) ?? false;
    _cancelLocalNotification = prefs.getBool(callCancelLocalNotificationKey) ?? false;
    _useStirNotification = prefs.getBool(stirLocalNotificationKey) ?? false;
    
    logOperation('Settings loaded');
  }
  
  /// Set whether to use local notifications
  Future<void> setUseLocalNotification(bool useLocal) async {
    if (_useLocalNotification == useLocal) return;
    
    _useLocalNotification = useLocal;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(callLocalNotificationKey, useLocal);
    
    logOperation('Local notification setting updated', details: useLocal ? 'enabled' : 'disabled');
  }
  
  /// Set whether to cancel local notifications
  Future<void> closeLocalNotification(bool cancelLocal) async {
    if (_cancelLocalNotification == cancelLocal) return;
    
    _cancelLocalNotification = cancelLocal;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(callCancelLocalNotificationKey, cancelLocal);
    
    logOperation('Cancel local notification setting updated', details: cancelLocal ? 'enabled' : 'disabled');
  }
  
  /// Set whether to use STIR notifications
  Future<void> setUseStirNotification(bool useStir) async {
    if (_useStirNotification == useStir) return;
    
    _useStirNotification = useStir;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(stirLocalNotificationKey, useStir);
    
    logOperation('STIR notification setting updated', details: useStir ? 'enabled' : 'disabled');
  }
  
  /// Handle incoming call
  void _handleIncomingCall(CallEvent event) {
    if (event.state != 'ringing') return;
    
    logOperation('Incoming call received', details: '${event.phoneNumber}');
    
    // Use async operation without returning Future
    _processIncomingCall(event);
  }
  
  /// Handle STIR information
  void _handleStirInfo(StirInfo stirInfo) {
    _lastStirInfo = stirInfo;
    logOperation('STIR information received', details: 'Number: ${stirInfo.phoneNumber}, Status: ${_getStirStatusText(stirInfo)}');
    
    if (_useStirNotification) {
      _showStirNotification(stirInfo);
    }
  }
  
  /// Handle SIM card information
  void _handleSimInfo(SimInfo simInfo) {
    _lastSimInfo = simInfo;
    logOperation('SIM information received', details: 'Carrier: ${simInfo.carrierName}, Country: ${simInfo.countryIso}');
  }
  
  /// Process incoming call asynchronously
  Future<void> _processIncomingCall(CallEvent event) async {
    // Identify caller
    final callerIdData = await _callerIdService.identifyCaller(event.phoneNumber);
    
    // Determine if call should be accepted
    final shouldAccept = await _shouldAcceptCall(event.phoneNumber);
    
    if (shouldAccept) {
      // Show caller ID overlay
      final styleProvider = await _getCallerIdStyleProvider();
      await _callOverlayService.showCallerIdOverlay(
        callerIdData: callerIdData,
        stirInfo: _lastStirInfo,
        simInfo: _lastSimInfo,
        styleProvider: styleProvider,
      );
    } else {
      // Reject call
      await _callChannel.rejectCall(event.phoneNumber);
      
      // Show notification if enabled
      if (_useLocalNotification) {
        await _showBlockedCallNotification(event.phoneNumber);
        
        if (_cancelLocalNotification) {
          await Future.delayed(const Duration(seconds: 5));
          await _notificationService.cancelNotification(0);
        }
      }
    }
    
    // Record call log
    final callLog = CallLog(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      phoneNumber: PhoneNumber(event.phoneNumber),
      name: callerIdData.name,
      source: 'incoming_monitor',
      timestamp: DateTime.now(),
      duration: 0,
      type: shouldAccept ? 'accepted' : 'blocked',
      status: 'ringing',
    );
    
    await _callerIdService.logCall(callLog);
    
    logOperation('Call processing completed', details: event.phoneNumber);
  }
  
  /// Determine if a call should be accepted
  Future<bool> _shouldAcceptCall(String phoneNumber) async {
    try {
      // Parse phone number to get different formats
      final parsedData = await _parsePhoneNumber(phoneNumber);
      final e164Number = parsedData['e164Number'] ?? '';
      final nationalNumber = parsedData['nationalNumber'] ?? '';
      
      // Test all number formats
      final numbersToTest = [
        phoneNumber,
        nationalNumber,
        e164Number
      ].where((s) => s.isNotEmpty).toList();
      
      // Check each number format against rules
      for (final number in numbersToTest) {
        final result = await _shouldAcceptService.shouldAcceptCall(number);
        if (result) {
          logOperation('Call accepted', details: number);
          return true;
        }
      }
      
      logOperation('Call rejected', details: phoneNumber);
      return false;
    } catch (e) {
      logOperation('Error in shouldAcceptCall', details: e.toString());
      return true; // Default to accepting calls on error
    }
  }
  
  /// Parse phone number to get different formats
  Future<Map<String, String>> _parsePhoneNumber(String phoneNumber) async {
    // In a real implementation, this would use a phone number parsing library
    return {
      'e164Number': phoneNumber,
      'nationalNumber': phoneNumber,
    };
  }
  
  /// Show STIR notification
  Future<void> _showStirNotification(StirInfo stirInfo) async {
    String title = 'Call Verification';
    String body = '';
    
    if (stirInfo.isVerified) {
      body = '${stirInfo.phoneNumber} is verified by STIR';
    } else if (stirInfo.isNotVerified) {
      body = '${stirInfo.phoneNumber} is not verified by STIR';
    } else if (stirInfo.isFailed) {
      body = '${stirInfo.phoneNumber} failed STIR verification';
    } else {
      body = '${stirInfo.phoneNumber} has unknown STIR verification status';
    }
    
    await _notificationService.showNotification(
      id: 1,
      title: title,
      body: body,
      payload: 'stir_info',
    );
    
    if (_cancelLocalNotification) {
      await Future.delayed(const Duration(seconds: 5));
      await _notificationService.cancelNotification(1);
    }
  }
  
  /// Show blocked call notification
  Future<void> _showBlockedCallNotification(String phoneNumber) async {
    await _notificationService.showNotification(
      id: 0,
      title: 'Call Blocked',
      body: 'Blocked call from $phoneNumber',
      payload: 'blocked_call',
    );
  }
  
  /// Get STIR status text
  String _getStirStatusText(StirInfo stirInfo) {
    if (stirInfo.isVerified) return 'Verified';
    if (stirInfo.isNotVerified) return 'Not Verified';
    if (stirInfo.isFailed) return 'Verification Failed';
    return 'Unknown';
  }
  
  /// Get caller ID style provider
  Future<CallerIdStyleProvider> _getCallerIdStyleProvider() async {
    // In a real implementation, this would load from settings
    return CallerIdStyleProvider(
      windowWidth: 300,
      windowHeight: 200,
    );
  }
  
  /// Get the latest STIR information
  StirInfo? getLastStirInfo() {
    return _lastStirInfo;
  }
  
  /// Get the latest SIM card information
  SimInfo? getLastSimInfo() {
    return _lastSimInfo;
  }
  
  /// Check if monitoring is active
  bool isMonitoring() {
    return _isMonitoring;
  }
  
  /// Release resources
  Future<void> dispose() async {
    await stopMonitoring();
    await _callOverlayService.dispose();
    await _shouldAcceptService.dispose();
    logOperation('Resources released');
  }
}

/// 通话事件
class CallEvent {
  final String phoneNumber;
  final String state;
  
  CallEvent({
    required this.phoneNumber,
    required this.state,
  });
}