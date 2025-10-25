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
/// 它遵循与 callEventListenerProvider 完全相同的成功模式，以确保初始化的稳定性和可靠性。
///
/// - `@Riverpod(keepAlive: true)`: 确保这个服务在整个应用生命周期内持续运行，不会被意外销毁。

@ProviderFor(overlayControlHandler)
const overlayControlHandlerProvider = OverlayControlHandlerProvider._();

/// OverlayControlHandler 的 Riverpod Provider
///
/// 它的职责是创建、初始化并管理 OverlayControlHandler 实例的生命周期。
/// 它遵循与 callEventListenerProvider 完全相同的成功模式，以确保初始化的稳定性和可靠性。
///
/// - `@Riverpod(keepAlive: true)`: 确保这个服务在整个应用生命周期内持续运行，不会被意外销毁。

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
  /// 它遵循与 callEventListenerProvider 完全相同的成功模式，以确保初始化的稳定性和可靠性。
  ///
  /// - `@Riverpod(keepAlive: true)`: 确保这个服务在整个应用生命周期内持续运行，不会被意外销毁。
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
    r'02877d375a36780043a462807c83f5c152cbef34';
