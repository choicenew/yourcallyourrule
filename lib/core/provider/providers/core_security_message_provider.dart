import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/features/call/caller_id/providers/security_message_provider.dart';

/// Provider for the security message
/// This is a wrapper around the SecurityMessageProvider in the features directory
/// Used to provide the SecurityMessageProvider instance to the app
final coreSecurityMessageProvider = ChangeNotifierProvider<SecurityMessageProvider>(
  (ref) => SecurityMessageProvider(),
);