// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'overlay_handler.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 浮窗处理器 Provider
///
/// 这是一个简单的服务型 Provider。它的职责是创建并提供一个 OverlayHandler 的单例，
/// 并通过 `ref` 将其所需要的依赖（如配置 Provider）注入进去。
/// 这避免了在类内部手动创建 ProviderContainer 的反模式。

@ProviderFor(overlayHandler)
const overlayHandlerProvider = OverlayHandlerProvider._();

/// 浮窗处理器 Provider
///
/// 这是一个简单的服务型 Provider。它的职责是创建并提供一个 OverlayHandler 的单例，
/// 并通过 `ref` 将其所需要的依赖（如配置 Provider）注入进去。
/// 这避免了在类内部手动创建 ProviderContainer 的反模式。

final class OverlayHandlerProvider
    extends $FunctionalProvider<OverlayHandler, OverlayHandler, OverlayHandler>
    with $Provider<OverlayHandler> {
  /// 浮窗处理器 Provider
  ///
  /// 这是一个简单的服务型 Provider。它的职责是创建并提供一个 OverlayHandler 的单例，
  /// 并通过 `ref` 将其所需要的依赖（如配置 Provider）注入进去。
  /// 这避免了在类内部手动创建 ProviderContainer 的反模式。
  const OverlayHandlerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'overlayHandlerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$overlayHandlerHash();

  @$internal
  @override
  $ProviderElement<OverlayHandler> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  OverlayHandler create(Ref ref) {
    return overlayHandler(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(OverlayHandler value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<OverlayHandler>(value),
    );
  }
}

String _$overlayHandlerHash() => r'91667c19b83acd40dea4c5146e5c815b9a9f44f5';
