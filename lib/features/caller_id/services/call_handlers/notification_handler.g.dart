// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_handler.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 通知处理器 Provider
///
/// 【恢复并修正】: 这是一个 FutureProvider，因为它所创建的 NotificationHandler
/// 需要执行异步的 `initialize()` 方法来加载配置。
/// 这是您原始的、正确的设计。

@ProviderFor(notificationHandler)
const notificationHandlerProvider = NotificationHandlerProvider._();

/// 通知处理器 Provider
///
/// 【恢复并修正】: 这是一个 FutureProvider，因为它所创建的 NotificationHandler
/// 需要执行异步的 `initialize()` 方法来加载配置。
/// 这是您原始的、正确的设计。

final class NotificationHandlerProvider
    extends
        $FunctionalProvider<
          AsyncValue<NotificationHandler>,
          NotificationHandler,
          FutureOr<NotificationHandler>
        >
    with
        $FutureModifier<NotificationHandler>,
        $FutureProvider<NotificationHandler> {
  /// 通知处理器 Provider
  ///
  /// 【恢复并修正】: 这是一个 FutureProvider，因为它所创建的 NotificationHandler
  /// 需要执行异步的 `initialize()` 方法来加载配置。
  /// 这是您原始的、正确的设计。
  const NotificationHandlerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationHandlerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationHandlerHash();

  @$internal
  @override
  $FutureProviderElement<NotificationHandler> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<NotificationHandler> create(Ref ref) {
    return notificationHandler(ref);
  }
}

String _$notificationHandlerHash() =>
    r'8dc4933c28faf37d3d064541de2aa77297f3c71e';
