import 'dart:async';
import 'package:flutter/services.dart';
import 'package:pyro_sms_protocol/pyro_sms_protocol.dart';
import 'package:pyro_sms_hub/pyro_sms_hub.dart';

/// Item representing extracted OTP code with active expiration timer
class OtpCodeRecord {
  final String id;
  final String rawCode;
  final String maskedCode;
  final String sender;
  final DateTime createdAt;
  bool isExpired;

  OtpCodeRecord({
    required this.id,
    required this.rawCode,
    required this.maskedCode,
    required this.sender,
    required this.createdAt,
    this.isExpired = false,
  });
}

/// Driver for 2FA OTP code extraction, mask sanitization, auto-expire, and clipboard clearing
class OtpGuardDriver implements SmsFilterAdapter {
  static OtpGuardDriver? _instance;

  /// Self-registers this driver instance to SmsHub
  static void register() {
    _instance ??= OtpGuardDriver();
    SmsHub.instance.registerFilter(_instance!);
  }

  static void unregister() {
    _instance?.dispose();
    _instance = null;
  }

  void dispose() {
    _clipboardClearTimer?.cancel();
    _activeOtpRecords.clear();
  }

  @override
  String get providerId => 'pyro_sms_driver_otp_guard';

  @override
  String get displayName => '2FA OTP Privacy Guard';

  @override
  bool isEnabled;

  final Duration autoExpireDuration;
  final Duration clipboardClearDuration;
  final List<OtpCodeRecord> _activeOtpRecords = [];
  Timer? _clipboardClearTimer;

  OtpGuardDriver({
    this.isEnabled = true,
    this.autoExpireDuration = const Duration(minutes: 5),
    this.clipboardClearDuration = const Duration(minutes: 5),
  });

  /// Extracts 4-8 digit OTP codes from SMS body
  String? extractOtpCode(String text) {
    final otpRegex = RegExp(
      r'\b([0-9]{4,8})\b',
      caseSensitive: false,
    );
    final match = otpRegex.firstMatch(text);
    return match?.group(1);
  }

  /// Sanitizes/masks OTP code e.g. "849201" -> "84****"
  String maskOtpCode(String code) {
    if (code.length <= 2) return '**';
    return '${code.substring(0, 2)}${'*' * (code.length - 2)}';
  }

  /// Sanitize entire SMS body masking the OTP code
  String sanitizeSmsBody(String body) {
    final code = extractOtpCode(body);
    if (code == null) return body;
    final masked = maskOtpCode(code);
    return body.replaceAll(code, masked);
  }

  @override
  Future<SmsScreeningResult?> screenMessage(SmsMessageEntity message) async {
    if (!isEnabled) return null;

    final code = extractOtpCode(message.body);
    if (code != null) {
      final masked = maskOtpCode(code);
      final record = OtpCodeRecord(
        id: message.id,
        rawCode: code,
        maskedCode: masked,
        sender: message.sender,
        createdAt: DateTime.now(),
      );
      _activeOtpRecords.add(record);

      Timer(autoExpireDuration, () {
        record.isExpired = true;
        _activeOtpRecords.removeWhere((r) => r.id == message.id);
      });
    }

    return null;
  }

  /// Copies raw OTP code to clipboard and schedules auto-clear timer
  Future<void> copyOtpAndScheduleClear(String otpCode) async {
    await Clipboard.setData(ClipboardData(text: otpCode));

    _clipboardClearTimer?.cancel();
    _clipboardClearTimer = Timer(clipboardClearDuration, () async {
      await Clipboard.setData(const ClipboardData(text: ''));
    });
  }

  List<OtpCodeRecord> getActiveRecords() =>
      _activeOtpRecords.where((r) => !r.isExpired).toList();
}
