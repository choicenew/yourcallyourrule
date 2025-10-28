// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_router_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// AppRouter的Riverpod Provider
///
/// 使用 `@riverpod` 注解可以自动生成 Provider。
/// `keepAlive: true` 确保路由器实例在整个应用的生命周期中都存在，不会被意外销毁。
/// 这是一个简单的 Provider，因为它只负责创建和提供一个无依赖的 AppRouter 实例。

@ProviderFor(appRouter)
const appRouterProvider = AppRouterProvider._();

/// AppRouter的Riverpod Provider
///
/// 使用 `@riverpod` 注解可以自动生成 Provider。
/// `keepAlive: true` 确保路由器实例在整个应用的生命周期中都存在，不会被意外销毁。
/// 这是一个简单的 Provider，因为它只负责创建和提供一个无依赖的 AppRouter 实例。

final class AppRouterProvider
    extends $FunctionalProvider<AppRouter, AppRouter, AppRouter>
    with $Provider<AppRouter> {
  /// AppRouter的Riverpod Provider
  ///
  /// 使用 `@riverpod` 注解可以自动生成 Provider。
  /// `keepAlive: true` 确保路由器实例在整个应用的生命周期中都存在，不会被意外销毁。
  /// 这是一个简单的 Provider，因为它只负责创建和提供一个无依赖的 AppRouter 实例。
  const AppRouterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appRouterProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appRouterHash();

  @$internal
  @override
  $ProviderElement<AppRouter> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AppRouter create(Ref ref) {
    return appRouter(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppRouter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppRouter>(value),
    );
  }
}

String _$appRouterHash() => r'ccde8baa9931259ce70cb1e422bda7d5a0116ccb';
