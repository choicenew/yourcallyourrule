// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'should_accept_call_handler.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 是否接受来电处理器 Provider
///
/// 这是一个简单的、无状态的 Provider。它的作用是创建并提供一个
/// ShouldAcceptCallHandler 的单例。
///
/// 我们不使用 Notifier，因为这个 Handler 不管理需要被全局监听的持久状态。
/// 它的状态（StreamController）是临时的，仅用于协调单次调用。
/// keepAlive: true 确保这个单例在整个应用生命周期中都存在。

@ProviderFor(shouldAcceptCallHandler)
const shouldAcceptCallHandlerProvider = ShouldAcceptCallHandlerProvider._();

/// 是否接受来电处理器 Provider
///
/// 这是一个简单的、无状态的 Provider。它的作用是创建并提供一个
/// ShouldAcceptCallHandler 的单例。
///
/// 我们不使用 Notifier，因为这个 Handler 不管理需要被全局监听的持久状态。
/// 它的状态（StreamController）是临时的，仅用于协调单次调用。
/// keepAlive: true 确保这个单例在整个应用生命周期中都存在。

final class ShouldAcceptCallHandlerProvider
    extends
        $FunctionalProvider<
          ShouldAcceptCallHandler,
          ShouldAcceptCallHandler,
          ShouldAcceptCallHandler
        >
    with $Provider<ShouldAcceptCallHandler> {
  /// 是否接受来电处理器 Provider
  ///
  /// 这是一个简单的、无状态的 Provider。它的作用是创建并提供一个
  /// ShouldAcceptCallHandler 的单例。
  ///
  /// 我们不使用 Notifier，因为这个 Handler 不管理需要被全局监听的持久状态。
  /// 它的状态（StreamController）是临时的，仅用于协调单次调用。
  /// keepAlive: true 确保这个单例在整个应用生命周期中都存在。
  const ShouldAcceptCallHandlerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'shouldAcceptCallHandlerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$shouldAcceptCallHandlerHash();

  @$internal
  @override
  $ProviderElement<ShouldAcceptCallHandler> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ShouldAcceptCallHandler create(Ref ref) {
    return shouldAcceptCallHandler(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ShouldAcceptCallHandler value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ShouldAcceptCallHandler>(value),
    );
  }
}

String _$shouldAcceptCallHandlerHash() =>
    r'776f0cfe79f13efce3e1a9aacd98a56271979106';
