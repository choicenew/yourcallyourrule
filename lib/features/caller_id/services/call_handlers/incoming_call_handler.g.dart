// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'incoming_call_handler.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 来电处理器 Provider
///
/// 这是一个服务型 Provider，负责创建并提供一个 IncomingCallHandler 的单例。
/// 它是一个高层级的业务流程编排器，通过 `ref` 将所有它需要的、更底层的服务
/// （如 CallHandler, CallFilterService 等）注入进来。
///
/// 【修正】这是一个异步 Provider，因为它依赖于一个或多个 FutureProvider (如 NotificationHandler)。
/// 它的创建过程是异步的，使用它的地方需要 `await` 它的 `.future`。

@ProviderFor(incomingCallHandler)
const incomingCallHandlerProvider = IncomingCallHandlerProvider._();

/// 来电处理器 Provider
///
/// 这是一个服务型 Provider，负责创建并提供一个 IncomingCallHandler 的单例。
/// 它是一个高层级的业务流程编排器，通过 `ref` 将所有它需要的、更底层的服务
/// （如 CallHandler, CallFilterService 等）注入进来。
///
/// 【修正】这是一个异步 Provider，因为它依赖于一个或多个 FutureProvider (如 NotificationHandler)。
/// 它的创建过程是异步的，使用它的地方需要 `await` 它的 `.future`。

final class IncomingCallHandlerProvider
    extends
        $FunctionalProvider<
          AsyncValue<IncomingCallHandler>,
          IncomingCallHandler,
          FutureOr<IncomingCallHandler>
        >
    with
        $FutureModifier<IncomingCallHandler>,
        $FutureProvider<IncomingCallHandler> {
  /// 来电处理器 Provider
  ///
  /// 这是一个服务型 Provider，负责创建并提供一个 IncomingCallHandler 的单例。
  /// 它是一个高层级的业务流程编排器，通过 `ref` 将所有它需要的、更底层的服务
  /// （如 CallHandler, CallFilterService 等）注入进来。
  ///
  /// 【修正】这是一个异步 Provider，因为它依赖于一个或多个 FutureProvider (如 NotificationHandler)。
  /// 它的创建过程是异步的，使用它的地方需要 `await` 它的 `.future`。
  const IncomingCallHandlerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'incomingCallHandlerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$incomingCallHandlerHash();

  @$internal
  @override
  $FutureProviderElement<IncomingCallHandler> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<IncomingCallHandler> create(Ref ref) {
    return incomingCallHandler(ref);
  }
}

String _$incomingCallHandlerHash() =>
    r'250ddfa364336ee1e8af293ae9e8e8c7029db80a';
