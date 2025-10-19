// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'outgoing_call_handler.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 去电处理器 Provider
///
/// 这是一个简单的服务型 Provider。它的职责是创建并提供一个 OutgoingCallHandler 的单例，
/// 并通过 `ref` 将其所需要的核心依赖（`CallHandler`）注入进去。
///
/// 使用 `keepAlive: true` 确保这个单例在整个应用生命周期中都存在，
/// 以便能够随时处理去电事件。

@ProviderFor(outgoingCallHandler)
const outgoingCallHandlerProvider = OutgoingCallHandlerProvider._();

/// 去电处理器 Provider
///
/// 这是一个简单的服务型 Provider。它的职责是创建并提供一个 OutgoingCallHandler 的单例，
/// 并通过 `ref` 将其所需要的核心依赖（`CallHandler`）注入进去。
///
/// 使用 `keepAlive: true` 确保这个单例在整个应用生命周期中都存在，
/// 以便能够随时处理去电事件。

final class OutgoingCallHandlerProvider
    extends
        $FunctionalProvider<
          OutgoingCallHandler,
          OutgoingCallHandler,
          OutgoingCallHandler
        >
    with $Provider<OutgoingCallHandler> {
  /// 去电处理器 Provider
  ///
  /// 这是一个简单的服务型 Provider。它的职责是创建并提供一个 OutgoingCallHandler 的单例，
  /// 并通过 `ref` 将其所需要的核心依赖（`CallHandler`）注入进去。
  ///
  /// 使用 `keepAlive: true` 确保这个单例在整个应用生命周期中都存在，
  /// 以便能够随时处理去电事件。
  const OutgoingCallHandlerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'outgoingCallHandlerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$outgoingCallHandlerHash();

  @$internal
  @override
  $ProviderElement<OutgoingCallHandler> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  OutgoingCallHandler create(Ref ref) {
    return outgoingCallHandler(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(OutgoingCallHandler value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<OutgoingCallHandler>(value),
    );
  }
}

String _$outgoingCallHandlerHash() =>
    r'2d1be458a31e353f7053ea1253fe6ac1b938c2bc';
