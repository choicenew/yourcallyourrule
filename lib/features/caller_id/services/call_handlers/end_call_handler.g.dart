// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'end_call_handler.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 结束通话处理器 Provider
///
/// 这是一个简单的服务型 Provider。它的职责是创建并提供一个 EndCallHandler 的单例，
/// 并通过 `ref` 将其所需要的依赖（CallerIdConfigRepository）注入进去。
///
/// 使用 `keepAlive: true` 确保这个单例在整个应用生命周期中都存在，
/// 因为它需要持续响应来自原生平台的调用。

@ProviderFor(endCallHandler)
const endCallHandlerProvider = EndCallHandlerProvider._();

/// 结束通话处理器 Provider
///
/// 这是一个简单的服务型 Provider。它的职责是创建并提供一个 EndCallHandler 的单例，
/// 并通过 `ref` 将其所需要的依赖（CallerIdConfigRepository）注入进去。
///
/// 使用 `keepAlive: true` 确保这个单例在整个应用生命周期中都存在，
/// 因为它需要持续响应来自原生平台的调用。

final class EndCallHandlerProvider
    extends $FunctionalProvider<EndCallHandler, EndCallHandler, EndCallHandler>
    with $Provider<EndCallHandler> {
  /// 结束通话处理器 Provider
  ///
  /// 这是一个简单的服务型 Provider。它的职责是创建并提供一个 EndCallHandler 的单例，
  /// 并通过 `ref` 将其所需要的依赖（CallerIdConfigRepository）注入进去。
  ///
  /// 使用 `keepAlive: true` 确保这个单例在整个应用生命周期中都存在，
  /// 因为它需要持续响应来自原生平台的调用。
  const EndCallHandlerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'endCallHandlerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$endCallHandlerHash();

  @$internal
  @override
  $ProviderElement<EndCallHandler> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  EndCallHandler create(Ref ref) {
    return endCallHandler(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EndCallHandler value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EndCallHandler>(value),
    );
  }
}

String _$endCallHandlerHash() => r'b735ec0efc08b0673d213b481d28e4622a02ec9d';
