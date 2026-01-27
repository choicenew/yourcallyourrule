import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plugindemo/core/router/app_router.dart';

/// AppRouter的Riverpod Provider
final appRouterProvider = Provider<AppRouter>((ref) {
  return AppRouter();
});
