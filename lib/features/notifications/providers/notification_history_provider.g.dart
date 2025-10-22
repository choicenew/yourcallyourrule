// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_history_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 通知历史状态 Provider
/// 职责：提供一个只读的、可被UI监听的通知历史列表。

@ProviderFor(notificationHistory)
const notificationHistoryProvider = NotificationHistoryProvider._();

/// 通知历史状态 Provider
/// 职责：提供一个只读的、可被UI监听的通知历史列表。

final class NotificationHistoryProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<NotificationItem>>,
          List<NotificationItem>,
          FutureOr<List<NotificationItem>>
        >
    with
        $FutureModifier<List<NotificationItem>>,
        $FutureProvider<List<NotificationItem>> {
  /// 通知历史状态 Provider
  /// 职责：提供一个只读的、可被UI监听的通知历史列表。
  const NotificationHistoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationHistoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationHistoryHash();

  @$internal
  @override
  $FutureProviderElement<List<NotificationItem>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<NotificationItem>> create(Ref ref) {
    return notificationHistory(ref);
  }
}

String _$notificationHistoryHash() =>
    r'fda1f094640e655032b218ad1d97fb1d528df41d';
