// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'overlay_control_handler.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// OverlayControlHandler 的 Riverpod Provider
///
/// 它的职责是创建、初始化并管理 OverlayControlHandler 实例的生命周期。
/// 它是一个独立的、自启动的服务，负责响应通话状态变化来控制浮窗的关闭。
///
/// - `@Riverpod(keepAlive: true)`: 确保这个服务在整个应用生命周期内持续运行。

@ProviderFor(overlayControlHandler)
const overlayControlHandlerProvider = OverlayControlHandlerProvider._();

/// OverlayControlHandler 的 Riverpod Provider
///
/// 它的职责是创建、初始化并管理 OverlayControlHandler 实例的生命周期。
/// 它是一个独立的、自启动的服务，负责响应通话状态变化来控制浮窗的关闭。
///
/// - `@Riverpod(keepAlive: true)`: 确保这个服务在整个应用生命周期内持续运行。

final class OverlayControlHandlerProvider
    extends
        $FunctionalProvider<
          OverlayControlHandler,
          OverlayControlHandler,
          OverlayControlHandler
        >
    with $Provider<OverlayControlHandler> {
  /// OverlayControlHandler 的 Riverpod Provider
  ///
  /// 它的职责是创建、初始化并管理 OverlayControlHandler 实例的生命周期。
  /// 它是一个独立的、自启动的服务，负责响应通话状态变化来控制浮窗的关闭。
  ///
  /// - `@Riverpod(keepAlive: true)`: 确保这个服务在整个应用生命周期内持续运行。
  const OverlayControlHandlerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'overlayControlHandlerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$overlayControlHandlerHash();

  @$internal
  @override
  $ProviderElement<OverlayControlHandler> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  OverlayControlHandler create(Ref ref) {
    return overlayControlHandler(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(OverlayControlHandler value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<OverlayControlHandler>(value),
    );
  }
}

String _$overlayControlHandlerHash() =>
    r'7e93bac24caeb4f2852259b4f1873f89987cb341';
