// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'live_activity_notification_manager.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(liveActivityNotificationManager)
const liveActivityNotificationManagerProvider =
    LiveActivityNotificationManagerProvider._();

final class LiveActivityNotificationManagerProvider
    extends
        $FunctionalProvider<
          LiveActivityNotificationManager,
          LiveActivityNotificationManager,
          LiveActivityNotificationManager
        >
    with $Provider<LiveActivityNotificationManager> {
  const LiveActivityNotificationManagerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'liveActivityNotificationManagerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$liveActivityNotificationManagerHash();

  @$internal
  @override
  $ProviderElement<LiveActivityNotificationManager> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  LiveActivityNotificationManager create(Ref ref) {
    return liveActivityNotificationManager(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LiveActivityNotificationManager value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LiveActivityNotificationManager>(
        value,
      ),
    );
  }
}

String _$liveActivityNotificationManagerHash() =>
    r'5b20d491361e4ac389c34d7be57a2daa3c6f5da7';
