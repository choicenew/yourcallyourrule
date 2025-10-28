import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yourcallyourrule/core/router/app_router.dart';

part 'app_router_provider.g.dart';

/// AppRouter的Riverpod Provider
///
/// 使用 `@riverpod` 注解可以自动生成 Provider。
/// `keepAlive: true` 确保路由器实例在整个应用的生命周期中都存在，不会被意外销毁。
/// 这是一个简单的 Provider，因为它只负责创建和提供一个无依赖的 AppRouter 实例。
@Riverpod(keepAlive: true)
AppRouter appRouter(Ref ref) {
  // [重构]: Provider 的构建方法现在极其简单，
  // 它只需要创建并返回一个无依赖的 AppRouter 实例。
  return AppRouter();
}