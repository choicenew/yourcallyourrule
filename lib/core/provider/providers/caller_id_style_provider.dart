import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/features/call/caller_id/providers/caller_id_style_provider.dart';

/// CallerIdStyleProvider的Riverpod Provider
/// 用于在应用中提供CallerIdStyleProvider的实例
final callerIdStyleProvider = ChangeNotifierProvider<CallerIdStyleProvider>((ref) {
  return CallerIdStyleProvider();
});