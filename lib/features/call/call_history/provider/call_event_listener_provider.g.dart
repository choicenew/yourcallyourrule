// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'call_event_listener_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// CallEventListenerService 的 Riverpod Provider
///
/// 这是一个异步 Provider，因为它依赖于同样是异步的 `callerIdMonitorServiceProvider`。
/// 它的职责是创建并初始化 `CallEventListenerService`，这个服务是应用中用于监听
/// 和响应通话事件（如记录通话日志）的顶层服务。
///
/// 使用 `@Riverpod` 注解和 `keepAlive: true` 来确保服务在应用启动后持续运行。

@ProviderFor(callEventListener)
const callEventListenerProvider = CallEventListenerProvider._();

/// CallEventListenerService 的 Riverpod Provider
///
/// 这是一个异步 Provider，因为它依赖于同样是异步的 `callerIdMonitorServiceProvider`。
/// 它的职责是创建并初始化 `CallEventListenerService`，这个服务是应用中用于监听
/// 和响应通话事件（如记录通话日志）的顶层服务。
///
/// 使用 `@Riverpod` 注解和 `keepAlive: true` 来确保服务在应用启动后持续运行。

final class CallEventListenerProvider
    extends
        $FunctionalProvider<
          AsyncValue<CallEventListenerService>,
          CallEventListenerService,
          FutureOr<CallEventListenerService>
        >
    with
        $FutureModifier<CallEventListenerService>,
        $FutureProvider<CallEventListenerService> {
  /// CallEventListenerService 的 Riverpod Provider
  ///
  /// 这是一个异步 Provider，因为它依赖于同样是异步的 `callerIdMonitorServiceProvider`。
  /// 它的职责是创建并初始化 `CallEventListenerService`，这个服务是应用中用于监听
  /// 和响应通话事件（如记录通话日志）的顶层服务。
  ///
  /// 使用 `@Riverpod` 注解和 `keepAlive: true` 来确保服务在应用启动后持续运行。
  const CallEventListenerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'callEventListenerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$callEventListenerHash();

  @$internal
  @override
  $FutureProviderElement<CallEventListenerService> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<CallEventListenerService> create(Ref ref) {
    return callEventListener(ref);
  }
}

String _$callEventListenerHash() => r'55ecca4c180ea7cbe963818988fb555db92fe595';
