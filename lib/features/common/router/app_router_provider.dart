import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'app_router.dart';

part 'app_router_provider.g.dart';

@Riverpod(keepAlive: true)
Object appRouter(Ref ref) {
  return AppRouter();
}
